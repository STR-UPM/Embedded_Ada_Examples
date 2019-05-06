------------------------------------------------------------------------------
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

--  Main procedure of toy ground station system - graphic interface version

with TTC;
-- The TTC package contains the telemetry/telecommand subsystem

with User_Interface;              use User_Interface;
-- Graphic user interface - based on gtkada

with GNAT.OS_Lib;

procedure GS_Graphic is
begin
   User_Interface.Init;
   -- control returns here if the GUI window is closed
   GNAT.OS_Lib.OS_Exit(0);
end GS_Graphic;

