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

-- User interface implementation
-- Terminal version

with Ada.Text_IO; use Ada.Text_IO;

--  with TC_Sender;               use TC_Sender;

with TTC_Data.Strings;

-- with System;

package body User_Interface is

--     task Command_Listener
--       with Priority => System.Default_Priority;
--     -- waits for the user to type a 'C' .and then
--     -- generates a TC and send it to the OBSW

   ----------
   -- Init --
   ----------

   procedure Init is
   begin
      -- nothing to do
      null;
   end Init;

   ----------------
   -- Put string --
   ----------------

   procedure Put (S : String) is
   begin
      Ada.Text_IO.Put_Line (S);
   end Put;

   -----------------
   -- Put message --
   -----------------

   procedure Put (M : TM_Message) is
   begin
      Put (TTC_Data.Strings.Image(M));
   end Put;

   ----------------------
   -- Command listener --
   ----------------------

--     task body Command_Listener is
--        C : Character;
--     begin
--        pragma Debug(Put_Line("Command listener started"));
--        loop
--           delay 1.0; -- allow for some free time
--           Get_Immediate(C);
--           C := To_Upper(C);
--           case C is
--              when 'C' =>
--                 Send(HK);
--              when others =>
--                 null;
--           end case;
--        end loop;
--     end Command_Listener;

end User_Interface;
