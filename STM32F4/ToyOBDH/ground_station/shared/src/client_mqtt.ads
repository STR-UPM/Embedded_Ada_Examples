------------------------------------------------------------------------------
--                                                                          --
--  Copyright (C) 2017-2018 Universidad Politécnica de Madrid              --
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
-- MQTT client subsystem

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with GNAT.Sockets; use GNAT.Sockets;
with Ada.Strings.UTF_Encoding; use Ada.Strings.UTF_Encoding;
with AWS.Client; use AWS;
package client_mqtt is

   -- MQTT Connection
   type Connection_MQTT is tagged limited private;

   --Parameters for connecting to a MQTT Broker
   type Connection_Parameters is record
      Host : Unbounded_String;
      Port : Unbounded_String;
      Client_ID : Unbounded_String;
      Username : Unbounded_String;
      Password : Unbounded_String;
   end record;

   --Parameters to publish in a MQTT Broker
   type Publish_Parameters is record
      Topic : Unbounded_String;
      Message : Unbounded_String;
   end record;


   --Parameters to subscribe in a MQTT Broker
   type Subscribe_Parameters is record
      Topic : Unbounded_String;
      QoS : Character;
      Packet_ID : UTF_8_String(1..2);
      Expected_Message : Unbounded_String;
   end record;


   --MQTT Client operations
   procedure ConnectMQTT (This : in out Connection_MQTT; Parameters : in Connection_Parameters);
   procedure PublishMQTT (This : in out Connection_MQTT; Parameters : in Publish_Parameters);
   procedure SubscribeMQTT (This : in out Connection_MQTT; Parameters : in Subscribe_Parameters);

   --Function to control a subscriber
   procedure ReceivedMQTT(leer : out Boolean);



private

   --Procedure to control a subscriber
   protected Control_Subscriber is
      procedure Set_ReceivedMQTT(set : in Boolean);
      procedure Read_ReceivedMQTT(leer : out Boolean);
   private
      ReceivedMQTT : Boolean := False;
   end Control_Subscriber;

   procedure ReceivedMQTT(leer : out Boolean) renames Control_Subscriber.Read_ReceivedMQTT;


   --Task to recive subscriber messages
   task type Subscriber_Task is
      entry Start_Subscriber_Task (InConnection : in out Connection_MQTT; Subscribe_Param : in Subscribe_Parameters);
   end Subscriber_Task;


   Sub_task : Subscriber_Task;

   -- MQTT Connection
   type Connection_MQTT is tagged limited record
      Connection : Client.HTTP_Connection;
      Secure : Boolean;
   end record;

   --------------
   -- Security --
   --------------
   -- This value must be set to True if si a SSL connection,
   -- else it must be set to False.

   Security : Boolean := True;


   ------------------
   -- MQTT headers --
   ------------------

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

   Connection_Acepted : constant UTF_8_String :=
     Character'Val(16#20#) &  --Response if the connection is accepted
     Character'Val(16#02#) &
     Character'Val(16#00#) &
     Character'Val(16#00#);

   Mqtt_Pub : constant Character := Character'Val(16#30#);
   Mqtt_Sub : constant Character := Character'Val(16#82#);


end client_mqtt;
