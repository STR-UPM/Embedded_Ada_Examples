--                                                                          --
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

-- User interface

with HK_Data;           use HK_Data;
with HK_Data.Converter; use HK_Data.Converter;
with TTC_Data;          use TTC_Data;

package User_Interface is

   Send_TC : Boolean := False;

   procedure Init;
   -- Init user interface

   procedure Put (S : String);
   -- write a text string on the user interface

   procedure Put (M : TM_Message);
   -- write a TM message on the user interface

end User_Interface;
