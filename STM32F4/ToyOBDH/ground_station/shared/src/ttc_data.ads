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

--  Data types for the TTC subsystem.

with HK_Data;       use HK_Data;

package TTC_Data is

   -- Telemetry

   type TM_Type is (Basic, Housekeeping, Error);
   --  Basic TM contais the last sensor data
   --  Housekeeping TM contains an array with a log of recent sensor data

   type TM_Message (Kind : TM_Type) is
      record
         Timestamp : Mission_Time;
         case Kind is
            when Basic =>
               Data      : Sensor_Data;
            when Housekeeping =>
               Data_Log  : HK_Log;
            when Error =>
               null;
         end case;
      end record;

   -- Telecommand

   type TC_Type is (HK);
   -- HK TC requests a housekeeping TM to be sent to ground

   type TC_Message(Kind : TC_Type) is
      record
         Timestamp : Mission_Time;
      end record;

end TTC_Data;
