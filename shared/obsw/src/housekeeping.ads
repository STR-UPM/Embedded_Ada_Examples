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

--  Housekeeping subsystem.

with System;

package Housekeeping is

   Period : Natural := 1000; -- ms
   -- housekeeping sensors are read with this period

   procedure Initialize;

private

   Task_Priority : System.Priority := 30;
   Start_Delay   : Natural := 1000; -- ms

   task Housekeeping_Task
     with Priority => Task_Priority;

end Housekeeping;
