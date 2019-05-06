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

with Ada.Streams;   use Ada.Streams;
with STM32.Board;  use STM32.Board;

package body Serial_Ports is

   ------------------------
   -- Internal procedures--
   ------------------------

   procedure Await_Data_Available
     (This      : USART;
      Timeout   : Time_Span := Time_Span_Last;
      Timed_Out : out Boolean)
     with Inline;

   procedure Await_Send_Ready (This : USART)
     with Inline;

   function Last_Index
     (First : Stream_Element_Offset;
      Count : Long_Integer)
      return Stream_Element_Offset
     with Inline;


   --------------------------
   -- Await_Data_Available --
   --------------------------

   procedure Await_Data_Available
     (This      : USART;
      Timeout   : Time_Span := Time_Span_Last;
      Timed_Out : out Boolean)
   is
      Deadline : constant Time := Clock + Timeout;
   begin
      Timed_Out := True;
      while Clock < Deadline loop
         if Rx_Ready (This) then
            Timed_Out := False;
            exit;
         end if;
      end loop;
   end Await_Data_Available;

   ----------------------
   -- Await_Send_Ready --
   ----------------------

   procedure Await_Send_Ready (This : USART) is
   begin
      loop
         exit when Tx_Ready (This);
      end loop;
   end Await_Send_Ready;

   ----------------
   -- Last_Index --
   ----------------

   function Last_Index
     (First : Stream_Element_Offset;
      Count : Long_Integer)
      return Stream_Element_Offset
   is
   begin
      if First = Stream_Element_Offset'First and then Count = 0 then
         --  we need to return First - 1, but cannot
         raise Constraint_Error;  --  per RM
      else
         return First + Stream_Element_Offset (Count) - 1;
      end if;
   end Last_Index;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize (This : in out Serial_Port) is
      Configuration : GPIO_Port_Configuration;
      Device_Pins   : constant GPIO_Points
        := This.Device.Rx_Pin & This.Device.Tx_Pin;
   begin
      Initialize_LEDs;
      Enable_Clock (Device_Pins);
      Enable_Clock (This.Device.Transceiver.all);

      Configuration := (Mode           => Mode_AF,
                        AF             => This.Device.Transceiver_AF,
                        AF_Speed       => Speed_50MHz,
                        AF_Output_Type => Push_Pull,
                        Resistors      => Pull_Up);

      Configure_IO (Device_Pins, Configuration);
      This.Initialized := True;
   end Initialize;


   -----------------
   -- Initialized --
   -----------------

   function Initialized (This : Serial_Port) return Boolean is
     (This.Initialized);

   ---------------
   -- Configure --
   ---------------

   procedure Configure
     (This      : in out Serial_Port;
      Baud_Rate : Baud_Rates;
      Parity    : Parities     := No_Parity;
      Data_Bits : Word_Lengths := Word_Length_8;
      End_Bits  : Stop_Bits    := Stopbits_1;
      Control   : Flow_Control := No_Flow_Control)
   is
   begin
      Disable (This.Device.Transceiver.all);

      Set_Baud_Rate    (This.Device.Transceiver.all, Baud_Rate);
      Set_Mode         (This.Device.Transceiver.all, Tx_Rx_Mode);
      Set_Stop_Bits    (This.Device.Transceiver.all, End_Bits);
      Set_Word_Length  (This.Device.Transceiver.all, Data_Bits);
      Set_Parity       (This.Device.Transceiver.all, Parity);
      Set_Flow_Control (This.Device.Transceiver.all, Control);

      Enable (This.Device.Transceiver.all);
   end Configure;

   ----------------------
   -- Set_Read_Timeout --
   ----------------------

   procedure Set_Read_Timeout
     (This : in out Serial_Port;
      Wait : Time_Span := Time_Span_Last)
   is
   begin
      This.Timeout := Wait;
   end Set_Read_Timeout;

   ----------
   -- Read --
   ----------

   overriding procedure Read
     (This   : in out Serial_Port;
      Buffer : out Ada.Streams.Stream_Element_Array;
      Last   : out Ada.Streams.Stream_Element_Offset)
   is
      Raw       : UInt9;
      Timed_Out : Boolean;
      Count     : Long_Integer := 0;
   begin
      Receiving : for K in Buffer'Range loop
         Await_Data_Available (This.Device.Transceiver.all, This.Timeout, Timed_Out);
         exit Receiving when Timed_Out;
         Receive (This.Device.Transceiver.all, Raw);
         Buffer (K) := Stream_Element (Raw);
         Count := Count + 1;
      end loop Receiving;
      Last := Last_Index (Buffer'First, Count);
   end Read;

   -----------
   -- Write --
   -----------

   overriding procedure Write
     (This   : in out Serial_Port;
      Buffer : Ada.Streams.Stream_Element_Array)
   is
   begin
      for Next of Buffer loop
         Red_LED.Toggle;
         Await_Send_Ready (This.Device.Transceiver.all);
         Transmit (This.Device.Transceiver.all, Stream_Element'Pos (Next));
      end loop;
      Red_LED.Toggle;
   end Write;

end Serial_Ports;
