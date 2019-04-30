------------------------------------------------------------------------------
--                                                                          --
--          Copyright (C) 2018, Universidad PolitÃ©cnica de Madrid           --
--                                                                          --
-- This is free software;  you can redistribute it  and/or modify it  under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 3,  or (at your option) any later ver- --
-- sion.  This software is distributed in the hope  that it will be useful, --
-- but WITHOUT ANY WARRANTY;  without even the implied warranty of MERCHAN- --
-- TABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public --
-- License for  more details.  You should have  received  a copy of the GNU --
-- General  Public  License  distributed  with  this  software;   see  file --
-- COPYING3.  If not, go to http://www.gnu.org/licenses for a complete copy --
-- of the license.                                                          --
--                                                                          --
------------------------------------------------------------------------------

-- Author: Antonio Ramos Nieto (MQTTImage)
-- String images of TTC messages

with HK_Data;                 use HK_Data;

with Ada.Text_IO;             use Ada.Text_IO;
with Ada.Calendar;            use Ada.Calendar;
with GNAT.Calendar.Time_IO;   use GNAT.Calendar.Time_IO;
with GNAT.Formatted_String;   use GNAT.Formatted_String;
with Ada.Strings.Bounded;     use Ada.Strings.Bounded;
with Ada.Characters.Latin_1;  use Ada.Characters.Latin_1;

package body TTC_Data.Strings is

   ---------------------
   -- Bounded strings --
   ---------------------

   HK_Line_Length : constant := 8 + 4 + 11 + 6 + 8 +1;
   Max_HK_String_Length : constant := HK_Line_Length*(HK_Log_Length + 1);

   package HK_Strings is new Generic_Bounded_Length (Max_HK_String_Length);
   use HK_Strings;

   ---------------------
   -- I/O subprograms --
   ---------------------

   package Mission_Time_IO is
     new Modular_IO (Mission_Time);

   function Mission_Time_Format is
     new Mod_Format (Mission_Time, Mission_Time_IO.Put);

   package Sensor_Reading_IO is
     new Modular_IO (Sensor_Reading);

   function Sensor_Reading_Format is
     new Mod_Format (Sensor_Reading, Sensor_Reading_IO.Put);

   package Temperature_Range_IO is
      new Float_IO (Temperature_Range);

   function Temperature_Range_Format is
     new Flt_Format (Temperature_Range, Temperature_Range_IO.Put);

   package Light_Range_IO is
      new Float_IO (Light_Range);

   function Light_Range_Format is
      new Flt_Format (Light_Range, Light_Range_IO.Put);

   ---------------------
   -- Image functions --
   ---------------------

   function Image (T : Mission_Time) return String  is
   begin
      return -Mission_Time_Format(+(" %09u "), T);
   end Image;

   function Image (S : Sensor_Reading) return String is
   begin
      return -Sensor_Reading_Format(+(" %04u "), S);
   end Image;

   function Image (T : Temperature_Range) return String is
   begin
      return -Temperature_Range_Format (+(" %4.1f C "), T);
   end Image;

   function Image (L : Light_Range) return String is
   begin
      return -Light_Range_Format (+(" %4.1f"), L) & " %";
   end Image;

   -----------
   -- Image --
   -----------

   function Image (M : TM_Message) return String is
   begin

      case M.Kind is
         when Basic =>
            declare
               TM_String : String :=
                 Image(Clock, "%T") & " TM " &
                 Image(M.Data.Timestamp) &
                 Image(M.Data.Value.Temperature) &
                 Image(Temperature(M.Data.Value.Temperature)); --&
--                   Image(M.Data.Value.Light) &
--                   Image(Light(M.Data.Value.Light)) ;
            begin
               return TM_String;
            end;

         when Housekeeping =>
            declare
               TM_String : Bounded_String;
            begin
               Set_Bounded_String (TM_String, Image(Clock, "%T") &
                                     "  HK" &
                                     Image(M.Data.Timestamp) &
                                     Image(M.Data.Value.Temperature) &
                                     Image(Temperature(M.Data.Value.Temperature))); --&
--                                       Image(M.Data.Value.Light) &
--                                       Image(Light(M.Data.Value.Light))) ;
               return To_String (TM_String);
            end;

         when Error =>
            declare
               TM_String : String :=
                 Image(Clock, "%T") & " TM " &
                 " ********* " &
                 " **** ";
            begin
               return TM_String;
            end;

      end case;

   end Image;

--     ---------------
--     -- MQTTImage --
--     ---------------
--
--     function MQTTImage (M : TM_Message) return String is
--     begin
--        declare
--           TM_String : String :=
--             Image(M.Data.Timestamp) &
--             "," &
--             Image(Temperature(M.Data.Value.Temperature)) &
--             "," &
--             Image(Light(M.Data.Value.Light)) ;
--        begin
--           return TM_String;
--        end;
--
--     end MQTTImage;

end TTC_Data.Strings;
