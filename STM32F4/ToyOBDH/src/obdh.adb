------------------------------------------------------------------------------
--                                                                          --
--  Copyright (C) 2017-2018, Universidad Politécnica de Madrid              --
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
------------------------------------------------------------------------------

--  This is the main procedure for the toy_obdh example.

with Reader;        pragma Unreferenced (Reader);
--  The Reader package contains the task that reads the temperature sensor.

--  with Basic_TM;      pragma Unreferenced (Basic_TM);
--  The Basic_TM package contains the task that generates
--  basic telemetry messages that are sent to the ground station.

--  with HK_TM;         pragma Unreferenced (HK_TM);
--  The HK_TM package contains the task that generates
--  housekeeping telemetry messages that are sent to the ground station.

--  with TC_Receiver;   pragma Unreferenced (TC_Receiver);
--  The TC_Receiver package contains the task that receives TC messages
--  from the ground station and decodes them.

--  Although these packages are not referenced directly in the main procedure,
--  we need them in the closure of the context clauses so that
--  they will be included in the executable.

with System;

procedure OBDH is
   pragma Priority (System.Priority'First);
begin
   --  do nothing while application tasks run
   loop
      null;
   end loop;
end OBDH;
