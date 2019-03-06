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
-- of the license.                                                          --
--                                                                          --
------------------------------------------------------------------------------

--  Housekeeping telemetry.
--  This package contais a task that sends a TM message to the ground station
--  with a log of the last measured temperatures when an HK TC is received.

with System;

package HK_TM is -- sporadic

   Separation  : Natural :=  10_000; -- ms
   Deadline    : Natural :=      30; -- ms
   WCET        : Natural;            -- TBC after WCET analysis
   Start_Delay : Natural :=  10_000; -- ms

   procedure Send;

private

   task HK_TM_Task
     with Priority =>  System.Default_Priority;
   --  replace with DMS priority when available

   protected Request
     with  Priority => System.Priority'Last
   --  replace with ceiling prority when available
   is
      procedure Signal;
      entry Wait;
   private
      Pending : Boolean := False;
   end Request;

   procedure Send renames Request.Signal;

end HK_TM;
