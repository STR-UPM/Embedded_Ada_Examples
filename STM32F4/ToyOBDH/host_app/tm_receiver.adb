

with TTC;

with Ada.Calendar;           use Ada.Calendar;
with GNAT.Calendar.Time_IO;  use GNAT.Calendar.Time_IO;

with Ada.Text_IO;            use Ada.Text_IO;

with Ada.Exceptions;         use Ada.Exceptions;
with Ada.IO_Exceptions;

with HK_Data;  use HK_Data;
with TTC_Data; use TTC_Data;

with Ada.Real_Time; use Ada.Real_Time;

package body TM_Receiver is

   ----------------------
   -- TM_Receiver_task --
   ----------------------

   task body TM_Receiver_Task is
   begin
      begin
         loop
            begin
               declare
                  Message : TM_Message := TTC.Next_TM;
               begin
                  Put_Line (Image(Clock, "%T ") &
                              "TM " & Message.Data.Value'Img &
                              " : "  & Message.Data.Timestamp'Img);
                  --                 TTC.Receive (Data);
                  --                 Put_Line (Image(Clock, "%T ") &
                  --                             "TM " & Data'Img);
               end;
            exception
               when E: Ada.IO_Exceptions.End_Error =>
                  Put_Line ("Rx error " & Exception_Message (E));
               when E : others =>
                  Put_Line (Exception_Message (E));
            end;
         end loop;

      exception
         when E : others =>
            Put_Line ("-- fatal error " & Exception_Message (E));
      end;
   end TM_Receiver_Task;

end TM_Receiver;
