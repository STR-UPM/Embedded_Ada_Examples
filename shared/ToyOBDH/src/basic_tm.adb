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

with TTC;
with TTC_Data;  use TTC_Data;
with HK_Data;   use HK_Data;
with Storage;

with Ada.Real_Time;      use Ada.Real_Time;

package body Basic_TM is -- cyclic

   -------------------------
   -- Internal operations --
   -------------------------

   procedure Send_TM_Message;
   --  Send a TM message with the last sensor data.

   ------------------------
   -- Basic TM task body --
   ------------------------

   task body Basic_TM_Task is
      Next_Time : Time :=  Clock + Milliseconds (Start_Delay);
   begin
      loop
         delay until Next_Time;
         Send_TM_Message;
         Next_Time := Next_Time + Milliseconds (Period);
      end loop;
   end Basic_TM_Task;

   ----------------------
   -- Send_TM_Message  --
   ----------------------

   procedure Send_TM_Message is
      Message  : TM_Message;
      SC       : Seconds_Count;
      TS       : Time_Span;
   begin
      Split (Clock, SC, TS);
      Message.Kind      := Basic;
      Message.Timestamp := Mission_Time (SC);
      Message.Data      := Storage.Last;
      TTC.Send (Message);
   end Send_TM_Message;

end Basic_TM;
