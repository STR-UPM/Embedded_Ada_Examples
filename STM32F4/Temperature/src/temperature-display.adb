------------------------------------------------------------------------------
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
-- of the license.
--                                                                          --
------------------------------------------------------------------------------

with LCD_Std_Out;
with HAL; use HAL;

package body Temperature.Display is

   ---------
   -- Put --
   ---------

   procedure Put (T : Temperature) is
      Value : constant UInt32 := UInt32 (T);
      Temperature_String : constant String := Value'Img & " C";
   begin
      LCD_Std_Out.Put (40, 10, "T_MCU");
      LCD_Std_Out.Put (32, 60, Temperature_String);
   end Put;

end Temperature.Display;
