------------------------------------------------------------------------------
--                                                                          --
--          Copyright (C) 2017, Universidad Politécnica de Madrid           --
--                                                                          --
--  Redistribution and use in source and binary forms, with or without      --
--  modification, are permitted provided that the following conditions are  --
--  met:                                                                    --
--     1. Redistributions of source code must retain the above copyright    --
--        notice, this list of conditions and the following disclaimer.     --
--     2. Redistributions in binary form must reproduce the above copyright --
--        notice, this list of conditions and the following disclaimer in   --
--        the documentation and/or other materials provided with the        --
--        distribution.                                                     --
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

-- Implementation of telecommand subsystem

with IP;                      use IP;

with GNAT.Sockets;            use GNAT.Sockets;
with Ada.Real_Time;           use Ada.Real_Time;
with Ada.Streams;             use Ada.Streams;
with Ada.Characters.Handling; use Ada.Characters.Handling;
with Ada.Unchecked_Conversion;

with Ada.Calendar;
with GNAT.Calendar.Time_IO;  use GNAT.Calendar.Time_IO;

pragma Warnings(Off);
with System.IO;               -- for debugging purposes
pragma Warnings(On);

package body TC_Sender is

   ----------------------
   -- Data definitions --
   ----------------------

   subtype  TC_Stream is Stream_Element_Array (1..TC_Message'Size/8);
   function To_Stream is new Ada.Unchecked_Conversion (TC_Message, TC_Stream);

   Socket         : Socket_Type;
   OBSW_Address   : Sock_Addr_Type;

   ----------
   -- Init --
   ----------

   procedure Init is
   begin
      Create_Socket(Socket, Family_Inet, Socket_Datagram);
      OBSW_Address := (Family_Inet, IP.OBSW_IP, IP.OBSW_Port);
      pragma Debug
        (System.IO.Put_Line("... send TCs to " & Image(OBSW_Address)));
   end Init;

   ---------------------
   -- Send TC request --
   ---------------------

   procedure Send(TC : TC_Type := HK) is
      T       : Time;
      SC      : Seconds_Count;
      TS      : Time_Span;
   begin
      T := Clock;
      Split(T, SC, TS);
      declare
         Command : TC_Message := (Kind => TC, Timestamp => T);
         Stream  : TC_Stream  := To_Stream(Command);
         Last    : Ada.Streams.Stream_Element_Offset;
      begin
         Send_Socket(Socket, Stream, Last, OBSW_Address);
--           pragma Debug
--             (System.IO.Put_Line(Image(Ada.Calendar.Clock, "%T ")
--              & "TC " & SC'Img & " " & TC'Img));
      end;
   end Send;

end TC_Sender;
