pragma Warnings (Off);
pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b__ground_station.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__ground_station.adb");
pragma Suppress (Overflow_Check);

with System.Restrictions;
with Ada.Exceptions;

package body ada_main is

   E077 : Short_Integer; pragma Import (Ada, E077, "system__os_lib_E");
   E015 : Short_Integer; pragma Import (Ada, E015, "system__soft_links_E");
   E027 : Short_Integer; pragma Import (Ada, E027, "system__exception_table_E");
   E072 : Short_Integer; pragma Import (Ada, E072, "ada__io_exceptions_E");
   E057 : Short_Integer; pragma Import (Ada, E057, "ada__strings_E");
   E042 : Short_Integer; pragma Import (Ada, E042, "ada__containers_E");
   E029 : Short_Integer; pragma Import (Ada, E029, "system__exceptions_E");
   E059 : Short_Integer; pragma Import (Ada, E059, "ada__strings__maps_E");
   E063 : Short_Integer; pragma Import (Ada, E063, "ada__strings__maps__constants_E");
   E047 : Short_Integer; pragma Import (Ada, E047, "interfaces__c_E");
   E023 : Short_Integer; pragma Import (Ada, E023, "system__soft_links__initialize_E");
   E083 : Short_Integer; pragma Import (Ada, E083, "system__object_reader_E");
   E052 : Short_Integer; pragma Import (Ada, E052, "system__dwarf_lines_E");
   E041 : Short_Integer; pragma Import (Ada, E041, "system__traceback__symbolic_E");
   E132 : Short_Integer; pragma Import (Ada, E132, "ada__tags_E");
   E140 : Short_Integer; pragma Import (Ada, E140, "ada__streams_E");
   E148 : Short_Integer; pragma Import (Ada, E148, "system__file_control_block_E");
   E147 : Short_Integer; pragma Import (Ada, E147, "system__finalization_root_E");
   E145 : Short_Integer; pragma Import (Ada, E145, "ada__finalization_E");
   E144 : Short_Integer; pragma Import (Ada, E144, "system__file_io_E");
   E186 : Short_Integer; pragma Import (Ada, E186, "system__storage_pools_E");
   E182 : Short_Integer; pragma Import (Ada, E182, "system__finalization_masters_E");
   E180 : Short_Integer; pragma Import (Ada, E180, "system__storage_pools__subpools_E");
   E172 : Short_Integer; pragma Import (Ada, E172, "ada__strings__unbounded_E");
   E118 : Short_Integer; pragma Import (Ada, E118, "system__task_info_E");
   E112 : Short_Integer; pragma Import (Ada, E112, "system__task_primitives__operations_E");
   E008 : Short_Integer; pragma Import (Ada, E008, "ada__calendar_E");
   E156 : Short_Integer; pragma Import (Ada, E156, "ada__calendar__time_zones_E");
   E103 : Short_Integer; pragma Import (Ada, E103, "ada__real_time_E");
   E138 : Short_Integer; pragma Import (Ada, E138, "ada__text_io_E");
   E151 : Short_Integer; pragma Import (Ada, E151, "gnat__calendar_E");
   E170 : Short_Integer; pragma Import (Ada, E170, "gnat__calendar__time_io_E");
   E242 : Short_Integer; pragma Import (Ada, E242, "system__pool_global_E");
   E237 : Short_Integer; pragma Import (Ada, E237, "gnat__serial_communications_E");
   E211 : Short_Integer; pragma Import (Ada, E211, "system__tasking__initialization_E");
   E221 : Short_Integer; pragma Import (Ada, E221, "system__tasking__protected_objects_E");
   E223 : Short_Integer; pragma Import (Ada, E223, "system__tasking__protected_objects__entries_E");
   E219 : Short_Integer; pragma Import (Ada, E219, "system__tasking__queuing_E");
   E207 : Short_Integer; pragma Import (Ada, E207, "system__tasking__stages_E");
   E233 : Short_Integer; pragma Import (Ada, E233, "ttc_E");
   E005 : Short_Integer; pragma Import (Ada, E005, "tm_receiver_E");

   Sec_Default_Sized_Stacks : array (1 .. 1) of aliased System.Secondary_Stack.SS_Stack (System.Parameters.Runtime_Default_Sec_Stack_Size);

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
   begin
      E223 := E223 - 1;
      declare
         procedure F1;
         pragma Import (Ada, F1, "system__tasking__protected_objects__entries__finalize_spec");
      begin
         F1;
      end;
      E237 := E237 - 1;
      declare
         procedure F2;
         pragma Import (Ada, F2, "gnat__serial_communications__finalize_spec");
      begin
         F2;
      end;
      E242 := E242 - 1;
      declare
         procedure F3;
         pragma Import (Ada, F3, "system__pool_global__finalize_spec");
      begin
         F3;
      end;
      E138 := E138 - 1;
      declare
         procedure F4;
         pragma Import (Ada, F4, "ada__text_io__finalize_spec");
      begin
         F4;
      end;
      E172 := E172 - 1;
      declare
         procedure F5;
         pragma Import (Ada, F5, "ada__strings__unbounded__finalize_spec");
      begin
         F5;
      end;
      E180 := E180 - 1;
      declare
         procedure F6;
         pragma Import (Ada, F6, "system__storage_pools__subpools__finalize_spec");
      begin
         F6;
      end;
      E182 := E182 - 1;
      declare
         procedure F7;
         pragma Import (Ada, F7, "system__finalization_masters__finalize_spec");
      begin
         F7;
      end;
      declare
         procedure F8;
         pragma Import (Ada, F8, "system__file_io__finalize_body");
      begin
         E144 := E144 - 1;
         F8;
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
      Default_Secondary_Stack_Size : System.Parameters.Size_Type;
      pragma Import (C, Default_Secondary_Stack_Size, "__gnat_default_ss_size");
      Leap_Seconds_Support : Integer;
      pragma Import (C, Leap_Seconds_Support, "__gl_leap_seconds_support");
      Bind_Env_Addr : System.Address;
      pragma Import (C, Bind_Env_Addr, "__gl_bind_env_addr");

      procedure Runtime_Initialize (Install_Handler : Integer);
      pragma Import (C, Runtime_Initialize, "__gnat_runtime_initialize");

      Finalize_Library_Objects : No_Param_Proc;
      pragma Import (C, Finalize_Library_Objects, "__gnat_finalize_library_objects");
      Binder_Sec_Stacks_Count : Natural;
      pragma Import (Ada, Binder_Sec_Stacks_Count, "__gnat_binder_ss_count");
      Default_Sized_SS_Pool : System.Address;
      pragma Import (Ada, Default_Sized_SS_Pool, "__gnat_default_ss_pool");

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
           False, False, False, False, False, True, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False),
         Value => (0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
         Violated =>
          (False, False, False, False, True, True, False, False, 
           True, False, False, True, True, True, True, False, 
           False, False, False, False, True, True, False, True, 
           True, False, True, True, True, True, False, False, 
           False, False, False, True, False, False, True, False, 
           True, False, False, True, False, False, False, True, 
           False, False, False, True, False, True, False, False, 
           False, False, False, True, False, True, True, True, 
           False, False, True, False, True, True, True, False, 
           True, True, False, True, True, True, True, False, 
           False, True, False, False, False, False, False, False, 
           True, False, False, False),
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

      ada_main'Elab_Body;
      Default_Secondary_Stack_Size := System.Parameters.Runtime_Default_Sec_Stack_Size;
      Binder_Sec_Stacks_Count := 1;
      Default_Sized_SS_Pool := Sec_Default_Sized_Stacks'Address;

      Runtime_Initialize (1);

      Finalize_Library_Objects := finalize_library'access;

      System.Soft_Links'Elab_Spec;
      System.Exception_Table'Elab_Body;
      E027 := E027 + 1;
      Ada.Io_Exceptions'Elab_Spec;
      E072 := E072 + 1;
      Ada.Strings'Elab_Spec;
      E057 := E057 + 1;
      Ada.Containers'Elab_Spec;
      E042 := E042 + 1;
      System.Exceptions'Elab_Spec;
      E029 := E029 + 1;
      System.Os_Lib'Elab_Body;
      E077 := E077 + 1;
      Ada.Strings.Maps'Elab_Spec;
      Ada.Strings.Maps.Constants'Elab_Spec;
      E063 := E063 + 1;
      Interfaces.C'Elab_Spec;
      System.Soft_Links.Initialize'Elab_Body;
      E023 := E023 + 1;
      E015 := E015 + 1;
      E059 := E059 + 1;
      E047 := E047 + 1;
      System.Object_Reader'Elab_Spec;
      System.Dwarf_Lines'Elab_Spec;
      E052 := E052 + 1;
      System.Traceback.Symbolic'Elab_Body;
      E041 := E041 + 1;
      E083 := E083 + 1;
      Ada.Tags'Elab_Spec;
      Ada.Tags'Elab_Body;
      E132 := E132 + 1;
      Ada.Streams'Elab_Spec;
      E140 := E140 + 1;
      System.File_Control_Block'Elab_Spec;
      E148 := E148 + 1;
      System.Finalization_Root'Elab_Spec;
      E147 := E147 + 1;
      Ada.Finalization'Elab_Spec;
      E145 := E145 + 1;
      System.File_Io'Elab_Body;
      E144 := E144 + 1;
      System.Storage_Pools'Elab_Spec;
      E186 := E186 + 1;
      System.Finalization_Masters'Elab_Spec;
      System.Finalization_Masters'Elab_Body;
      E182 := E182 + 1;
      System.Storage_Pools.Subpools'Elab_Spec;
      E180 := E180 + 1;
      Ada.Strings.Unbounded'Elab_Spec;
      E172 := E172 + 1;
      System.Task_Info'Elab_Spec;
      E118 := E118 + 1;
      System.Task_Primitives.Operations'Elab_Body;
      E112 := E112 + 1;
      Ada.Calendar'Elab_Spec;
      Ada.Calendar'Elab_Body;
      E008 := E008 + 1;
      Ada.Calendar.Time_Zones'Elab_Spec;
      E156 := E156 + 1;
      Ada.Real_Time'Elab_Spec;
      Ada.Real_Time'Elab_Body;
      E103 := E103 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E138 := E138 + 1;
      Gnat.Calendar'Elab_Spec;
      E151 := E151 + 1;
      Gnat.Calendar.Time_Io'Elab_Spec;
      E170 := E170 + 1;
      System.Pool_Global'Elab_Spec;
      E242 := E242 + 1;
      Gnat.Serial_Communications'Elab_Spec;
      E237 := E237 + 1;
      System.Tasking.Initialization'Elab_Body;
      E211 := E211 + 1;
      System.Tasking.Protected_Objects'Elab_Body;
      E221 := E221 + 1;
      System.Tasking.Protected_Objects.Entries'Elab_Spec;
      E223 := E223 + 1;
      System.Tasking.Queuing'Elab_Body;
      E219 := E219 + 1;
      System.Tasking.Stages'Elab_Body;
      E207 := E207 + 1;
      TTC'ELAB_BODY;
      E233 := E233 + 1;
      Tm_Receiver'Elab_Spec;
      Tm_Receiver'Elab_Body;
      E005 := E005 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_ground_station");

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
   --   /home/antonio/workspaceTFG/Embedded_Ada_Examples/STM32F4/ToyOBDH/host_app/obj/hk_data.o
   --   /home/antonio/workspaceTFG/Embedded_Ada_Examples/STM32F4/ToyOBDH/host_app/obj/ttc_data.o
   --   /home/antonio/workspaceTFG/Embedded_Ada_Examples/STM32F4/ToyOBDH/host_app/obj/ttc.o
   --   /home/antonio/workspaceTFG/Embedded_Ada_Examples/STM32F4/ToyOBDH/host_app/obj/tm_receiver.o
   --   /home/antonio/workspaceTFG/Embedded_Ada_Examples/STM32F4/ToyOBDH/host_app/obj/ground_station.o
   --   -L/home/antonio/workspaceTFG/Embedded_Ada_Examples/STM32F4/ToyOBDH/host_app/obj/
   --   -L/home/antonio/workspaceTFG/Embedded_Ada_Examples/STM32F4/ToyOBDH/host_app/obj/
   --   -L/home/antonio/opt/GNAT/2018/lib/gcc/x86_64-pc-linux-gnu/7.3.1/adalib/
   --   -static
   --   -lgnarl
   --   -lgnat
   --   -lpthread
   --   -lrt
   --   -ldl
--  END Object file/option list   

end ada_main;
