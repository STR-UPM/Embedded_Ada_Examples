package body HK_Data.TMP36 is

   V_Ref       : constant := 2.930; -- V (measured value)
   V_25C       : constant := 0.750; -- V
   Scale       : constant := 0.010; -- V/C
   Calibration : constant := -1.0;  -- C (experimental calibration)

   Min_Temp  : constant := Temperature_Range'First;
   Max_Temp  : constant := Temperature_Range'Last;
   Max_Count : constant := 4096.0; -- for 12-bit conversion resolution

   -----------------
   -- Temperature --
   -----------------

   function Temperature
     (R : Sensor_Reading)
      return Temperature_Range
   is
      V : Float;
      T : Float;
   begin
      V := Float(R)*V_Ref/Max_Count;   -- volts
      T := (V - V_25C) / Scale + 25.0; -- degrees C
      T := T + Calibration;
      T := Float'Max (T, Min_Temp);
      T := Float'Min (T, Max_Temp);
      return Temperature_Range (T);
   end Temperature;

   -----------
   -- Light --
   -----------

   function Light
     (R : Sensor_Reading)
      return Light_Range
   is
   begin
      return Light_Range (100.0*Float(R)/Max_Count);
   end Light;


end HK_Data.TMP36;
