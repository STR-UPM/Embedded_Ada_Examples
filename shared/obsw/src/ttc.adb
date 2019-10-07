------------------------------------------------------------------------------
--                                                                          --
--          Copyright (C) 2019, Universidad Politécnica de Madrid           --
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

with Mission;

with Housekeeping.Data;
with Storage;

with STM32.Board;          use STM32.Board;

with Serial_IO.Blocking;   use Serial_IO.Blocking;
with Peripherals_Blocking; use Peripherals_Blocking;
with Message_Buffers;      use Message_Buffers;

with Ada.Characters.Latin_1; use Ada.Characters.Latin_1;
with Ada.Real_Time;          use Ada.Real_Time;

package body TTC is

   Outgoing : aliased Message (Physical_Size => 1024);  -- arbitrary size

   -------------------------
   -- Internal operations --
   --------------------------

   procedure Send (This : String);

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize is
   begin
      Initialize(COM);
      Configure (COM, Baud_Rate => 115_200);
   end Initialize;

   ----------
   -- Send --
   ----------

   procedure Send (This : String) is
   begin
      Set (Outgoing, To => This);
      Put (COM, Outgoing'Unchecked_Access);
      -- blocking call
   end Send;

   -------------------
   -- Basic TM task --
   -------------------

   task body Basic_TM_Task is
      use Housekeeping.Data;

      Period : constant Time_Span := Milliseconds(Basic_TM_Period);
      Next_Time : Time := Clock + Milliseconds(Basic_TM_Start_Delay);

      S : State;
      T : Mission.Time;
      T_Data, V_Data : Analog_Data;

   begin
      loop
         delay until Next_Time;
         -- Red_LED.Set;
         S := Storage.Last;
         T := S.Mission_Time;
         T_Data := S.Data_Value(OBC_T);
         V_Data := S.Data_Value(OBC_V);
         Send ("Hello " & T'Img & " " & T_Data'Img & " ... " & V_Data'Img & CR & LF);
         Red_LED.Toggle;
         Next_Time := Next_Time + Period;
      end loop;
   end Basic_TM_Task;

end TTC;
