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
with TTC_Data;           use TTC_Data;
with HK_Data;            use HK_Data;
with Storage;

with Ada.Real_Time;      use Ada.Real_Time;

package body HK_TM is

   -------------------------
   -- Internal operations --
   -------------------------

   procedure Send_TM_Message;
   --  Send a TM message with the last sensor data log.

   ----------------
   -- HK_TM_Task --
   ----------------

   task body HK_TM_Task is
   begin
      loop
         Request.Wait;
         Send_TM_Message;
      end loop;
   end HK_TM_Task;

   -------------
   -- Request --
   -------------

   protected body Request is

      ------------
      -- Signal --
      ------------

      procedure Signal is
      begin
         Pending := True;
      end Signal;

      ----------
      -- Wait --
      ----------

      entry Wait when Pending is
      begin
         Pending := False;
      end Wait;

   end Request;

   ---------------------
   -- Send_TM_Message --
   ---------------------

   procedure Send_TM_Message is
      Message  : TM_Message (Housekeeping);
      SC       : Seconds_Count;
      TS       : Time_Span;
      Data     : Sensor_Data;
   begin
      Split (Clock, SC, TS);
      Message.Timestamp := Mission_Time (SC);
      for I in Message.Data_Log'Range loop
         if not Storage.Empty then
            Storage.Get (Data);
            Message.Data_Log (I) := Data;
         else
            Message.Data_Log (I) := (Value => 0, Timestamp => 0);
         end if;
      end loop;
      TTC.Send (Message);
   end Send_TM_Message;

end HK_TM;
