with GNAT.IO;                    use GNAT.IO;
with GNAT.Serial_Communications; use GNAT.Serial_Communications;

--  with Ada.Strings.Fixed; use Ada.Strings.Fixed;
--  with Ada.Strings;  use Ada.Strings;

-- with HK_Data; use HK_Data;

with Ada.Exceptions; use Ada.Exceptions;
with Ada.IO_Exceptions;

package body TTC is

   COM : aliased Serial_Port;
   USB : constant Port_Name := "/dev/ttyUSB0";

   -------------
   -- Receive --
   -------------

   procedure Receive (Data : out Sensor_Reading) is
      --      Data : String := Sensor_Reading'Input (COM'Access);
   begin
      Data := Sensor_Reading'Input (COM'Access);
      --      Move (Data'Img, Message, Drop => Right);
   end Receive;

   -------------
   -- Next_TM --
   -------------

   function Next_TM return TM_Message is
   begin
      return TM_Message'Input (COM'Access);
   exception
      when E: Ada.IO_Exceptions.End_Error =>
         return TM_Message'(Kind => Basic,
                            Timestamp => 0,
                            Data => (Value => ( Temperature => 0, Light => 0),
                                     Timestamp => 0));
         --           Put_Line ("Rx error " & Exception_Message (E));
      when E : others =>
         return TM_Message'(Kind => Basic,
                            Timestamp => 0,
                            Data => (Value => ( Temperature => 1, Light => 1),
                                     Timestamp => 0));
         --           Put_Line (Exception_Message (E));
   end Next_TM;


   -- Initialization
begin
   COM.Open (USB);
   COM.Set (Rate => B115200, Block => True);
end TTC;
