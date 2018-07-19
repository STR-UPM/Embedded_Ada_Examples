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

--  The implementation of the TM package uses a serial interface
--  to send telemetry messages to the ground station.

with STM32.Device; use STM32.Device;
with Serial_Ports; use Serial_Ports;

--  with HK_Data; use HK_Data;

package body TTC is

   Peripheral : aliased Peripheral_Descriptor :=
     (Transceiver    => USART_1'Access,
      Transceiver_AF => GPIO_AF_USART1_7,
      Tx_Pin         => PB6,
      Rx_Pin         => PB7);

   Port : aliased Serial_Port (Peripheral'Access);

   -------------------------
   -- Internal procedures --
   -------------------------

   procedure Initialize;

   ----------
   -- Send --
   ----------

   procedure Send (TM : TM_Message) is
   begin
      TM_Message'Output (Port'Access, TM);
   end Send;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize is
   begin
      Initialize (Port);
      Configure (Port, Baud_Rate => 115_200);
   end Initialize;

begin
   Initialize;
end TTC;
