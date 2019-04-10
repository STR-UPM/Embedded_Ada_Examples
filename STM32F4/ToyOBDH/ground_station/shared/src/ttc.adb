------------------------------------------------------------------------------
--                                                                          --
--  Copyright (C) 2017-2018 Universidad Politécnica de Madrid               --
--                                                                          --
--  Redistribution and use in source and binary forms, with or without      --
--  modification, are permitted provided that the following conditions are  --
--  met:                                                                    --
--     1. Redistributions of source code must retain the above copyright    --
--        notice, this list of conditions and the following disclaimer.     --
--     2. Redistributions in binary form must reproduce the above copyright --
--        notice, this list of conditions and the following disclaimer in   --
--        the documentation and/or other materials provided with the        --
--        distribution.                                                      --
--     3. Neither the name of the copyright holder nor the names of its     --
--        contributors may be used to endorse or promote products derived   --
--        from this software without specific prior written permission.     --
--                                                                          --
--   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS    --
--   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT      --
--   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR  --
--   A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT   --
--   HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, --
--   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT       --
--   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,  --
--   DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY  --
--   THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT    --
--   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE  --
--   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.   --
--                                                                          --
-------------------------------------------------------------------------------

-- Implementation of TTC subsystem
-- TTC messages are exchanged as streams on a serial interface

with User_Interface;

with GNAT.IO;                    use GNAT.IO;
with GNAT.Serial_Communications; use GNAT.Serial_Communications;

with Ada.Real_Time; use Ada.Real_Time;

with Ada.IO_Exceptions;
with Ada.Exceptions; use Ada.Exceptions;

with System.IO;

package body TTC is

   ----------------------
   -- Port definitions --
   ----------------------

   COM : aliased Serial_Port;
   USB : constant Port_Name := "/dev/ttyUSB1";

   ----------
   -- Init --
   ----------

   procedure Init is
   begin
      COM.Open (USB);
      COM.Set (Rate => B115200, Block => True);
   end Init;

   ----------
   -- Send --
   ----------

   procedure Send (TC : TC_Type := HK) is
   begin
      null;
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
            when E : others =>
               User_Interface.Put (TM_Message'(Kind =>Error, Timestamp => 0));
               --User_Interface.Put ("TM receive: " & Exception_Name (E));
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
   begin

      loop
         delay 30.0;

         send:
         declare
            Message : TC_Message := (Kind => HK, Timestamp => 0);
         begin
            System.IO.Put_Line("Send TC");
            TC_Message'Output (COM'Access, Message);
         end send;

      end loop;

   exception
      when E : others =>
         User_Interface.Put ("TC " & Exception_Information (E));
   end TC_Sender;



   ----------------
   -- TC Request --
   ----------------

--    protected body TC_Request
--     is
--
--        procedure Put (TC :     TC_Type) is
--        begin
--           Waiting := True;
--           Next_TC := TC;
--        end Put;
--
--        function  Next return TC_Type is
--        begin
--           return Next_TC;
--        end Next;
--
--        function  Pending return Boolean is
--        begin
--           return Waiting;
--        end Pending;
--
--        procedure Clear is
--        begin
--           Waiting := False;
--        end Clear;
--
--     end TC_Request;

end TTC;
