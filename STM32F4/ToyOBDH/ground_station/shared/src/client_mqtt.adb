
with Ada.Text_IO;
with Ada.Streams; use Ada.Streams;
with Ada.Strings.UTF_Encoding; use Ada.Strings.UTF_Encoding;

package body client_mqtt is

   


   procedure ConnectMQTT (This : in out Connection_MQTT; Parameters : in Connection_Parameters) is
      
      Client_ID : constant String := To_String(Parameters.Client_ID);
      Username : constant String := To_String(Parameters.Username);
      Password : constant String := To_String(Parameters.Password);
      Host : constant String := To_String(Parameters.Host);
      Host_Entry : Host_Entry_Type := Get_Host_By_Name(Host);
      Address : Sock_Addr_Type;
      
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
      Connection : constant UTF_8_String :=
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

      -- Open a TCP connection to the host
      Address.Addr := Addresses(Host_Entry, 1);
      Address.Port := Parameters.Port;
      Create_Socket (This.Socket);
      Connect_Socket (This.Socket, Address);

      -- Prepare stream to accept incoming data and push the
      -- MQTT connection
      This.Channel := Stream (This.Socket);
      String'Write (This.Channel, Connection);

      Receive_Socket(This.Socket,Data,Size);
      for i in 1 .. Size loop
         Ret := Ret & Character'Val(Data(i));
      end loop;
      if Connection_Acepted = To_String(Ret) then
         Ada.Text_IO.Put_Line ("MQTT connection acepted");
      else
         raise Except with "MQTT CONNECTION NOT ACEPTED";
      end if;

   end ConnectMQTT;

   procedure PublishMQTT (This: in Connection_MQTT; Parameters : in Publish_Parameters) is
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
      String'Write (This.Channel, Publish);


   end PublishMQTT;



end client_mqtt;
