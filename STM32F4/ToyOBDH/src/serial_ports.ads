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
-- of the license.                                                          --
--                                                                          --
------------------------------------------------------------------------------

--  Streaming serial port for serial communication interface

with HAL;           use HAL;
with STM32;         use STM32;
with STM32.GPIO;    use STM32.GPIO;
with STM32.Device;  use STM32.Device;
with STM32.USARTs;  use STM32.USARTs;

with Ada.Streams;
with Ada.Real_Time; use Ada.Real_Time;

package Serial_Ports is

   ---------------------------
   -- Peripheral descriptor --
   ---------------------------

   type Peripheral_Descriptor is record
      Transceiver    : not null access USART;
      Transceiver_AF : GPIO_Alternate_Function;
      Tx_Pin         : GPIO_Point;
      Rx_Pin         : GPIO_Point;
   end record;

   -----------------
   -- Serial port --
   -----------------

   type Serial_Port (Device : not null access Peripheral_Descriptor) is
     new Ada.Streams.Root_Stream_Type with record
         Initialized : Boolean := False;
         Timeout     : Time_Span := Time_Span_Last;
      --Timeout : Time_Span := Milliseconds(1500); --Time_Span_Last;--
   end record;

   procedure Initialize (This : in out Serial_Port)
     with Post => Initialized (This);

   function Initialized (This : Serial_Port) return Boolean with Inline;

   procedure Configure
     (This      : in out Serial_Port;
      Baud_Rate : Baud_Rates;
      Parity    : Parities     := No_Parity;
      Data_Bits : Word_Lengths := Word_Length_8;
      End_Bits  : Stop_Bits    := Stopbits_1;
      Control   : Flow_Control := No_Flow_Control)
     with
       Pre => Initialized (This);


   procedure Set_Read_Timeout
     (This : in out Serial_Port;
      Wait : Time_Span := Time_Span_Last);
   --  Calls to Read (below) can either wait indefinitely or
   --  be set to return any current values received after a given interval.
   --  If the default value of Time_Span_Last is taken on a call, the effect is
   --  essentially to wait forever, i.e., blocking. That is also the effect if
   --  this routine is never called.

   overriding
   procedure Read
     (This   : in out Serial_Port;
      Buffer : out Ada.Streams.Stream_Element_Array;
      Last   : out Ada.Streams.Stream_Element_Offset);

   overriding
   procedure Write
     (This   : in out Serial_Port;
      Buffer : Ada.Streams.Stream_Element_Array);

   ------------------------
   -- Serial definitions --
   ------------------------

   Peripheral : aliased Peripheral_Descriptor :=
     (Transceiver    => USART_1'Access,
      Transceiver_AF => GPIO_AF_USART1_7,
      Tx_Pin         => PB6,
      Rx_Pin         => PB7);

   Port : aliased Serial_Port (Peripheral'Access);


end Serial_Ports;
