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

--  This is the main procedure for the toy_obdh example.

with Last_Chance_Handler;  pragma Unreferenced (Last_Chance_Handler);

with Housekeeping;  pragma Unreferenced (Housekeeping);
--  The Housekeeping subsystem reads sensors and puts values in a store.

--  with Basic_TM;      pragma Unreferenced (Basic_TM);
--  --  The Basic_TM package contains the task that generates
--  --  basic telemetry messages that are sent to the ground station.
--
--  with HK_TM;         pragma Unreferenced (HK_TM);
--  --  The HK_TM package contains the task that generates
--  --  housekeeping telemetry messages that are sent to the ground station.
--
--  with TC_Receiver;   pragma Unreferenced (TC_Receiver);
--  --  The TC_Receiver package contains the task that receives TC messages
--  --  from the ground station and decodes them.

with TTC;
--
--  --  Although these packages are not referenced directly in the main procedure,
--  --  we need them in the closure of the context clauses so that
--  --  they will be included in the executable.

with STM32.Board;
with Ada.Real_Time; use Ada.Real_Time;

procedure OBSW is
begin
   STM32.Board.Initialize_LEDs;
--     Housekeeping.Initialize;
   TTC.Initialize;
   Housekeeping.Initialize;

   --  do nothing while application tasks run
   loop
      STM32.Board.Green_LED.Toggle;
      delay until Clock + Milliseconds (1000);
   end loop;
end OBSW;

