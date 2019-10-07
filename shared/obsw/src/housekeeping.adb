------------------------------------------------------------------------------
--                                                                          --
--          Copyright (C) 2018, Universidad Politécnica de Madrid           --
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
with Housekeeping.Sensors; use Housekeeping.Sensors;

with Storage;

with STM32.Board;          use STM32.Board;
with STM32.GPIO;           use STM32.GPIO;

with Ada.Real_Time;        use Ada.Real_Time;

package body Housekeeping is

   -- Sensors
   -- type Sensor_Table is array (Analog_Signal) of Sensor;
   -- Analog_Input : Sensor_Table;

   -- Internal operations

   procedure Get_Data;
   -- Get values from all sensors and put them into storage

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize is
   begin
      Housekeeping.Sensors.Initialize;
--        Analog_Input(OBC_T).Initialize(Input_Channel => 5, Input_Point => PA5);
   end Initialize;

   ----------------------------
   -- Housekeeping task body --
   ----------------------------

   task body Housekeeping_Task is -- cyclic
      Next_Time : Time := Clock + Milliseconds (Start_Delay);
      Sampling_Period : constant Time_Span := Milliseconds (Period);
   begin
      loop
         delay until Next_Time;
         Get_Data;
         Blue_LED.Toggle;
         Next_Time := Next_Time + Sampling_Period;
      end loop;
   end Housekeeping_Task;

   --------------
   -- Get data --
   --------------

   procedure Get_Data is
      State   : Housekeeping.Data.State;
      SC      : Seconds_Count;
      TS      : Time_Span;
   begin
      Get (State.Data_Value);
      Split (Clock, SC, TS);
      State.Mission_Time := Mission.Time (SC);
      Storage.Put (State);
   end Get_Data;

end Housekeeping;
