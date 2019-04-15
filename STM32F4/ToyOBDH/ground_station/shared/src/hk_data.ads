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

-- Author: Antonio Ramos Nieto (Sensors_Output, Sensor_Data)
-- Data types for housekeeping data (ground station)

with Interfaces;
package HK_Data is

   type Sensor_Reading is new Interfaces.Unsigned_16;
   --  Raw temperature sensor reading.
   --  To be converted to engineering units on ground.
   --  Range is 0 .. 4095 (12 bit ADC) for 3 V reference voltage.

   type Sensors_Output is record
      Temperature : Sensor_Reading;
      Light       : Sensor_Reading;
   end record;
   --  Sensor reading of temperature and ligth sensors.

   type Mission_Time is new Interfaces.Unsigned_64;
   --  Mission time in seconds

   type Sensor_Data is
      record
         Value     : Sensors_Output;
         Timestamp : Mission_Time;
      end record
     with Pack;
   --  Sensor reading with timestamp

   HK_Log_Length : constant Positive := 5;
   --  Length of housekeeping data log to be sent to ground

   type HK_Log is array (1 .. HK_Log_Length) of Sensor_Data;
   --  Housekeeping data log

end HK_Data;

