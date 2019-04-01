
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with GNAT.Sockets; use GNAT.Sockets;

package client_mqtt is

   type Connection_MQTT is tagged private;

   type Connection_Parameters is record
      Host : Unbounded_String;
      Port : Port_Type;
      Client_ID : Unbounded_String;
      Username : Unbounded_String;
      Password : Unbounded_String;
   end record;

   type Publish_Parameters is record
      Topic : Unbounded_String;
      Message : Unbounded_String;
   end record;

   procedure ConnectMQTT (This : in out Connection_MQTT; Parameters : in Connection_Parameters);
   procedure PublishMQTT (This: in Connection_MQTT; Parameters : in Publish_Parameters);

private
   type Connection_MQTT is tagged record
      Channel : Stream_Access;
      Socket : Socket_Type;
   end record;


end client_mqtt;
