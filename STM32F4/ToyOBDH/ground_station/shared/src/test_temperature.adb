with HK_Data.TMP36; use HK_Data.TMP36;
with Ada.Text_IO;   use Ada.Text_IO;

procedure Test_Temperature is
begin
   Put_Line ("0000: " & Temperature (0000)'Img);
   Put_Line ("0931: " & Temperature (0931)'Img);
   Put_Line ("1024: " & Temperature (1024)'Img);
   Put_Line ("4095: " & Temperature (4095)'Img);
end Test_Temperature;
