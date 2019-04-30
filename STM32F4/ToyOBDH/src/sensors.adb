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

--  Author: Antonio Ramos Nieto
--  Modified for MUSE lab by Juan A. de la Puente

--  Temperature sensor implementation.

--  This version is for a TMP36 sensor connected to GPIO pin 5 of
--  the F429 Discovery Board. See the board user manual and the
--  mapping in STM32.ADC.


package body Sensors is

   Converter : Analog_To_Digital_Converter renames ADC_1;

   --  Local subprograms

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize
     (This          : in out Sensor;
      Input_Channel : in Analog_Input_Channel;
      Input_Point   : in GPIO_Point) is
   begin
      This.Input_Channel := Input_Channel;
      This.Input_Point := Input_Point;
   end Initialize;

   --------------------
   -- Get Temperature--
   --------------------

   procedure Get (This    : in Sensor;
                  Reading : out Sensor_Reading) is

      All_Regular_Conversions : constant Regular_Channel_Conversions :=
        (1 => (Channel     => This.Input_Channel,
               Sample_Time => Sample_144_Cycles));  -- needs 10 us minimum

      Successful : Boolean;

   begin

      --Initialize converters
      Enable_Clock (This.Input_Point);
      Configure_IO (This.Input_Point, (Mode => Mode_Analog, Resistors => Floating));
      Enable_Clock (Converter);
      Reset_All_ADC_Units;

      Configure_Common_Properties
        (Mode           => Independent,
         Prescalar      => PCLK2_Div_2,
         DMA_Mode       => Disabled,
         Sampling_Delay => Sampling_Delay_5_Cycles);

      Configure_Unit
        (Converter,
         Resolution => ADC_Resolution_12_Bits,
         Alignment  => Right_Aligned);

      Configure_Regular_Conversions
        (Converter,
         Continuous  => False,
         Trigger     => Software_Triggered,
         Enable_EOC  => True,
         Conversions => All_Regular_Conversions);

      -- Read value
      Enable (Converter);
      Start_Conversion (Converter);
      Poll_For_Status (Converter,
                       Regular_Channel_Conversion_Complete,
                       Successful);
      Poll_For_Status (Converter,
                       Regular_Channel_Conversion_Complete,
                       Successful);
      if not Successful then
         Reading := 0;
      else
         Reading:= Sensor_Reading (Conversion_Value (Converter)); -- read sensor
      end if;
   end Get;

end Sensors;
