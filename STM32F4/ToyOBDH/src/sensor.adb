------------------------------------------------------------------------------
--                                                                          --
--          Copyright (C) 2018, Universidad PolitÃ©cnica de Madrid           --
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

--  Temperature sensor implementation.

--  This version is for a TMP36 sensor connected to GPIO pin 5 of
--  the F429 Discovery Board. See the board user manual and the
--  mapping in STM32.ADC.

with STM32.Board;  use STM32.Board;
with STM32.Device; use STM32.Device;

with HAL;          use HAL;
with STM32.ADC;    use STM32.ADC;
with STM32.GPIO;   use STM32.GPIO;

package body Sensor is

   --  ADC parameters

   Converter_temperature     : Analog_To_Digital_Converter renames ADC_1;
   Input_Channel_temperature : constant Analog_Input_Channel := 5;
   Input_temperature         : constant GPIO_Point := PA5;


   Converter_light     : Analog_To_Digital_Converter renames ADC_2;
   Input_Channel_light : constant Analog_Input_Channel := 3;
   Input_ligth         : constant GPIO_Point := PA3;
   --  Local subprograms

   procedure Initialize;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize is

      All_Regular_Conversions_temperature : constant Regular_Channel_Conversions :=
        (1 => (Channel     => Input_Channel_temperature,
               Sample_Time => Sample_144_Cycles));  -- needs 10 us minimum
            All_Regular_Conversions_light : constant Regular_Channel_Conversions :=
        (1 => (Channel     => Input_Channel_light,
               Sample_Time => Sample_144_Cycles));  -- needs 10 us minimum

   begin
      Initialize_LEDs;

      Enable_Clock (Input_temperature);
      Enable_Clock (Input_ligth);
      Configure_IO (Input_temperature, (Mode => Mode_Analog, Resistors => Floating));
      Configure_IO (Input_ligth, (Mode => Mode_Analog, Resistors => Floating));

      Enable_Clock (Converter_temperature);
      Enable_Clock (Converter_light);
      Reset_All_ADC_Units;

      Configure_Common_Properties
        (Mode           => Independent,
         Prescalar      => PCLK2_Div_2,
         DMA_Mode       => Disabled,
         Sampling_Delay => Sampling_Delay_5_Cycles);

      Configure_Unit
        (Converter_temperature,
         Resolution => ADC_Resolution_12_Bits,
         Alignment  => Right_Aligned);

      Configure_Unit
        (Converter_light,
         Resolution => ADC_Resolution_12_Bits,
         Alignment  => Right_Aligned);

      Configure_Regular_Conversions
        (Converter_temperature,
         Continuous  => False,
         Trigger     => Software_Triggered,
         Enable_EOC  => True,
         Conversions => All_Regular_Conversions_temperature);

      Configure_Regular_Conversions
        (Converter_light,
         Continuous  => False,
         Trigger     => Software_Triggered,
         Enable_EOC  => True,
         Conversions => All_Regular_Conversions_light);


      Enable (Converter_temperature);
      Enable (Converter_light);

   end Initialize;

   ---------
   -- Get --
   ---------

   procedure Get (Reading : out Sensors_Output) is
      Successful : Boolean;
   begin
      Start_Conversion (Converter_temperature);
      Start_Conversion (Converter_light);
      Poll_For_Status (Converter_temperature,
                       Regular_Channel_Conversion_Complete,
                       Successful);
      Poll_For_Status (Converter_light,
                       Regular_Channel_Conversion_Complete,
                       Successful);
      if not Successful then
--           Red_LED.Toggle;
         Reading.Temperature := 0;
         Reading.Light := 0;
      else
--           Green_LED.Toggle;
         Reading.Temperature := Sensor_Reading (Conversion_Value (Converter_temperature));
         Reading.Light := Sensor_Reading (Conversion_Value (Converter_light));
      end if;
   end Get;

begin
   Initialize;
end Sensor;
