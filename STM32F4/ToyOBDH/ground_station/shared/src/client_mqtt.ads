
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with GNAT.Sockets; use GNAT.Sockets;
with Ada.Strings.UTF_Encoding; use Ada.Strings.UTF_Encoding;
with AWS.Client; use AWS;
package client_mqtt is

   type Connection_MQTT is tagged limited private;

   type Connection_Parameters is record
      Host : Unbounded_String;
      Port : Unbounded_String;
      Client_ID : Unbounded_String;
      Username : Unbounded_String;
      Password : Unbounded_String;
   end record;

   type Publish_Parameters is record
      Topic : Unbounded_String;
      Message : Unbounded_String;
   end record;


   type Subscribe_Parameters is record
      Topic : Unbounded_String;
      QoS : Character;
      Packet_ID : UTF_8_String(1..2);
      Expected_Message : Unbounded_String;
   end record;


   procedure ConnectMQTT (This : in out Connection_MQTT; Parameters : in Connection_Parameters);
   procedure PublishMQTT (This : in out Connection_MQTT; Parameters : in Publish_Parameters);
   procedure SubscribeMQTT (This : in out Connection_MQTT; Parameters : in Subscribe_Parameters);

   function ReceivedMQTT return Boolean;
   procedure ReadingMQTT;

private

   protected Control_Subscriber is
      procedure DoneReadingMQTT;
      procedure Set_ReceivedMQTT(set : in Boolean);
      function Get_ReceivedMQTT return Boolean;
   private
      ReceivedMQTT : Boolean := False;
   end Control_Subscriber;

   function ReceivedMQTT return Boolean renames Control_Subscriber.Get_ReceivedMQTT;
   procedure ReadingMQTT renames Control_Subscriber.DoneReadingMQTT;

   task type Subscriber_Task is
      entry Start_Subscriber_Task (InConnection : in out Connection_MQTT; Subscribe_Param : in Subscribe_Parameters);
   end Subscriber_Task;


   Sub_task : Subscriber_Task;

   type Connection_MQTT is tagged limited record
      Connection : Client.HTTP_Connection;
      Secure : Boolean;
   end record;

   Security : Boolean := True;


end client_mqtt;
