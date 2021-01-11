pragma Warnings (Off);
pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b__main.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__main.adb");
pragma Suppress (Overflow_Check);

with System.Restrictions;
with Ada.Exceptions;

package body ada_main is

   E074 : Short_Integer; pragma Import (Ada, E074, "system__os_lib_E");
   E010 : Short_Integer; pragma Import (Ada, E010, "ada__exceptions_E");
   E015 : Short_Integer; pragma Import (Ada, E015, "system__soft_links_E");
   E027 : Short_Integer; pragma Import (Ada, E027, "system__exception_table_E");
   E042 : Short_Integer; pragma Import (Ada, E042, "ada__containers_E");
   E070 : Short_Integer; pragma Import (Ada, E070, "ada__io_exceptions_E");
   E054 : Short_Integer; pragma Import (Ada, E054, "ada__strings_E");
   E056 : Short_Integer; pragma Import (Ada, E056, "ada__strings__maps_E");
   E060 : Short_Integer; pragma Import (Ada, E060, "ada__strings__maps__constants_E");
   E080 : Short_Integer; pragma Import (Ada, E080, "interfaces__c_E");
   E029 : Short_Integer; pragma Import (Ada, E029, "system__exceptions_E");
   E082 : Short_Integer; pragma Import (Ada, E082, "system__object_reader_E");
   E049 : Short_Integer; pragma Import (Ada, E049, "system__dwarf_lines_E");
   E023 : Short_Integer; pragma Import (Ada, E023, "system__soft_links__initialize_E");
   E041 : Short_Integer; pragma Import (Ada, E041, "system__traceback__symbolic_E");
   E206 : Short_Integer; pragma Import (Ada, E206, "ada__numerics_E");
   E134 : Short_Integer; pragma Import (Ada, E134, "ada__tags_E");
   E151 : Short_Integer; pragma Import (Ada, E151, "ada__streams_E");
   E107 : Short_Integer; pragma Import (Ada, E107, "interfaces__c__strings_E");
   E205 : Short_Integer; pragma Import (Ada, E205, "system__file_control_block_E");
   E153 : Short_Integer; pragma Import (Ada, E153, "system__finalization_root_E");
   E149 : Short_Integer; pragma Import (Ada, E149, "ada__finalization_E");
   E204 : Short_Integer; pragma Import (Ada, E204, "system__file_io_E");
   E161 : Short_Integer; pragma Import (Ada, E161, "system__storage_pools_E");
   E157 : Short_Integer; pragma Import (Ada, E157, "system__finalization_masters_E");
   E165 : Short_Integer; pragma Import (Ada, E165, "system__storage_pools__subpools_E");
   E122 : Short_Integer; pragma Import (Ada, E122, "system__task_info_E");
   E216 : Short_Integer; pragma Import (Ada, E216, "ada__calendar_E");
   E101 : Short_Integer; pragma Import (Ada, E101, "ada__real_time_E");
   E200 : Short_Integer; pragma Import (Ada, E200, "ada__text_io_E");
   E214 : Short_Integer; pragma Import (Ada, E214, "system__random_seed_E");
   E181 : Short_Integer; pragma Import (Ada, E181, "system__tasking__initialization_E");
   E140 : Short_Integer; pragma Import (Ada, E140, "system__tasking__protected_objects_E");
   E187 : Short_Integer; pragma Import (Ada, E187, "system__tasking__protected_objects__entries_E");
   E185 : Short_Integer; pragma Import (Ada, E185, "system__tasking__queuing_E");
   E177 : Short_Integer; pragma Import (Ada, E177, "system__tasking__stages_E");
   E146 : Short_Integer; pragma Import (Ada, E146, "ada__real_time__timing_events_E");
   E197 : Short_Integer; pragma Import (Ada, E197, "produccionplantap_E");
   E005 : Short_Integer; pragma Import (Ada, E005, "actuadorescritorp_E");
   E208 : Short_Integer; pragma Import (Ada, E208, "sensorlectorp_E");

   Sec_Default_Sized_Stacks : array (1 .. 1) of aliased System.Secondary_Stack.SS_Stack (System.Parameters.Runtime_Default_Sec_Stack_Size);

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
   begin
      declare
         procedure F1;
         pragma Import (Ada, F1, "ada__real_time__timing_events__finalize_body");
      begin
         E146 := E146 - 1;
         F1;
      end;
      declare
         procedure F2;
         pragma Import (Ada, F2, "ada__real_time__timing_events__finalize_spec");
      begin
         F2;
      end;
      E187 := E187 - 1;
      declare
         procedure F3;
         pragma Import (Ada, F3, "system__tasking__protected_objects__entries__finalize_spec");
      begin
         F3;
      end;
      E200 := E200 - 1;
      declare
         procedure F4;
         pragma Import (Ada, F4, "ada__text_io__finalize_spec");
      begin
         F4;
      end;
      E165 := E165 - 1;
      declare
         procedure F5;
         pragma Import (Ada, F5, "system__storage_pools__subpools__finalize_spec");
      begin
         F5;
      end;
      E157 := E157 - 1;
      declare
         procedure F6;
         pragma Import (Ada, F6, "system__finalization_masters__finalize_spec");
      begin
         F6;
      end;
      declare
         procedure F7;
         pragma Import (Ada, F7, "system__file_io__finalize_body");
      begin
         E204 := E204 - 1;
         F7;
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
      pragma Import (Ada, s_stalib_adafinal, "system__standard_library__adafinal");

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
   pragma Favor_Top_Level (No_Param_Proc);

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
           False, False, False, True, True, True, True, False, 
           True, False, True, True, False, False, False, True, 
           True, False, False, True, False, True, False, False, 
           False, True, False, True, False, True, True, True, 
           False, False, True, False, True, True, True, False, 
           True, True, False, True, True, True, True, False, 
           False, False, False, False, False, True, True, True, 
           True, False, True, False),
         Count => (0, 0, 0, 1, 2, 2, 2, 0, 3, 0),
         Unknown => (False, False, False, False, False, False, True, False, True, False));
      Priority_Specific_Dispatching :=
        Local_Priority_Specific_Dispatching'Address;
      Num_Specific_Dispatching := 0;
      Main_CPU := -1;
      Interrupt_States := Local_Interrupt_States'Address;
      Num_Interrupt_States := 0;
      Unreserve_All_Interrupts := 0;
      Detect_Blocking := 0;
      Default_Stack_Size := -1;

      ada_main'Elab_Body;
      Default_Secondary_Stack_Size := System.Parameters.Runtime_Default_Sec_Stack_Size;
      Binder_Sec_Stacks_Count := 1;
      Default_Sized_SS_Pool := Sec_Default_Sized_Stacks'Address;

      Runtime_Initialize (1);

      Finalize_Library_Objects := finalize_library'access;

      Ada.Exceptions'Elab_Spec;
      System.Soft_Links'Elab_Spec;
      System.Exception_Table'Elab_Body;
      E027 := E027 + 1;
      Ada.Containers'Elab_Spec;
      E042 := E042 + 1;
      Ada.Io_Exceptions'Elab_Spec;
      E070 := E070 + 1;
      Ada.Strings'Elab_Spec;
      E054 := E054 + 1;
      Ada.Strings.Maps'Elab_Spec;
      E056 := E056 + 1;
      Ada.Strings.Maps.Constants'Elab_Spec;
      E060 := E060 + 1;
      Interfaces.C'Elab_Spec;
      E080 := E080 + 1;
      System.Exceptions'Elab_Spec;
      E029 := E029 + 1;
      System.Object_Reader'Elab_Spec;
      E082 := E082 + 1;
      System.Dwarf_Lines'Elab_Spec;
      E049 := E049 + 1;
      System.Os_Lib'Elab_Body;
      E074 := E074 + 1;
      System.Soft_Links.Initialize'Elab_Body;
      E023 := E023 + 1;
      E015 := E015 + 1;
      System.Traceback.Symbolic'Elab_Body;
      E041 := E041 + 1;
      E010 := E010 + 1;
      Ada.Numerics'Elab_Spec;
      E206 := E206 + 1;
      Ada.Tags'Elab_Spec;
      Ada.Tags'Elab_Body;
      E134 := E134 + 1;
      Ada.Streams'Elab_Spec;
      E151 := E151 + 1;
      Interfaces.C.Strings'Elab_Spec;
      E107 := E107 + 1;
      System.File_Control_Block'Elab_Spec;
      E205 := E205 + 1;
      System.Finalization_Root'Elab_Spec;
      E153 := E153 + 1;
      Ada.Finalization'Elab_Spec;
      E149 := E149 + 1;
      System.File_Io'Elab_Body;
      E204 := E204 + 1;
      System.Storage_Pools'Elab_Spec;
      E161 := E161 + 1;
      System.Finalization_Masters'Elab_Spec;
      System.Finalization_Masters'Elab_Body;
      E157 := E157 + 1;
      System.Storage_Pools.Subpools'Elab_Spec;
      E165 := E165 + 1;
      System.Task_Info'Elab_Spec;
      E122 := E122 + 1;
      Ada.Calendar'Elab_Spec;
      Ada.Calendar'Elab_Body;
      E216 := E216 + 1;
      Ada.Real_Time'Elab_Spec;
      Ada.Real_Time'Elab_Body;
      E101 := E101 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E200 := E200 + 1;
      System.Random_Seed'Elab_Body;
      E214 := E214 + 1;
      System.Tasking.Initialization'Elab_Body;
      E181 := E181 + 1;
      System.Tasking.Protected_Objects'Elab_Body;
      E140 := E140 + 1;
      System.Tasking.Protected_Objects.Entries'Elab_Spec;
      E187 := E187 + 1;
      System.Tasking.Queuing'Elab_Body;
      E185 := E185 + 1;
      System.Tasking.Stages'Elab_Body;
      E177 := E177 + 1;
      Ada.Real_Time.Timing_Events'Elab_Spec;
      Ada.Real_Time.Timing_Events'Elab_Body;
      E146 := E146 + 1;
      E197 := E197 + 1;
      E005 := E005 + 1;
      E208 := E208 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_main");

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
      if gnat_argc = 0 then
         gnat_argc := argc;
         gnat_argv := argv;
      end if;
      gnat_envp := envp;

      Initialize (SEH'Address);
      adainit;
      Ada_Main_Program;
      adafinal;
      Finalize;
      return (gnat_exit_status);
   end;

--  BEGIN Object file/option list
   --   C:\Users\esthe\Documents\GitHub\PA_ADA\obj\ProduccionPlantaP.o
   --   C:\Users\esthe\Documents\GitHub\PA_ADA\obj\ActuadorEscritorP.o
   --   C:\Users\esthe\Documents\GitHub\PA_ADA\obj\SensorLectorP.o
   --   C:\Users\esthe\Documents\GitHub\PA_ADA\obj\main.o
   --   -LC:\Users\esthe\Documents\GitHub\PA_ADA\obj\
   --   -LC:\Users\esthe\Documents\GitHub\PA_ADA\obj\
   --   -LC:/gnat/2020/lib/gcc/x86_64-pc-mingw32/9.3.1/adalib/
   --   -static
   --   -lgnarl
   --   -lgnat
   --   -Xlinker
   --   --stack=0x200000,0x1000
   --   -mthreads
   --   -Wl,--stack=0x2000000
--  END Object file/option list   

end ada_main;
