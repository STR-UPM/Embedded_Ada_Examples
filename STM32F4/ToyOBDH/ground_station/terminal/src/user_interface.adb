------------------------------------------------------------------------------
--                                                                          --
--          Copyright (C) 2017, Universidad Politécnica de Madrid           --
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

-- User interface implementation
-- Terminal version

--  with TC_Sender;               use TC_Sender;

with Ada.Text_IO;             use Ada.Text_IO;
with Ada.Characters.Handling; use Ada.Characters.Handling;
with Ada.Calendar;            use Ada.Calendar;
with GNAT.Calendar.Time_IO;   use GNAT.Calendar.Time_IO;
with GNAT.Formatted_String;   use GNAT.Formatted_String;

with System;

package body User_Interface is

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


--     task Command_Listener
--       with Priority => System.Default_Priority;
--     -- waits for the user to type a 'C' .and then
--     -- generates a TC and send it to the OBSW

   --------------------------
   -- Image subprograms --
   --------------------------

   function Image (T : Mission_Time)      return String;
   function Image (S : Sensor_Reading)    return String;
   function Image (T : Temperature_Range) return String;

   ----------
   -- Init --
   ----------

   procedure Init is
   begin
      -- nothing to do
      null;
   end Init;

   ----------------
   -- Put string --
   ----------------

   procedure Put (S : String) is
   begin
      Ada.Text_IO.Put_Line (S);
   end Put;

   -----------------
   -- Put message --
   -----------------

   procedure Put (M : TM_Message) is
   begin
      case M.Kind is
         when Basic =>
            Ada.Text_IO.Put (Image(Clock, "%T"));
            Ada.Text_IO.Put (Image(M.Timestamp));
            Ada.Text_IO.Put (Image(M.Data.Timestamp));
            Ada.Text_IO.Put (Image(M.Data.Value));
            Ada.Text_IO.Put (Image(Temperature(M.Data.Value)));
            New_Line;

         when Housekeeping =>
            null;
            --                    Split(Message.Timestamp, SC, TS);
            --  --                    pragma Debug
            --  --                      (System.IO.Put_Line("TM "& SC'Img & "  HK log"));
            --                    User_Interface.Put_TM(Image(Clock, "%T ")
            --                               & "TM " & SC'Img & " "
            --                               & " HK log");
            --                    for i in 1..Message.Length loop
            --                       M := Message.Data_Log(i);
            --                       Split(M.Timestamp, SC, TS);
            --  --                       pragma Debug
            --  --                         (System.IO.Put_Line("            "
            --  --                          & SC'Img & " " & M.Value'Img));
            --                       User_Interface.Put_TM("            "
            --                                  & SC'Img & " " & M.Value'Img);
            --                 end loop;
      end case;

   end Put;

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


   ----------------------
   -- Command listener --
   ----------------------

--     task body Command_Listener is
--        C : Character;
--     begin
--        pragma Debug(Put_Line("Command listener started"));
--        loop
--           delay 1.0; -- allow for some free time
--           Get_Immediate(C);
--           C := To_Upper(C);
--           case C is
--              when 'C' =>
--                 Send(HK);
--              when others =>
--                 null;
--           end case;
--        end loop;
--     end Command_Listener;

end User_Interface;
