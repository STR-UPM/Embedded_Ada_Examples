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

-- TTC subsystem

with System;

package TTC is

   Basic_TM_Period : Natural := 10_000; -- ms
   -- basic tm messages are sent with this period

   procedure Initialize;

private

   Basic_TM_Task_Priority : System.Priority := 10;
   Basic_TM_Start_Delay   : Natural         := 1000; -- ms

   task Basic_TM_Task
     with Priority => Basic_TM_Task_Priority;

end TTC;
