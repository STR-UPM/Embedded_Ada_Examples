------------------------------------------------------------------------------
--                                                                          --
--  Copyright (C) 2017-2018 Universidad Politécnica de Madrid              --
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

-- Author: Antonio Ramos Nieto (Light)
-- Converts temperature and light values


package body HK_Data.Converter is

   V_Ref       : constant := 2.930; -- V (measured value)
   V_25C       : constant := 0.750; -- V
   Scale       : constant := 0.010; -- V/C
   Calibration : constant := -1.0;  -- C (experimental calibration)

   Min_Temp  : constant := Temperature_Range'First;
   Max_Temp  : constant := Temperature_Range'Last;
   Max_Count : constant := 4096.0; -- for 12-bit conversion resolution

   -----------------
   -- Temperature --
   -----------------

   function Temperature
     (R : Sensor_Reading)
      return Temperature_Range
   is
      V : Float;
      T : Float;
   begin
      V := Float(R)*V_Ref/Max_Count;   -- volts
      T := (V - V_25C) / Scale + 25.0; -- degrees C
      T := T + Calibration;
      T := Float'Max (T, Min_Temp);
      T := Float'Min (T, Max_Temp);
      return Temperature_Range (T);
   end Temperature;

   -----------
   -- Light --
   -----------

   function Light
     (R : Sensor_Reading)
      return Light_Range
   is
   begin
      return Light_Range (100.0*Float(R)/Max_Count);
   end Light;


end HK_Data.Converter;
