with GNAT.Sockets;
with Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Streams; use Ada.Streams;
with Ada.Strings.UTF_Encoding; use Ada.Strings.UTF_Encoding;


package body client_mqtt is

   
   Username : constant String := "cunjkfki";
   Password : constant String := "NiROE_oOt3ZF";
   Acepted : Boolean := False;
   Except : exception;


   Host : constant String := "m24.cloudmqtt.com";

   Host_Entry : Gnat.Sockets.Host_Entry_Type
     := GNAT.Sockets.Get_Host_By_Name(Host);

   Address : GNAT.Sockets.Sock_Addr_Type;
   Socket  : GNAT.Sockets.Socket_Type;
   Channel : GNAT.Sockets.Stream_Access;

   
   
   function ConnectMQTT return Boolean is
      Accepted : Boolean := False;
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
        Character'Val(16#3C#) &
        Character'Val(16#00#) &  --CIDLEN
        Character'Val(16#06#) &
        Character'Val(16#41#) &  --ID
        Character'Val(16#41#) &
        Character'Val(16#42#) &
        Character'Val(16#42#) &
        Character'Val(16#43#) &
        Character'Val(16#43#);
      ULen : constant UTF_8_String :=
        Character'Val(16#00#) &  --ULEN
        Character'Val(Username'Length);
      PLen : constant UTF_8_String :=
        Character'Val(16#00#) &  --PLEN
        Character'Val(Password'Length);
      Connection : constant UTF_8_String :=
        Mqtt_Conn &
        Character'Val(Conn_header'Length + ULen'Length + Username'Length + PLen'Length + Password'Length) &
        Conn_header &
        ULen &
        Username &
        PLen &
        Password;


      Data    : Ada.Streams.Stream_Element_Array (1..1024);
      Size    : Ada.Streams.Stream_Element_Offset;
      Ret     : Ada.Strings.Unbounded.Unbounded_String;
      Connection_Acepted : constant UTF_8_String :=
        Character'Val(16#20#) &
        Character'Val(16#02#) &
        Character'Val(16#00#) &
        Character'Val(16#00#);

   begin

      -- Open a TCP connection to the host
      Address.Addr := GNAT.Sockets.Addresses(Host_Entry, 1);
      Address.Port := 15484;
      GNAT.Sockets.Create_Socket (Socket);
      GNAT.Sockets.Connect_Socket (Socket, Address);

      -- Prepare stream to accept incoming data and push the
      -- MQTT connection
      Channel := Gnat.Sockets.Stream (Socket);
      String'Write (Channel, Connection);

      GNAT.Sockets.Receive_Socket(Socket,Data,Size);
      for i in 1 .. Size loop
         Ret := Ret & Character'Val(Data(i));
      end loop;
      if Connection_Acepted = Ada.Strings.Unbounded.To_String(Ret) then
         Accepted := True;
         Ada.Text_IO.Put_Line ("Acepted");
      end if;
      return Accepted;

   end ConnectMQTT;

   procedure SendMQTT (Topic : in String; Message : in String) is
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
      String'Write (Channel, Publish);


   end SendMQTT;
   
begin
   
   Acepted := ConnectMQTT;
   if not Acepted then 
      raise Except with "MQTT NOT ACEPTED";
   end if;
   
   delay (0.1);


end client_mqtt;
