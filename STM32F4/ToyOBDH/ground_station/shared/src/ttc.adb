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

-- Partial implementation by Antonio Ramos Nieto
-- Adapted to MUSE lab by Juan A. de la Puente

-- Implementation of TTC subsystem
-- TTC messages are exchanged as streams on a serial interface

with User_Interface;

with GNAT.IO;                    use GNAT.IO;

with Ada.Real_Time; use Ada.Real_Time;
with Ada.Streams; use Ada.Streams;

with Ada.IO_Exceptions;
with Ada.Exceptions; use Ada.Exceptions;

pragma Warnings(Off);
with System.IO;
pragma Warnings(On);
with TTC_Data.Strings; use TTC_Data.Strings;
with HK_Data.Converter; use HK_Data.Converter;

package body TTC is

   ----------
   -- Init --
   ----------

   procedure Init is
   begin
      COM.Open (USB);
      COM.Set (Rate => B115200);
--        Con_MQTT.ConnectMQTT(Connection_Param);
--        delay (0.1);
--        Con_MQTT.SubscribeMQTT(Subscribe_Param);
   end Init;

   ----------
   -- Send --
   ----------

   procedure Send (TC : TC_Type := HK) is
   begin
      send:
      declare
         Message : TC_Message := (Kind => HK, Timestamp => 0);
      begin
         System.IO.Put_Line("Send TC");
         TC_Message'Output (COM'Access, Message);
      end send;
   end Send;

   -----------------
   -- TM_Receiver --
   -----------------

   task body TM_Receiver is
   begin
      Init;

      loop
         --delay 10.0; -- let USART interface recover

         receive:
         begin
            declare
               Message : TM_Message := TM_Message'Input (COM'Access);
            begin
               User_Interface.Put (Message);
            end;
         exception
            when E: Ada.IO_Exceptions.End_Error =>
               null;
            when E : others =>
               User_Interface.Put (TM_Message'(Kind =>Error,
                                               Timestamp => 0,
                                               Data => ((Temperature => 0),0)));
               System.IO.Put_line ("TM " & Exception_Message (E));
         end receive;
      end loop;

   exception
      when E : others =>
         User_Interface.Put ("TM " & Exception_Information (E));
   end TM_Receiver;

   ---------------
   -- TC_Sender --
   ---------------

   task body TC_Sender is
     Received : Boolean := False;
   begin

      loop
         if User_Interface.Send_TC or else Received then
            User_Interface.Send_TC := False;
            Send;
         end if;
         --delay until Clock + Milliseconds (100);
      end loop;

   exception
      when E : others =>
         User_Interface.Put ("TC " & Exception_Information (E));
   end TC_Sender;

end TTC;
