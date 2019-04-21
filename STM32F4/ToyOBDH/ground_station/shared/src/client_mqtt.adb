------------------------------------------------------------------------------
--                                                                          --
--  Copyright (C) 2017-2018 Universidad PolitÃ©cnica de Madrid              --
--                                                                          --
--  Redistribution and use in source and binary forms, with or without      --
--  modification, are permitted provided that the following conditions are  --
--  met:                                                                    --
--     1. Redistributions of source code must retain the above copyright    --
--        notice, this list of conditions and the following disclaimer.     --
--     2. Redistributions in binary form must reproduce the above copyright --
--        notice, this list of conditions and the following disclaimer in   --
--        the documentation and/or other materials provided with the        --
--        distribution.                                                     --
--     3. Neither the name of the copyright holder nor the names of its     --
--        contributors may be used to endorse or promote products derived   --
--        from this software without specific prior written permission.     --
--                                                                          --
--   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS    --
--   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT      --
--   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR  --
--   A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT   --
--   HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, --
--   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT       --
--   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,  --
--   DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY  --
--   THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT    --
--   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE  --
--   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.   --
--                                                                          --
-------------------------------------------------------------------------------

-- Author: Antonio Ramos Nieto
-- Implementation of MQTT Client
-- MQTT messages are exchanged over a TCP interface


with Ada.Text_IO;
with Ada.Streams; use Ada.Streams;
with AWS.Net.Buffered;
with AWS.Client.HTTP_Utils; use AWS;

package body client_mqtt is

   
   ---------------------
   -- Subscriber Task --
   ---------------------
      
   task body Subscriber_Task is
      Data    : Stream_Element_Array (1..1024);
      Size    : Stream_Element_Offset;
      Ret     : Unbounded_String;
      Expected_MQTT : Unbounded_String;
      Socket : Net.Socket_Type'Class:= Net.Socket(Security);
   begin
      accept Start_Subscriber_Task (InConnection : in out Connection_MQTT; Subscribe_Param : in Subscribe_Parameters) do
         Expected_MQTT := Character'Val(16#30#) &  --Message with topic and exècted message
           Character'Val(2+To_String(Subscribe_Param.Topic)'Length+To_String(Subscribe_Param.Expected_Message)'Length) &
           Character'Val(16#00#) &
           Character'Val(To_String(Subscribe_Param.Topic)'Length) &
           Subscribe_Param.Topic &
           To_String(Subscribe_Param.Expected_Message);
         Socket := Client.Get_Socket(InConnection.Connection).all;
         
      end Start_Subscriber_Task;
      loop --Read and compare with the expected MQTT message
            delay 0.01;
            Net.Buffered.Read(Socket,Data,Size);
            if (size > 4) then 
               for i in 1 .. Size loop
                  Ret := Ret & Character'Val(Data(i));
               end loop;
               if(To_String(Expected_MQTT) = To_String(Ret)) then
                  Ada.Text_IO.Put_Line ("Subscriber Message");
                  Control_Subscriber.Set_ReceivedMQTT(True);
               end if;
            end if;
            Ret := To_Unbounded_String("");
         end loop;
      
   end Subscriber_Task;
   

   ------------------
   -- Connect MQTT --
   ------------------

   procedure ConnectMQTT (This : in out Connection_MQTT; Parameters : in Connection_Parameters ) is
      Client_ID : String := To_String(Parameters.Client_ID);
      Username : String := To_String(Parameters.Username);
      Password : String := To_String(Parameters.Password);
      URL : Unbounded_String;
      CIDLen : UTF_8_String :=
        Character'Val(16#00#) &  --CIDLEN
        Character'Val(Client_ID'Length);
      ULen : UTF_8_String :=
        Character'Val(16#00#) &  --ULEN
        Character'Val(Username'Length);
      PLen : UTF_8_String :=
        Character'Val(16#00#) &  --PLEN
        Character'Val(Password'Length);
      Connect : UTF_8_String :=
        Mqtt_Conn &
        Character'Val(Conn_header'Length + CIDLen'Length + Client_ID'Length + ULen'Length + Username'Length + PLen'Length + Password'Length) &
        Conn_header & CIDLen & Client_ID & ULen & Username & PLen & Password;

      Data    : Stream_Element_Array (1..1024);
      Size    : Stream_Element_Offset;
      Ret     : Unbounded_String;
      Except : exception;

   begin
      This.Secure := Security;
      if(Security) then
         URL := "https://" & Parameters.Host & ":" & Parameters.Port;
      else
         URL := "http://" & Parameters.Host & ":" & Parameters.Port;
      end if;
      Ada.Text_IO.Put_Line ("Connecting to " & To_String(URL) & " ...");
      
      -- Open a TCP connection to the host
      Client.Create (This.Connection,To_String(URL),Persistent  => True);
      Client.HTTP_Utils.Connect(This.Connection);

      -- Prepare stream to accept incoming data and push the
      -- MQTT connection
      Net.Buffered.Put(Client.Get_Socket(This.Connection).all,Connect);
      Net.Buffered.Flush(Client.Get_Socket(This.Connection).all);

      -- Read the Socket and test if the connection have been accepted
      Net.Buffered.Read(Client.Get_Socket(This.Connection).all,Data,Size);
      for i in 1 .. Size loop
         Ret := Ret & Character'Val(Data(i));
      end loop;
      if Connection_Acepted = To_String(Ret) then
         Ada.Text_IO.Put_Line ("MQTT connection acepted");
      else
         raise Except with "MQTT CONNECTION NOT ACEPTED";
      end if;

   end ConnectMQTT;
   
   
   ------------------
   -- Publish MQTT --
   ------------------

   procedure PublishMQTT (This : in out Connection_MQTT; Parameters : in Publish_Parameters) is
      Topic : String := To_String(Parameters.Topic);
      Message : String := To_String(Parameters.Message);
      Pub_header: UTF_8_String :=
        Character'Val(16#00#) &  --TPLEN
        Character'Val(Topic'Length);
      Publish : UTF_8_String :=
        Mqtt_Pub &
        Character'Val(Pub_header'Length + Topic'Length + Message'Length) &
        Pub_header & Topic & Message;

   begin
      -- Write in the socket the publish message and flush it
      Net.Buffered.Put(Client.Get_Socket(This.Connection).all,Publish);
      Net.Buffered.Flush(Client.Get_Socket(This.Connection).all);


   end PublishMQTT;
   
   
   --------------------
   -- Subscribe MQTT --
   --------------------
   
   procedure SubscribeMQTT (This : in out Connection_MQTT; Parameters : in Subscribe_Parameters) is
      Topic : String := To_String(Parameters.Topic);
      Sub_header: UTF_8_String :=
        Parameters.Packet_ID &
        Character'Val(16#00#) &  --TPLEN
        Character'Val(Topic'Length);
      Subscribe : UTF_8_String :=
        Mqtt_Sub &
        Character'Val(Sub_header'Length + Topic'Length + 1) &
        Sub_header &
        Topic &
        Parameters.QoS;
      Subscriber_Ack : UTF_8_String := 
        Character'Val(16#90#) &  --Response if the client is subscribed
        Character'Val(16#03#) &
        Parameters.Packet_ID &
        Parameters.QoS;
      Data    : Stream_Element_Array (1..1024);
      Size    : Stream_Element_Offset;
      Ret     : Unbounded_String;
      Except : exception;
      
   begin
      -- Write in the socket the subscribe message and flush it
      Net.Buffered.Put(Client.Get_Socket(This.Connection).all,Subscribe);
      Net.Buffered.Flush(Client.Get_Socket(This.Connection).all);

      -- Read from the socket and check if the client has subscribed succesfully
      Net.Buffered.Read(Client.Get_Socket(This.Connection).all,Data,Size);
      for i in 1 .. Size loop
         Ret := Ret & Character'Val(Data(i));
      end loop;
      if Subscriber_Ack = To_String(Ret) then
         Ada.Text_IO.Put_Line ("MQTT Subscribed to "&Topic&" properly");
      else
         raise Except with "MQTT SUBSCRIPTION FAILED";
      end if;
      Sub_task.Start_Subscriber_Task( This, Parameters);
      
   end SubscribeMQTT;
   
   
   
   ------------------------
   -- Control Subscriber --
   ------------------------
   
   -- It allows to change ReceivedMQTT
   protected body Control_Subscriber is
      procedure Set_ReceivedMQTT(set : in Boolean) is
      begin
         ReceivedMQTT := set;
      end Set_ReceivedMQTT;
      procedure Read_ReceivedMQTT(leer : out Boolean) is
      begin
         leer := ReceivedMQTT;
         Set_ReceivedMQTT(False);
      end Read_ReceivedMQTT;
   end Control_Subscriber;
   


end client_mqtt;
