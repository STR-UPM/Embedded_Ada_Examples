pragma Warnings (Off);
pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b__host.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__host.adb");
pragma Suppress (Overflow_Check);

with System.Restrictions;
with Ada.Exceptions;

package body ada_main is

   E077 : Short_Integer; pragma Import (Ada, E077, "system__os_lib_E");
   E015 : Short_Integer; pragma Import (Ada, E015, "system__soft_links_E");
   E025 : Short_Integer; pragma Import (Ada, E025, "system__exception_table_E");
   E072 : Short_Integer; pragma Import (Ada, E072, "ada__io_exceptions_E");
   E057 : Short_Integer; pragma Import (Ada, E057, "ada__strings_E");
   E040 : Short_Integer; pragma Import (Ada, E040, "ada__containers_E");
   E027 : Short_Integer; pragma Import (Ada, E027, "system__exceptions_E");
   E019 : Short_Integer; pragma Import (Ada, E019, "system__secondary_stack_E");
   E059 : Short_Integer; pragma Import (Ada, E059, "ada__strings__maps_E");
   E063 : Short_Integer; pragma Import (Ada, E063, "ada__strings__maps__constants_E");
   E045 : Short_Integer; pragma Import (Ada, E045, "interfaces__c_E");
   E083 : Short_Integer; pragma Import (Ada, E083, "system__object_reader_E");
   E052 : Short_Integer; pragma Import (Ada, E052, "system__dwarf_lines_E");
   E039 : Short_Integer; pragma Import (Ada, E039, "system__traceback__symbolic_E");
   E109 : Short_Integer; pragma Import (Ada, E109, "ada__tags_E");
   E107 : Short_Integer; pragma Import (Ada, E107, "ada__streams_E");
   E164 : Short_Integer; pragma Import (Ada, E164, "system__file_control_block_E");
   E149 : Short_Integer; pragma Import (Ada, E149, "system__finalization_root_E");
   E147 : Short_Integer; pragma Import (Ada, E147, "ada__finalization_E");
   E163 : Short_Integer; pragma Import (Ada, E163, "system__file_io_E");
   E192 : Short_Integer; pragma Import (Ada, E192, "ada__streams__stream_io_E");
   E151 : Short_Integer; pragma Import (Ada, E151, "system__storage_pools_E");
   E144 : Short_Integer; pragma Import (Ada, E144, "system__finalization_masters_E");
   E142 : Short_Integer; pragma Import (Ada, E142, "system__storage_pools__subpools_E");
   E136 : Short_Integer; pragma Import (Ada, E136, "ada__strings__unbounded_E");
   E210 : Short_Integer; pragma Import (Ada, E210, "system__task_info_E");
   E206 : Short_Integer; pragma Import (Ada, E206, "system__task_primitives__operations_E");
   E008 : Short_Integer; pragma Import (Ada, E008, "ada__calendar_E");
   E103 : Short_Integer; pragma Import (Ada, E103, "ada__calendar__delays_E");
   E121 : Short_Integer; pragma Import (Ada, E121, "ada__calendar__time_zones_E");
   E240 : Short_Integer; pragma Import (Ada, E240, "ada__real_time_E");
   E159 : Short_Integer; pragma Import (Ada, E159, "ada__text_io_E");
   E116 : Short_Integer; pragma Import (Ada, E116, "gnat__calendar_E");
   E134 : Short_Integer; pragma Import (Ada, E134, "gnat__calendar__time_io_E");
   E182 : Short_Integer; pragma Import (Ada, E182, "system__pool_global_E");
   E176 : Short_Integer; pragma Import (Ada, E176, "gnat__serial_communications_E");
   E216 : Short_Integer; pragma Import (Ada, E216, "system__tasking__initialization_E");
   E226 : Short_Integer; pragma Import (Ada, E226, "system__tasking__protected_objects_E");
   E228 : Short_Integer; pragma Import (Ada, E228, "system__tasking__protected_objects__entries_E");
   E224 : Short_Integer; pragma Import (Ada, E224, "system__tasking__queuing_E");
   E194 : Short_Integer; pragma Import (Ada, E194, "system__tasking__stages_E");
   E005 : Short_Integer; pragma Import (Ada, E005, "tm_receiver_E");

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
   begin
      E228 := E228 - 1;
      declare
         procedure F1;
         pragma Import (Ada, F1, "system__tasking__protected_objects__entries__finalize_spec");
      begin
         F1;
      end;
      E176 := E176 - 1;
      declare
         procedure F2;
         pragma Import (Ada, F2, "gnat__serial_communications__finalize_spec");
      begin
         F2;
      end;
      E182 := E182 - 1;
      declare
         procedure F3;
         pragma Import (Ada, F3, "system__pool_global__finalize_spec");
      begin
         F3;
      end;
      E159 := E159 - 1;
      declare
         procedure F4;
         pragma Import (Ada, F4, "ada__text_io__finalize_spec");
      begin
         F4;
      end;
      E136 := E136 - 1;
      declare
         procedure F5;
         pragma Import (Ada, F5, "ada__strings__unbounded__finalize_spec");
      begin
         F5;
      end;
      E142 := E142 - 1;
      declare
         procedure F6;
         pragma Import (Ada, F6, "system__storage_pools__subpools__finalize_spec");
      begin
         F6;
      end;
      E144 := E144 - 1;
      declare
         procedure F7;
         pragma Import (Ada, F7, "system__finalization_masters__finalize_spec");
      begin
         F7;
      end;
      E192 := E192 - 1;
      declare
         procedure F8;
         pragma Import (Ada, F8, "ada__streams__stream_io__finalize_spec");
      begin
         F8;
      end;
      declare
         procedure F9;
         pragma Import (Ada, F9, "system__file_io__finalize_body");
      begin
         E163 := E163 - 1;
         F9;
      end;
      declare
         procedure Reraise_Library_Exception_If_Any;
            pragma Import (Ada, Reraise_Library_Exception_If_Any, "__gnat_reraise_library_exception_if_any");
      begin
         Reraise_Library_Exception_If_Any;
      end;
   end finalize_library;

   procedure adafinal is
      procedure s_stalib_adafinal;
      pragma Import (C, s_stalib_adafinal, "system__standard_library__adafinal");

      procedure Runtime_Finalize;
      pragma Import (C, Runtime_Finalize, "__gnat_runtime_finalize");

   begin
      if not Is_Elaborated then
         return;
      end if;
      Is_Elaborated := False;
      Runtime_Finalize;
      s_stalib_adafinal;
   end adafinal;

   type No_Param_Proc is access procedure;

   procedure adainit is
      Main_Priority : Integer;
      pragma Import (C, Main_Priority, "__gl_main_priority");
      Time_Slice_Value : Integer;
      pragma Import (C, Time_Slice_Value, "__gl_time_slice_val");
      WC_Encoding : Character;
      pragma Import (C, WC_Encoding, "__gl_wc_encoding");
      Locking_Policy : Character;
      pragma Import (C, Locking_Policy, "__gl_locking_policy");
      Queuing_Policy : Character;
      pragma Import (C, Queuing_Policy, "__gl_queuing_policy");
      Task_Dispatching_Policy : Character;
      pragma Import (C, Task_Dispatching_Policy, "__gl_task_dispatching_policy");
      Priority_Specific_Dispatching : System.Address;
      pragma Import (C, Priority_Specific_Dispatching, "__gl_priority_specific_dispatching");
      Num_Specific_Dispatching : Integer;
      pragma Import (C, Num_Specific_Dispatching, "__gl_num_specific_dispatching");
      Main_CPU : Integer;
      pragma Import (C, Main_CPU, "__gl_main_cpu");
      Interrupt_States : System.Address;
      pragma Import (C, Interrupt_States, "__gl_interrupt_states");
      Num_Interrupt_States : Integer;
      pragma Import (C, Num_Interrupt_States, "__gl_num_interrupt_states");
      Unreserve_All_Interrupts : Integer;
      pragma Import (C, Unreserve_All_Interrupts, "__gl_unreserve_all_interrupts");
      Detect_Blocking : Integer;
      pragma Import (C, Detect_Blocking, "__gl_detect_blocking");
      Default_Stack_Size : Integer;
      pragma Import (C, Default_Stack_Size, "__gl_default_stack_size");
      Leap_Seconds_Support : Integer;
      pragma Import (C, Leap_Seconds_Support, "__gl_leap_seconds_support");
      Bind_Env_Addr : System.Address;
      pragma Import (C, Bind_Env_Addr, "__gl_bind_env_addr");

      procedure Runtime_Initialize (Install_Handler : Integer);
      pragma Import (C, Runtime_Initialize, "__gnat_runtime_initialize");

      Finalize_Library_Objects : No_Param_Proc;
      pragma Import (C, Finalize_Library_Objects, "__gnat_finalize_library_objects");
   begin
      if Is_Elaborated then
         return;
      end if;
      Is_Elaborated := True;
      Main_Priority := -1;
      Time_Slice_Value := -1;
      WC_Encoding := 'b';
      Locking_Policy := ' ';
      Queuing_Policy := ' ';
      Task_Dispatching_Policy := ' ';
      System.Restrictions.Run_Time_Restrictions :=
        (Set =>
          (False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, True, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False),
         Value => (0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
         Violated =>
          (False, False, False, True, True, False, False, True, 
           False, False, True, True, True, True, False, False, 
           False, False, False, True, True, False, True, True, 
           False, True, True, True, True, False, False, False, 
           False, False, True, False, False, True, False, True, 
           False, False, True, False, True, False, True, False, 
           False, False, True, False, True, False, False, False, 
           False, False, True, False, True, True, True, False, 
           False, True, False, True, True, True, False, True, 
           True, False, True, True, True, True, False, False, 
           True, False, False, False, False, False, False, True, 
           False, False, False),
         Count => (0, 0, 0, 0, 0, 0, 1, 0, 0, 0),
         Unknown => (False, False, False, False, False, False, False, False, False, False));
      Priority_Specific_Dispatching :=
        Local_Priority_Specific_Dispatching'Address;
      Num_Specific_Dispatching := 0;
      Main_CPU := -1;
      Interrupt_States := Local_Interrupt_States'Address;
      Num_Interrupt_States := 0;
      Unreserve_All_Interrupts := 0;
      Detect_Blocking := 0;
      Default_Stack_Size := -1;
      Leap_Seconds_Support := 0;

      Runtime_Initialize (1);

      Finalize_Library_Objects := finalize_library'access;

      System.Soft_Links'Elab_Spec;
      System.Exception_Table'Elab_Body;
      E025 := E025 + 1;
      Ada.Io_Exceptions'Elab_Spec;
      E072 := E072 + 1;
      Ada.Strings'Elab_Spec;
      E057 := E057 + 1;
      Ada.Containers'Elab_Spec;
      E040 := E040 + 1;
      System.Exceptions'Elab_Spec;
      E027 := E027 + 1;
      System.Soft_Links'Elab_Body;
      E015 := E015 + 1;
      System.Os_Lib'Elab_Body;
      E077 := E077 + 1;
      Ada.Strings.Maps'Elab_Spec;
      Ada.Strings.Maps.Constants'Elab_Spec;
      E063 := E063 + 1;
      Interfaces.C'Elab_Spec;
      System.Secondary_Stack'Elab_Body;
      E019 := E019 + 1;
      E059 := E059 + 1;
      E045 := E045 + 1;
      System.Object_Reader'Elab_Spec;
      System.Dwarf_Lines'Elab_Spec;
      E052 := E052 + 1;
      System.Traceback.Symbolic'Elab_Body;
      E039 := E039 + 1;
      E083 := E083 + 1;
      Ada.Tags'Elab_Spec;
      Ada.Tags'Elab_Body;
      E109 := E109 + 1;
      Ada.Streams'Elab_Spec;
      E107 := E107 + 1;
      System.File_Control_Block'Elab_Spec;
      E164 := E164 + 1;
      System.Finalization_Root'Elab_Spec;
      E149 := E149 + 1;
      Ada.Finalization'Elab_Spec;
      E147 := E147 + 1;
      System.File_Io'Elab_Body;
      E163 := E163 + 1;
      Ada.Streams.Stream_Io'Elab_Spec;
      E192 := E192 + 1;
      System.Storage_Pools'Elab_Spec;
      E151 := E151 + 1;
      System.Finalization_Masters'Elab_Spec;
      System.Finalization_Masters'Elab_Body;
      E144 := E144 + 1;
      System.Storage_Pools.Subpools'Elab_Spec;
      E142 := E142 + 1;
      Ada.Strings.Unbounded'Elab_Spec;
      E136 := E136 + 1;
      System.Task_Info'Elab_Spec;
      E210 := E210 + 1;
      System.Task_Primitives.Operations'Elab_Body;
      E206 := E206 + 1;
      Ada.Calendar'Elab_Spec;
      Ada.Calendar'Elab_Body;
      E008 := E008 + 1;
      Ada.Calendar.Delays'Elab_Body;
      E103 := E103 + 1;
      Ada.Calendar.Time_Zones'Elab_Spec;
      E121 := E121 + 1;
      Ada.Real_Time'Elab_Spec;
      Ada.Real_Time'Elab_Body;
      E240 := E240 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E159 := E159 + 1;
      Gnat.Calendar'Elab_Spec;
      E116 := E116 + 1;
      Gnat.Calendar.Time_Io'Elab_Spec;
      E134 := E134 + 1;
      System.Pool_Global'Elab_Spec;
      E182 := E182 + 1;
      Gnat.Serial_Communications'Elab_Spec;
      E176 := E176 + 1;
      System.Tasking.Initialization'Elab_Body;
      E216 := E216 + 1;
      System.Tasking.Protected_Objects'Elab_Body;
      E226 := E226 + 1;
      System.Tasking.Protected_Objects.Entries'Elab_Spec;
      E228 := E228 + 1;
      System.Tasking.Queuing'Elab_Body;
      E224 := E224 + 1;
      System.Tasking.Stages'Elab_Body;
      E194 := E194 + 1;
      Tm_Receiver'Elab_Spec;
      Tm_Receiver'Elab_Body;
      E005 := E005 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_host");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer
   is
      procedure Initialize (Addr : System.Address);
      pragma Import (C, Initialize, "__gnat_initialize");

      procedure Finalize;
      pragma Import (C, Finalize, "__gnat_finalize");
      SEH : aliased array (1 .. 2) of Integer;

      Ensure_Reference : aliased System.Address := Ada_Main_Program_Name'Address;
      pragma Volatile (Ensure_Reference);

   begin
      gnat_argc := argc;
      gnat_argv := argv;
      gnat_envp := envp;

      Initialize (SEH'Address);
      adainit;
      Ada_Main_Program;
      adafinal;
      Finalize;
      return (gnat_exit_status);
   end;

--  BEGIN Object file/option list
   --   /home/jpuente/Projects/Embedded_Ada_Examples/STM32F4/ToyOBDH/host_app/obj/tm_receiver.o
   --   /home/jpuente/Projects/Embedded_Ada_Examples/STM32F4/ToyOBDH/host_app/obj/host.o
   --   -L/home/jpuente/Projects/Embedded_Ada_Examples/STM32F4/ToyOBDH/host_app/obj/
   --   -L/home/jpuente/Projects/Embedded_Ada_Examples/STM32F4/ToyOBDH/host_app/obj/
   --   -L/usr/gnatx86/lib/gcc/x86_64-pc-linux-gnu/6.3.1/adalib/
   --   -static
   --   -lgnarl
   --   -lgnat
   --   -lpthread
   --   -lrt
   --   -ldl
--  END Object file/option list   

end ada_main;
