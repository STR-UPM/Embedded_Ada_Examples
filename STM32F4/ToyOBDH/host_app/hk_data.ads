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
--  Data types for the housekeeping subsystem

with Interfaces;

with Ada.Real_Time;  use Ada.Real_Time;

package HK_Data is

   type Sensor_Reading is new Interfaces.Integer_16;
   --  Raw temperature sensor reading.
   --  To be converted to engineering units on ground.
   --  Range is 0 .. 4095 (12 bit ADC) for 3 V reference voltage.

   type Mission_Time is new Interfaces.Integer_64;
   --  Mission time in seconds

   type Sensor_Data is
      record
         Value     : Sensor_Reading;
         Timestamp : Mission_Time;
      end record
     with Pack;
   --  Sensor reading with timestamp

   HK_Log_Length : constant Positive := 5;
   --  Length of housekeeping data log to be sent to ground

   type HK_Log is array (1 .. HK_Log_Length) of Sensor_Data;
   --  Housekeeping data log

end HK_Data;

