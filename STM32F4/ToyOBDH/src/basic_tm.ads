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

--  Houskeeping telemetry.
--  This package contais a task that sends a TM message to the ground station
--  with the last temperature value every 10 s.

with System;

package Basic_TM is -- cyclic
   pragma Elaborate_Body;

   Period      : Natural    :=   5000; -- ms
   Deadline    : Natural    :=     50; -- ms
   WCET        : Natural;              -- TBC after WCET analysis
   Start_Delay : Natural    :=   5000; -- ms

private

   task Basic_TM_Task
     with Priority => System.Default_Priority;
   --  replace with DMS priority when available

end Basic_TM;
