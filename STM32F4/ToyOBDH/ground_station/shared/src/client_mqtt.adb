
with Ada.Text_IO;
with Ada.Streams; use Ada.Streams;
with AWS.Net.Buffered;
with AWS.Client.HTTP_Utils; use AWS;

package body client_mqtt is

   
  
      
   task body Subscriber_Task is
      Data    : Stream_Element_Array (1..1024);
      Size    : Stream_Element_Offset;
      Ret     : Unbounded_String;
      Expected_MQTT : Unbounded_String;
      Socket : Net.Socket_Type'Class:= Net.Socket(Security);
   begin
      accept Start_Subscriber_Task (InConnection : in out Connection_MQTT; Subscribe_Param : in Subscribe_Parameters) do
         Expected_MQTT := Character'Val(16#30#) &
           Character'Val(2+To_String(Subscribe_Param.Topic)'Length+To_String(Subscribe_Param.Expected_Message)'Length) &
           Character'Val(16#00#) &
           Character'Val(To_String(Subscribe_Param.Topic)'Length) &
           Subscribe_Param.Topic &
           To_String(Subscribe_Param.Expected_Message);
         Socket := Client.Get_Socket(InConnection.Connection).all;
         
      end Start_Subscriber_Task;
      loop
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
   


   procedure ConnectMQTT (This : in out Connection_MQTT; Parameters : in Connection_Parameters ) is
      
      Client_ID : constant String := To_String(Parameters.Client_ID);
      Username : constant String := To_String(Parameters.Username);
      Password : constant String := To_String(Parameters.Password);
      URL : Unbounded_String;
      
      Mqtt_Conn : constant Character :=
        Character'Val(16#10#);
      Conn_header: constant UTF_8_String :=
        Character'Val(16#00#) &  --PLEN
        Character'Val(16#06#) &
        Character'Val(16#4D#) &  --MQlsdp
        Character'Val(16#51#) &
        Character'Val(16#49#) &
        Character'Val(16#73#) &
        Character'Val(16#64#) &
        Character'Val(16#70#) &
        Character'Val(16#03#) &  --LVL
        Character'Val(16#C2#) &  --FL
        Character'Val(16#00#) &  --KA
        Character'Val(16#3C#);
      CIDLen : constant UTF_8_String :=
        Character'Val(16#00#) &  --CIDLEN
        Character'Val(Client_ID'Length);
      ULen : constant UTF_8_String :=
        Character'Val(16#00#) &  --ULEN
        Character'Val(Username'Length);
      PLen : constant UTF_8_String :=
        Character'Val(16#00#) &  --PLEN
        Character'Val(Password'Length);
      Connect : constant UTF_8_String :=
        Mqtt_Conn &
        Character'Val(Conn_header'Length + CIDLen'Length + Client_ID'Length + ULen'Length + Username'Length + PLen'Length + Password'Length) &
        Conn_header &
        CIDLen &
        Client_ID &
        ULen &
        Username &
        PLen &
        Password;


      Data    : Stream_Element_Array (1..1024);
      Size    : Stream_Element_Offset;
      Ret     : Unbounded_String;
      Connection_Acepted : constant UTF_8_String :=
        Character'Val(16#20#) &
        Character'Val(16#02#) &
        Character'Val(16#00#) &
        Character'Val(16#00#);
      Except : exception;

   begin
      This.Secure := Security;
      
      if(Security) then
         URL := "https://" & Parameters.Host & ":" & Parameters.Port;
      else
         URL := "http://" & Parameters.Host & ":" & Parameters.Port;
      end if;
      
      
      Ada.Text_IO.Put_Line (To_String(URL));
      -- Open a TCP connection to the host
      Client.Create (This.Connection,To_String(URL),Persistent  => True);
      Client.HTTP_Utils.Connect(This.Connection);

      -- Prepare stream to accept incoming data and push the
      -- MQTT connection
      Net.Buffered.Put(Client.Get_Socket(This.Connection).all,Connect);
      Net.Buffered.Flush(Client.Get_Socket(This.Connection).all);

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

   procedure PublishMQTT (This : in out Connection_MQTT; Parameters : in Publish_Parameters) is
      Topic : constant String := To_String(Parameters.Topic);
      Message : constant String := To_String(Parameters.Message);
      Mqtt_Pub : constant Character :=
        Character'Val(16#30#);
      Pub_header: constant UTF_8_String :=
        Character'Val(16#00#) &  --TPLEN
        Character'Val(Topic'Length);
      Publish : constant UTF_8_String :=
        Mqtt_Pub &
        Character'Val(Pub_header'Length + Topic'Length + Message'Length) &
        Pub_header &
        Topic &
        Message;

   begin
      Net.Buffered.Put(Client.Get_Socket(This.Connection).all,Publish);
      Net.Buffered.Flush(Client.Get_Socket(This.Connection).all);


   end PublishMQTT;
   
   procedure SubscribeMQTT (This : in out Connection_MQTT; Parameters : in Subscribe_Parameters) is
      Topic : constant String := To_String(Parameters.Topic);
      Mqtt_Sub : constant Character :=
        Character'Val(16#82#);
      Sub_header: constant UTF_8_String :=
        Parameters.Packet_ID &
        Character'Val(16#00#) &  --TPLEN
        Character'Val(Topic'Length);
      Subscribe : constant UTF_8_String :=
        Mqtt_Sub &
        Character'Val(Sub_header'Length + Topic'Length + 1) &
        Sub_header &
        Topic &
        Parameters.QoS;
      Subscriber_Ack : constant UTF_8_String := 
        Character'Val(16#90#) &
        Character'Val(16#03#) &
        Parameters.Packet_ID &
        Parameters.QoS;
      Data    : Stream_Element_Array (1..1024);
      Size    : Stream_Element_Offset;
      Ret     : Unbounded_String;
      Except : exception;
      
   begin
      Net.Buffered.Put(Client.Get_Socket(This.Connection).all,Subscribe);
      Net.Buffered.Flush(Client.Get_Socket(This.Connection).all);

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
   
   
   
   protected body Control_Subscriber is
      procedure Set_ReceivedMQTT(set : in Boolean) is
      begin
         ReceivedMQTT := set;
      end Set_ReceivedMQTT;
      procedure DoneReadingMQTT is
      begin
         Set_ReceivedMQTT(False);
      end DoneReadingMQTT;
      function Get_ReceivedMQTT return Boolean is
      begin
         return ReceivedMQTT;
      end Get_ReceivedMQTT;
   end Control_Subscriber;
   


end client_mqtt;
