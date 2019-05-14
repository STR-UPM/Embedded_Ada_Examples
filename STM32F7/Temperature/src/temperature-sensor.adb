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
-- of the license.
--                                                                          --
------------------------------------------------------------------------------

--  Based on Ada Drivers Library Demo_ADC_Temperature_Polling

with STM32.Device; use STM32.Device;
with STM32.ADC;    use STM32.ADC;

package body Temperature.Sensor is

   procedure Initialize;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize is

      All_Regular_Conversions : constant Regular_Channel_Conversions :=
        (1 => (Channel     => Temperature_Sensor.Channel,
               Sample_Time => Sample_144_Cycles));  -- needs 10 micros minimum

   begin
      Enable_Clock (Temperature_Sensor.ADC.all);

      Reset_All_ADC_Units;

      Configure_Common_Properties
        (Mode           => Independent,
         Prescalar      => PCLK2_Div_2,
         DMA_Mode       => Disabled,
         Sampling_Delay => Sampling_Delay_5_Cycles);

      Configure_Unit
        (Temperature_Sensor.ADC.all,
         Resolution => ADC_Resolution_12_Bits,
         Alignment  => Right_Aligned);

      Configure_Regular_Conversions
        (Temperature_Sensor.ADC.all,
         Trigger     => Software_Triggered,
         Continuous  => False,
         Enable_EOC  => True,
         Conversions => All_Regular_Conversions);

      Enable (ADC_1);

   end Initialize;

   ---------
   -- Get --
   ---------

   procedure Get (T : out Temperature) is

      V_Sense : Float;
      --  the "sensed voltage", ie the counts returned by the ADC conversion,
      --  after converting to float

      Temperature : Float;
      --  the computed temperature

      V_Sense_At_25_Degrees : constant := 0.76;
      --  Per the F429 and F405/7 datasheets, at 25 degrees Celsius the sensed
      --  voltage will be approx 0.76V, but this is only estimated by the
      --  manufacturer.
      --  See the F429xx datasheet, section 6.3.22, table 82, pg 159

      V_Ref : constant Float := Float (ADC_Supply_Voltage) / 1000.0;  -- ie 3.3
      --  Reference voltage used by the ADC unit, same as Vdd. See section 5.1.2
      --  of the datasheet for the F40x MCUs, for example.

      Max_Count : constant := 4096.0; -- for 12-bit conversion resolution

      V_At_25_Degrees : constant := (V_Sense_At_25_Degrees / V_Ref) * Max_Count;

      Avg_Slope : constant := 2.5;
      --  Per the F429 and F405/7 datasheets, the average slope is 2.5mV per
      --  degree C.
      --  See the F429xx datasheet, section 6.3.22, pg 159.
      --  For use, see the RM, section 13.10, pg 411.

      Successful : Boolean;
      Timed_Out : exception;

   begin
      Start_Conversion (Temperature_Sensor.ADC.all);

      Poll_For_Status (Temperature_Sensor.ADC.all,
                       Regular_Channel_Conversion_Complete,
                       Successful);
      if not Successful then
         raise Timed_Out;
      end if;

      V_Sense := Float (Conversion_Value (Temperature_Sensor.ADC.all));

      Temperature := ((V_Sense - V_At_25_Degrees) / Avg_Slope) + 25.0;
      --  see the RM, section 13.10, pg 411

      T := Temperature;
   end Get;

begin
   Initialize;
end Temperature.Sensor;
