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

-- This package provides an abstraction layer for sensor devices

with Housekeeping.Data; use Housekeeping.Data;

-- with STM32.ADC; use STM32.ADC;

with HAL;          use HAL;
with STM32.GPIO;   use STM32.GPIO;
with STM32.Device; use STM32.Device;

package Housekeeping.Sensors is
   
   --Initialize ADC for all channels
   procedure Initialize;
   
   -- Get sensor data
   procedure Get (Data : out Analog_Data_Table);
                
end Housekeeping.Sensors;
