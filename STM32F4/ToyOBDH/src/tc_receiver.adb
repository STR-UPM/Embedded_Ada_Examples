------------------------------------------------------------------------------
--                                                                          --
--          Copyright (C) 2018, Universidad PolitÃ©cnica de Madrid      --
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

-- Author: Antonio Ramos Nieto

with Serial_Ports; use Serial_Ports;
with Ada.Real_Time; use Ada.Real_Time;
with TTC_Data; use TTC_Data;
with HK_TM; 
with STM32.Board;  use STM32.Board;


package body TC_Receiver is
   
   ----------------------
   -- TC_Receiver_Task --
   ----------------------
   
   task body TC_Receiver_Task is
   begin
      loop
         receive:
         begin
            declare
               pragma Warnings (Off); -- Just to remove warning when building
               received : TC_Message := TC_Message'Input (Port'Access);
               pragma Warnings (On);
            begin
               Green_LED.Toggle; --toggle the green led
               HK_TM.Send; --send housekeeping message
            end;
         exception
            when others => delay until Clock + Milliseconds (100);
         end receive;
      end loop;
   end TC_Receiver_Task;

   
end TC_Receiver;
