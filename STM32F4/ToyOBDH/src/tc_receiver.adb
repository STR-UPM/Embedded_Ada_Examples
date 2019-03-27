

with STM32.Device; use STM32.Device;
with Serial_Ports; use Serial_Ports;
with Ada.Real_Time; use Ada.Real_Time;
with TTC_Data; use TTC_Data;
with HK_TM; 
with STM32.Board;  use STM32.Board;


package body TC_Receiver is
   
   Peripheral : aliased Peripheral_Descriptor :=
     (Transceiver    => USART_1'Access,
      Transceiver_AF => GPIO_AF_USART1_7,
      Tx_Pin         => PB6,
      Rx_Pin         => PB7);

   Port : aliased Serial_Port (Peripheral'Access);
   

      

   task body TC_Receiver_Task is
     
   begin

      loop

         receive:
         begin
            declare
               pragma Warnings (Off, "variable ""received"" is not referenced"); -- Just to remove warning when building
               received : TC_Message := TC_Message'Input (Port'Access);
               pragma Warnings (On, "variable ""received"" is not referenced");
            begin
               Green_LED.Toggle;
               HK_TM.Send;
            end;
         exception
            when others => delay until Clock + Milliseconds (100);
               
            
            
         end receive;
      end loop;


   end TC_Receiver_Task;


   
end TC_Receiver;
