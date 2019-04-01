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

-- TMP36 temperature sensor reading
-- See TMP35/TMP36/TMP37 datasheet

package HK_Data.TMP36 is

   type Temperature_Range is digits 5 range -40.0 .. +125.0;
   type Light_Range is digits 5 range 0.0 .. 100.0;

   function Temperature (R : Sensor_Reading) return Temperature_Range
     with Inline;
   function Light (R : Sensor_Reading) return Light_Range
     with Inline;

end HK_Data.TMP36;
