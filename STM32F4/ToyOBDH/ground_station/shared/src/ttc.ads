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

-- Telemetry reception subsystem

with HK_Data;          use HK_Data;
with TTC_Data;         use TTC_Data;
with Ada.Real_Time;    use Ada.Real_Time;

with System;
with GNAT.Serial_Communications; use GNAT.Serial_Communications;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package TTC is

   procedure Init;
   -- Initialize TTC sybsystem

   procedure Send (TC : TC_Type := HK);
   -- Send a telecommand

private

   ----------------------
   -- Port definitions --
   ----------------------

   COM : aliased Serial_Port;
   USB : constant Port_Name := "/dev/ttyUSB0";

   -----------
   -- Tasks --
   -----------

   task TM_Receiver
     with Priority =>  System.Default_Priority;
   -- replace with DMS priority when available

   task TC_Sender
     with Priority => System.Default_Priority;
   -- replace with DMS priority when available

end TTC;
