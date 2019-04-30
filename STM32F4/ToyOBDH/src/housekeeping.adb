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

-- partial implementation of Antonio Ramos Nieto
-- adapted to MUSE lab by Juan A. de la Puente

with HK_Data;       use HK_Data;

with Sensors;       use Sensors;
with Storage;

with Ada.Real_Time; use Ada.Real_Time;
with STM32.Device;  use STM32.Device;
with STM32.GPIO;    use STM32.GPIO;

package body Housekeeping is

   --  Sensors

   Temperature_Sensor : Sensor;

   -------------------------
   -- Internal operations --
   -------------------------

   procedure Read_Data;
   --  Read values from all sensors

   ----------------------------
   -- Housekeeping task body --
   ----------------------------

   task body Housekeeping_Task is -- cyclic
      Next_Time : Time := Clock + Milliseconds (Start_Delay);
   begin
      loop
         delay until Next_Time;
         Read_Data;
         Next_Time := Next_Time + Milliseconds (Period);
      end loop;
   end Housekeeping_Task;

   ----------
   -- Read --
   ----------

   procedure Read_Data is
      Readings : Sensor_Readings;
      Data     : Sensor_Data;
      SC       : Seconds_Count;
      TS       : Time_Span;
   begin
      Temperature_Sensor.Get (Readings.Temperature);
      Split (Clock, SC, TS);
      Data := Sensor_Data'(Readings  => Readings,
                           Timestamp => Mission_Time (SC));
      Storage.Put (Data);
   end Read_Data;

begin
      Temperature_Sensor.Initialize(5,PA5);
end Housekeeping;
