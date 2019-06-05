---                                                                          --
--       Copyright (C) 2017-2019, Universidad Politécnica de Madrid         --
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

package body HK_Data.Converter is

   V_Ref       : constant := 2.930; -- V (measured value)
   V_25C       : constant := 0.750; -- V
   Scale       : constant := 0.010; -- V/C
   Calibration : constant := -1.0;  -- C (experimental calibration)

   Min_Temp  : constant := Temperature_Range'First;
   Max_Temp  : constant := Temperature_Range'Last;
   Max_Count : constant := 4096.0; -- for 12-bit conversion resolution

   -----------------
   -- Temperature --
   -----------------

   function Temperature
     (R : Sensor_Reading)
      return Temperature_Range
   is
      V : Float;
      T : Float;
   begin
      V := Float(R)*V_Ref/Max_Count;   -- volts
      T := (V - V_25C) / Scale + 25.0; -- degrees C
      T := T + Calibration;
      T := Float'Max (T, Min_Temp);
      T := Float'Min (T, Max_Temp);
      return Temperature_Range (T);
   end Temperature;

end HK_Data.Converter;
