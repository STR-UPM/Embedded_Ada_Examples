with HK_Data;  use HK_Data;
with TTC_Data; use TTC_Data;

package TTC is

   procedure Receive (Data : out Sensor_Reading);

   function Next_TM return TM_Message;

end TTC;
