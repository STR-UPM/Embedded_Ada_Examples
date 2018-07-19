pragma Warnings (Off);
pragma Ada_95;
with System;
package ada_main is

   gnat_argc : Integer;
   gnat_argv : System.Address;
   gnat_envp : System.Address;

   pragma Import (C, gnat_argc);
   pragma Import (C, gnat_argv);
   pragma Import (C, gnat_envp);

   gnat_exit_status : Integer;
   pragma Import (C, gnat_exit_status);

   GNAT_Version : constant String :=
                    "GNAT Version: GPL 2017 (20170515-63)" & ASCII.NUL;
   pragma Export (C, GNAT_Version, "__gnat_version");

   Ada_Main_Program_Name : constant String := "_ada_host" & ASCII.NUL;
   pragma Export (C, Ada_Main_Program_Name, "__gnat_ada_main_program_name");

   procedure adainit;
   pragma Export (C, adainit, "adainit");

   procedure adafinal;
   pragma Export (C, adafinal, "adafinal");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer;
   pragma Export (C, main, "main");

   type Version_32 is mod 2 ** 32;
   u00001 : constant Version_32 := 16#2055509d#;
   pragma Export (C, u00001, "hostB");
   u00002 : constant Version_32 := 16#b6df930e#;
   pragma Export (C, u00002, "system__standard_libraryB");
   u00003 : constant Version_32 := 16#5bd3bf5d#;
   pragma Export (C, u00003, "system__standard_libraryS");
   u00004 : constant Version_32 := 16#e61132bb#;
   pragma Export (C, u00004, "tm_receiverB");
   u00005 : constant Version_32 := 16#a165f3ee#;
   pragma Export (C, u00005, "tm_receiverS");
   u00006 : constant Version_32 := 16#76789da1#;
   pragma Export (C, u00006, "adaS");
   u00007 : constant Version_32 := 16#0d7f1a43#;
   pragma Export (C, u00007, "ada__calendarB");
   u00008 : constant Version_32 := 16#5b279c75#;
   pragma Export (C, u00008, "ada__calendarS");
   u00009 : constant Version_32 := 16#a7c91b43#;
   pragma Export (C, u00009, "ada__exceptionsB");
   u00010 : constant Version_32 := 16#4b8b8db1#;
   pragma Export (C, u00010, "ada__exceptionsS");
   u00011 : constant Version_32 := 16#e947e6a9#;
   pragma Export (C, u00011, "ada__exceptions__last_chance_handlerB");
   u00012 : constant Version_32 := 16#41e5552e#;
   pragma Export (C, u00012, "ada__exceptions__last_chance_handlerS");
   u00013 : constant Version_32 := 16#6326c08a#;
   pragma Export (C, u00013, "systemS");
   u00014 : constant Version_32 := 16#4e7785b8#;
   pragma Export (C, u00014, "system__soft_linksB");
   u00015 : constant Version_32 := 16#fda218df#;
   pragma Export (C, u00015, "system__soft_linksS");
   u00016 : constant Version_32 := 16#b01dad17#;
   pragma Export (C, u00016, "system__parametersB");
   u00017 : constant Version_32 := 16#1d0ccdf5#;
   pragma Export (C, u00017, "system__parametersS");
   u00018 : constant Version_32 := 16#30ad09e5#;
   pragma Export (C, u00018, "system__secondary_stackB");
   u00019 : constant Version_32 := 16#d9b43ff0#;
   pragma Export (C, u00019, "system__secondary_stackS");
   u00020 : constant Version_32 := 16#f103f468#;
   pragma Export (C, u00020, "system__storage_elementsB");
   u00021 : constant Version_32 := 16#4ee58a8e#;
   pragma Export (C, u00021, "system__storage_elementsS");
   u00022 : constant Version_32 := 16#41837d1e#;
   pragma Export (C, u00022, "system__stack_checkingB");
   u00023 : constant Version_32 := 16#ed99ab62#;
   pragma Export (C, u00023, "system__stack_checkingS");
   u00024 : constant Version_32 := 16#87a448ff#;
   pragma Export (C, u00024, "system__exception_tableB");
   u00025 : constant Version_32 := 16#3e88a9c8#;
   pragma Export (C, u00025, "system__exception_tableS");
   u00026 : constant Version_32 := 16#ce4af020#;
   pragma Export (C, u00026, "system__exceptionsB");
   u00027 : constant Version_32 := 16#0b45ad7c#;
   pragma Export (C, u00027, "system__exceptionsS");
   u00028 : constant Version_32 := 16#80916427#;
   pragma Export (C, u00028, "system__exceptions__machineB");
   u00029 : constant Version_32 := 16#047ef179#;
   pragma Export (C, u00029, "system__exceptions__machineS");
   u00030 : constant Version_32 := 16#aa0563fc#;
   pragma Export (C, u00030, "system__exceptions_debugB");
   u00031 : constant Version_32 := 16#1dac394e#;
   pragma Export (C, u00031, "system__exceptions_debugS");
   u00032 : constant Version_32 := 16#6c2f8802#;
   pragma Export (C, u00032, "system__img_intB");
   u00033 : constant Version_32 := 16#61fd2048#;
   pragma Export (C, u00033, "system__img_intS");
   u00034 : constant Version_32 := 16#39df8c17#;
   pragma Export (C, u00034, "system__tracebackB");
   u00035 : constant Version_32 := 16#3d041e4e#;
   pragma Export (C, u00035, "system__tracebackS");
   u00036 : constant Version_32 := 16#9ed49525#;
   pragma Export (C, u00036, "system__traceback_entriesB");
   u00037 : constant Version_32 := 16#637d36fa#;
   pragma Export (C, u00037, "system__traceback_entriesS");
   u00038 : constant Version_32 := 16#e635f7f0#;
   pragma Export (C, u00038, "system__traceback__symbolicB");
   u00039 : constant Version_32 := 16#9df1ae6d#;
   pragma Export (C, u00039, "system__traceback__symbolicS");
   u00040 : constant Version_32 := 16#179d7d28#;
   pragma Export (C, u00040, "ada__containersS");
   u00041 : constant Version_32 := 16#701f9d88#;
   pragma Export (C, u00041, "ada__exceptions__tracebackB");
   u00042 : constant Version_32 := 16#20245e75#;
   pragma Export (C, u00042, "ada__exceptions__tracebackS");
   u00043 : constant Version_32 := 16#5ab55268#;
   pragma Export (C, u00043, "interfacesS");
   u00044 : constant Version_32 := 16#769e25e6#;
   pragma Export (C, u00044, "interfaces__cB");
   u00045 : constant Version_32 := 16#70be4e8c#;
   pragma Export (C, u00045, "interfaces__cS");
   u00046 : constant Version_32 := 16#97d13ec4#;
   pragma Export (C, u00046, "system__address_operationsB");
   u00047 : constant Version_32 := 16#702a7eb9#;
   pragma Export (C, u00047, "system__address_operationsS");
   u00048 : constant Version_32 := 16#e865e681#;
   pragma Export (C, u00048, "system__bounded_stringsB");
   u00049 : constant Version_32 := 16#14dbe193#;
   pragma Export (C, u00049, "system__bounded_stringsS");
   u00050 : constant Version_32 := 16#13b71684#;
   pragma Export (C, u00050, "system__crtlS");
   u00051 : constant Version_32 := 16#596696a5#;
   pragma Export (C, u00051, "system__dwarf_linesB");
   u00052 : constant Version_32 := 16#e03b663a#;
   pragma Export (C, u00052, "system__dwarf_linesS");
   u00053 : constant Version_32 := 16#5b4659fa#;
   pragma Export (C, u00053, "ada__charactersS");
   u00054 : constant Version_32 := 16#8f637df8#;
   pragma Export (C, u00054, "ada__characters__handlingB");
   u00055 : constant Version_32 := 16#3b3f6154#;
   pragma Export (C, u00055, "ada__characters__handlingS");
   u00056 : constant Version_32 := 16#4b7bb96a#;
   pragma Export (C, u00056, "ada__characters__latin_1S");
   u00057 : constant Version_32 := 16#e6d4fa36#;
   pragma Export (C, u00057, "ada__stringsS");
   u00058 : constant Version_32 := 16#e2ea8656#;
   pragma Export (C, u00058, "ada__strings__mapsB");
   u00059 : constant Version_32 := 16#1e526bec#;
   pragma Export (C, u00059, "ada__strings__mapsS");
   u00060 : constant Version_32 := 16#cc4ff587#;
   pragma Export (C, u00060, "system__bit_opsB");
   u00061 : constant Version_32 := 16#0765e3a3#;
   pragma Export (C, u00061, "system__bit_opsS");
   u00062 : constant Version_32 := 16#57a0bc09#;
   pragma Export (C, u00062, "system__unsigned_typesS");
   u00063 : constant Version_32 := 16#92f05f13#;
   pragma Export (C, u00063, "ada__strings__maps__constantsS");
   u00064 : constant Version_32 := 16#9f00b3d3#;
   pragma Export (C, u00064, "system__address_imageB");
   u00065 : constant Version_32 := 16#c2ca5db0#;
   pragma Export (C, u00065, "system__address_imageS");
   u00066 : constant Version_32 := 16#ec78c2bf#;
   pragma Export (C, u00066, "system__img_unsB");
   u00067 : constant Version_32 := 16#c85480fe#;
   pragma Export (C, u00067, "system__img_unsS");
   u00068 : constant Version_32 := 16#d7aac20c#;
   pragma Export (C, u00068, "system__ioB");
   u00069 : constant Version_32 := 16#fd6437c5#;
   pragma Export (C, u00069, "system__ioS");
   u00070 : constant Version_32 := 16#d6ea8de4#;
   pragma Export (C, u00070, "system__mmapB");
   u00071 : constant Version_32 := 16#59577fed#;
   pragma Export (C, u00071, "system__mmapS");
   u00072 : constant Version_32 := 16#92d882c5#;
   pragma Export (C, u00072, "ada__io_exceptionsS");
   u00073 : constant Version_32 := 16#81cd5347#;
   pragma Export (C, u00073, "system__mmap__os_interfaceB");
   u00074 : constant Version_32 := 16#2af642f4#;
   pragma Export (C, u00074, "system__mmap__os_interfaceS");
   u00075 : constant Version_32 := 16#2b4924dd#;
   pragma Export (C, u00075, "system__mmap__unixS");
   u00076 : constant Version_32 := 16#05e56fce#;
   pragma Export (C, u00076, "system__os_libB");
   u00077 : constant Version_32 := 16#ed466fde#;
   pragma Export (C, u00077, "system__os_libS");
   u00078 : constant Version_32 := 16#d1060688#;
   pragma Export (C, u00078, "system__case_utilB");
   u00079 : constant Version_32 := 16#472fa95d#;
   pragma Export (C, u00079, "system__case_utilS");
   u00080 : constant Version_32 := 16#2a8e89ad#;
   pragma Export (C, u00080, "system__stringsB");
   u00081 : constant Version_32 := 16#1d99d1ec#;
   pragma Export (C, u00081, "system__stringsS");
   u00082 : constant Version_32 := 16#d0bc914c#;
   pragma Export (C, u00082, "system__object_readerB");
   u00083 : constant Version_32 := 16#2e1565f0#;
   pragma Export (C, u00083, "system__object_readerS");
   u00084 : constant Version_32 := 16#1a74a354#;
   pragma Export (C, u00084, "system__val_lliB");
   u00085 : constant Version_32 := 16#f902262a#;
   pragma Export (C, u00085, "system__val_lliS");
   u00086 : constant Version_32 := 16#afdbf393#;
   pragma Export (C, u00086, "system__val_lluB");
   u00087 : constant Version_32 := 16#2d52eb7b#;
   pragma Export (C, u00087, "system__val_lluS");
   u00088 : constant Version_32 := 16#27b600b2#;
   pragma Export (C, u00088, "system__val_utilB");
   u00089 : constant Version_32 := 16#cf867674#;
   pragma Export (C, u00089, "system__val_utilS");
   u00090 : constant Version_32 := 16#5bbc3f2f#;
   pragma Export (C, u00090, "system__exception_tracesB");
   u00091 : constant Version_32 := 16#47f9e010#;
   pragma Export (C, u00091, "system__exception_tracesS");
   u00092 : constant Version_32 := 16#8c33a517#;
   pragma Export (C, u00092, "system__wch_conB");
   u00093 : constant Version_32 := 16#785be258#;
   pragma Export (C, u00093, "system__wch_conS");
   u00094 : constant Version_32 := 16#9721e840#;
   pragma Export (C, u00094, "system__wch_stwB");
   u00095 : constant Version_32 := 16#554ace59#;
   pragma Export (C, u00095, "system__wch_stwS");
   u00096 : constant Version_32 := 16#a831679c#;
   pragma Export (C, u00096, "system__wch_cnvB");
   u00097 : constant Version_32 := 16#77ec58ab#;
   pragma Export (C, u00097, "system__wch_cnvS");
   u00098 : constant Version_32 := 16#ece6fdb6#;
   pragma Export (C, u00098, "system__wch_jisB");
   u00099 : constant Version_32 := 16#f79c418a#;
   pragma Export (C, u00099, "system__wch_jisS");
   u00100 : constant Version_32 := 16#d083f760#;
   pragma Export (C, u00100, "system__os_primitivesB");
   u00101 : constant Version_32 := 16#e9a9d1fc#;
   pragma Export (C, u00101, "system__os_primitivesS");
   u00102 : constant Version_32 := 16#87cd2ab9#;
   pragma Export (C, u00102, "ada__calendar__delaysB");
   u00103 : constant Version_32 := 16#b27fb9e9#;
   pragma Export (C, u00103, "ada__calendar__delaysS");
   u00104 : constant Version_32 := 16#ee80728a#;
   pragma Export (C, u00104, "system__tracesB");
   u00105 : constant Version_32 := 16#913ba820#;
   pragma Export (C, u00105, "system__tracesS");
   u00106 : constant Version_32 := 16#10558b11#;
   pragma Export (C, u00106, "ada__streamsB");
   u00107 : constant Version_32 := 16#67e31212#;
   pragma Export (C, u00107, "ada__streamsS");
   u00108 : constant Version_32 := 16#d85792d6#;
   pragma Export (C, u00108, "ada__tagsB");
   u00109 : constant Version_32 := 16#8813468c#;
   pragma Export (C, u00109, "ada__tagsS");
   u00110 : constant Version_32 := 16#c3335bfd#;
   pragma Export (C, u00110, "system__htableB");
   u00111 : constant Version_32 := 16#e7e47360#;
   pragma Export (C, u00111, "system__htableS");
   u00112 : constant Version_32 := 16#089f5cd0#;
   pragma Export (C, u00112, "system__string_hashB");
   u00113 : constant Version_32 := 16#45ba181e#;
   pragma Export (C, u00113, "system__string_hashS");
   u00114 : constant Version_32 := 16#fd2ad2f1#;
   pragma Export (C, u00114, "gnatS");
   u00115 : constant Version_32 := 16#5ba56db0#;
   pragma Export (C, u00115, "gnat__calendarB");
   u00116 : constant Version_32 := 16#69bc3631#;
   pragma Export (C, u00116, "gnat__calendarS");
   u00117 : constant Version_32 := 16#8439775b#;
   pragma Export (C, u00117, "interfaces__c__extensionsS");
   u00118 : constant Version_32 := 16#8f218b8f#;
   pragma Export (C, u00118, "ada__calendar__formattingB");
   u00119 : constant Version_32 := 16#67ade573#;
   pragma Export (C, u00119, "ada__calendar__formattingS");
   u00120 : constant Version_32 := 16#e3cca715#;
   pragma Export (C, u00120, "ada__calendar__time_zonesB");
   u00121 : constant Version_32 := 16#6dc27f8f#;
   pragma Export (C, u00121, "ada__calendar__time_zonesS");
   u00122 : constant Version_32 := 16#d763507a#;
   pragma Export (C, u00122, "system__val_intB");
   u00123 : constant Version_32 := 16#2b83eab5#;
   pragma Export (C, u00123, "system__val_intS");
   u00124 : constant Version_32 := 16#1d9142a4#;
   pragma Export (C, u00124, "system__val_unsB");
   u00125 : constant Version_32 := 16#47085132#;
   pragma Export (C, u00125, "system__val_unsS");
   u00126 : constant Version_32 := 16#faa9a7b2#;
   pragma Export (C, u00126, "system__val_realB");
   u00127 : constant Version_32 := 16#9d0fb79b#;
   pragma Export (C, u00127, "system__val_realS");
   u00128 : constant Version_32 := 16#b2a569d2#;
   pragma Export (C, u00128, "system__exn_llfB");
   u00129 : constant Version_32 := 16#df587b56#;
   pragma Export (C, u00129, "system__exn_llfS");
   u00130 : constant Version_32 := 16#1b28662b#;
   pragma Export (C, u00130, "system__float_controlB");
   u00131 : constant Version_32 := 16#83da83b6#;
   pragma Export (C, u00131, "system__float_controlS");
   u00132 : constant Version_32 := 16#3356a6fd#;
   pragma Export (C, u00132, "system__powten_tableS");
   u00133 : constant Version_32 := 16#bc5e3583#;
   pragma Export (C, u00133, "gnat__calendar__time_ioB");
   u00134 : constant Version_32 := 16#727c9c73#;
   pragma Export (C, u00134, "gnat__calendar__time_ioS");
   u00135 : constant Version_32 := 16#3791e504#;
   pragma Export (C, u00135, "ada__strings__unboundedB");
   u00136 : constant Version_32 := 16#9fdb1809#;
   pragma Export (C, u00136, "ada__strings__unboundedS");
   u00137 : constant Version_32 := 16#45c9251c#;
   pragma Export (C, u00137, "ada__strings__searchB");
   u00138 : constant Version_32 := 16#c1ab8667#;
   pragma Export (C, u00138, "ada__strings__searchS");
   u00139 : constant Version_32 := 16#933d1555#;
   pragma Export (C, u00139, "system__compare_array_unsigned_8B");
   u00140 : constant Version_32 := 16#ca25b107#;
   pragma Export (C, u00140, "system__compare_array_unsigned_8S");
   u00141 : constant Version_32 := 16#a2250034#;
   pragma Export (C, u00141, "system__storage_pools__subpoolsB");
   u00142 : constant Version_32 := 16#cc5a1856#;
   pragma Export (C, u00142, "system__storage_pools__subpoolsS");
   u00143 : constant Version_32 := 16#6abe5dbe#;
   pragma Export (C, u00143, "system__finalization_mastersB");
   u00144 : constant Version_32 := 16#38daf940#;
   pragma Export (C, u00144, "system__finalization_mastersS");
   u00145 : constant Version_32 := 16#7268f812#;
   pragma Export (C, u00145, "system__img_boolB");
   u00146 : constant Version_32 := 16#96ffb161#;
   pragma Export (C, u00146, "system__img_boolS");
   u00147 : constant Version_32 := 16#86c56e5a#;
   pragma Export (C, u00147, "ada__finalizationS");
   u00148 : constant Version_32 := 16#95817ed8#;
   pragma Export (C, u00148, "system__finalization_rootB");
   u00149 : constant Version_32 := 16#2cd4b31a#;
   pragma Export (C, u00149, "system__finalization_rootS");
   u00150 : constant Version_32 := 16#6d4d969a#;
   pragma Export (C, u00150, "system__storage_poolsB");
   u00151 : constant Version_32 := 16#40cb5e27#;
   pragma Export (C, u00151, "system__storage_poolsS");
   u00152 : constant Version_32 := 16#9aad1ff1#;
   pragma Export (C, u00152, "system__storage_pools__subpools__finalizationB");
   u00153 : constant Version_32 := 16#fe2f4b3a#;
   pragma Export (C, u00153, "system__storage_pools__subpools__finalizationS");
   u00154 : constant Version_32 := 16#020a3f4d#;
   pragma Export (C, u00154, "system__atomic_countersB");
   u00155 : constant Version_32 := 16#d77aed07#;
   pragma Export (C, u00155, "system__atomic_countersS");
   u00156 : constant Version_32 := 16#3c420900#;
   pragma Export (C, u00156, "system__stream_attributesB");
   u00157 : constant Version_32 := 16#8bc30a4e#;
   pragma Export (C, u00157, "system__stream_attributesS");
   u00158 : constant Version_32 := 16#1d1c6062#;
   pragma Export (C, u00158, "ada__text_ioB");
   u00159 : constant Version_32 := 16#c4f75f1e#;
   pragma Export (C, u00159, "ada__text_ioS");
   u00160 : constant Version_32 := 16#4c01b69c#;
   pragma Export (C, u00160, "interfaces__c_streamsB");
   u00161 : constant Version_32 := 16#b1330297#;
   pragma Export (C, u00161, "interfaces__c_streamsS");
   u00162 : constant Version_32 := 16#6f0d52aa#;
   pragma Export (C, u00162, "system__file_ioB");
   u00163 : constant Version_32 := 16#c45721ef#;
   pragma Export (C, u00163, "system__file_ioS");
   u00164 : constant Version_32 := 16#9eb95a22#;
   pragma Export (C, u00164, "system__file_control_blockS");
   u00165 : constant Version_32 := 16#d37ed4a2#;
   pragma Export (C, u00165, "gnat__case_utilB");
   u00166 : constant Version_32 := 16#d6115050#;
   pragma Export (C, u00166, "gnat__case_utilS");
   u00167 : constant Version_32 := 16#18e0e51c#;
   pragma Export (C, u00167, "system__img_enum_newB");
   u00168 : constant Version_32 := 16#026ac64a#;
   pragma Export (C, u00168, "system__img_enum_newS");
   u00169 : constant Version_32 := 16#9dca6636#;
   pragma Export (C, u00169, "system__img_lliB");
   u00170 : constant Version_32 := 16#7269955b#;
   pragma Export (C, u00170, "system__img_lliS");
   u00171 : constant Version_32 := 16#3e932977#;
   pragma Export (C, u00171, "system__img_lluB");
   u00172 : constant Version_32 := 16#1e69bcca#;
   pragma Export (C, u00172, "system__img_lluS");
   u00173 : constant Version_32 := 16#b48102f5#;
   pragma Export (C, u00173, "gnat__ioB");
   u00174 : constant Version_32 := 16#6227e843#;
   pragma Export (C, u00174, "gnat__ioS");
   u00175 : constant Version_32 := 16#3b82dcab#;
   pragma Export (C, u00175, "gnat__serial_communicationsB");
   u00176 : constant Version_32 := 16#90a90beb#;
   pragma Export (C, u00176, "gnat__serial_communicationsS");
   u00177 : constant Version_32 := 16#923eb7bb#;
   pragma Export (C, u00177, "gnat__os_libS");
   u00178 : constant Version_32 := 16#5de653db#;
   pragma Export (C, u00178, "system__communicationB");
   u00179 : constant Version_32 := 16#7a469558#;
   pragma Export (C, u00179, "system__communicationS");
   u00180 : constant Version_32 := 16#6b5c2cbb#;
   pragma Export (C, u00180, "system__os_constantsS");
   u00181 : constant Version_32 := 16#5a895de2#;
   pragma Export (C, u00181, "system__pool_globalB");
   u00182 : constant Version_32 := 16#7141203e#;
   pragma Export (C, u00182, "system__pool_globalS");
   u00183 : constant Version_32 := 16#a6359005#;
   pragma Export (C, u00183, "system__memoryB");
   u00184 : constant Version_32 := 16#3a5ba6be#;
   pragma Export (C, u00184, "system__memoryS");
   u00185 : constant Version_32 := 16#fd83e873#;
   pragma Export (C, u00185, "system__concat_2B");
   u00186 : constant Version_32 := 16#6186175a#;
   pragma Export (C, u00186, "system__concat_2S");
   u00187 : constant Version_32 := 16#2b70b149#;
   pragma Export (C, u00187, "system__concat_3B");
   u00188 : constant Version_32 := 16#68569c2f#;
   pragma Export (C, u00188, "system__concat_3S");
   u00189 : constant Version_32 := 16#5980ac71#;
   pragma Export (C, u00189, "system__strings__stream_opsB");
   u00190 : constant Version_32 := 16#55d4bd57#;
   pragma Export (C, u00190, "system__strings__stream_opsS");
   u00191 : constant Version_32 := 16#46c75fea#;
   pragma Export (C, u00191, "ada__streams__stream_ioB");
   u00192 : constant Version_32 := 16#31fc8e02#;
   pragma Export (C, u00192, "ada__streams__stream_ioS");
   u00193 : constant Version_32 := 16#033c3fd8#;
   pragma Export (C, u00193, "system__tasking__stagesB");
   u00194 : constant Version_32 := 16#a2ee1060#;
   pragma Export (C, u00194, "system__tasking__stagesS");
   u00195 : constant Version_32 := 16#71c5de81#;
   pragma Export (C, u00195, "system__interrupt_managementB");
   u00196 : constant Version_32 := 16#96cc0f0d#;
   pragma Export (C, u00196, "system__interrupt_managementS");
   u00197 : constant Version_32 := 16#715dc01d#;
   pragma Export (C, u00197, "system__task_primitivesS");
   u00198 : constant Version_32 := 16#95a88f5d#;
   pragma Export (C, u00198, "system__os_interfaceB");
   u00199 : constant Version_32 := 16#93bfc0e7#;
   pragma Export (C, u00199, "system__os_interfaceS");
   u00200 : constant Version_32 := 16#18ddbbc0#;
   pragma Export (C, u00200, "system__linuxS");
   u00201 : constant Version_32 := 16#100eaf58#;
   pragma Export (C, u00201, "system__restrictionsB");
   u00202 : constant Version_32 := 16#9045e4e4#;
   pragma Export (C, u00202, "system__restrictionsS");
   u00203 : constant Version_32 := 16#118e865d#;
   pragma Export (C, u00203, "system__stack_usageB");
   u00204 : constant Version_32 := 16#3a3ac346#;
   pragma Export (C, u00204, "system__stack_usageS");
   u00205 : constant Version_32 := 16#0a8dca5f#;
   pragma Export (C, u00205, "system__task_primitives__operationsB");
   u00206 : constant Version_32 := 16#7455f972#;
   pragma Export (C, u00206, "system__task_primitives__operationsS");
   u00207 : constant Version_32 := 16#f65595cf#;
   pragma Export (C, u00207, "system__multiprocessorsB");
   u00208 : constant Version_32 := 16#5b8a5ff9#;
   pragma Export (C, u00208, "system__multiprocessorsS");
   u00209 : constant Version_32 := 16#375a3ef7#;
   pragma Export (C, u00209, "system__task_infoB");
   u00210 : constant Version_32 := 16#ae6882c2#;
   pragma Export (C, u00210, "system__task_infoS");
   u00211 : constant Version_32 := 16#888154ba#;
   pragma Export (C, u00211, "system__taskingB");
   u00212 : constant Version_32 := 16#f289b05e#;
   pragma Export (C, u00212, "system__taskingS");
   u00213 : constant Version_32 := 16#4fb10596#;
   pragma Export (C, u00213, "system__tasking__debugB");
   u00214 : constant Version_32 := 16#39d8a5ec#;
   pragma Export (C, u00214, "system__tasking__debugS");
   u00215 : constant Version_32 := 16#67e3355c#;
   pragma Export (C, u00215, "system__tasking__initializationB");
   u00216 : constant Version_32 := 16#efd25374#;
   pragma Export (C, u00216, "system__tasking__initializationS");
   u00217 : constant Version_32 := 16#312b97cd#;
   pragma Export (C, u00217, "system__soft_links__taskingB");
   u00218 : constant Version_32 := 16#5ae92880#;
   pragma Export (C, u00218, "system__soft_links__taskingS");
   u00219 : constant Version_32 := 16#17d21067#;
   pragma Export (C, u00219, "ada__exceptions__is_null_occurrenceB");
   u00220 : constant Version_32 := 16#e1d7566f#;
   pragma Export (C, u00220, "ada__exceptions__is_null_occurrenceS");
   u00221 : constant Version_32 := 16#a4a31ee6#;
   pragma Export (C, u00221, "system__tasking__task_attributesB");
   u00222 : constant Version_32 := 16#6bc95a13#;
   pragma Export (C, u00222, "system__tasking__task_attributesS");
   u00223 : constant Version_32 := 16#e8f87c58#;
   pragma Export (C, u00223, "system__tasking__queuingB");
   u00224 : constant Version_32 := 16#d1ba2fcb#;
   pragma Export (C, u00224, "system__tasking__queuingS");
   u00225 : constant Version_32 := 16#c8081f14#;
   pragma Export (C, u00225, "system__tasking__protected_objectsB");
   u00226 : constant Version_32 := 16#a9001c61#;
   pragma Export (C, u00226, "system__tasking__protected_objectsS");
   u00227 : constant Version_32 := 16#547d8eae#;
   pragma Export (C, u00227, "system__tasking__protected_objects__entriesB");
   u00228 : constant Version_32 := 16#427cf21f#;
   pragma Export (C, u00228, "system__tasking__protected_objects__entriesS");
   u00229 : constant Version_32 := 16#d56c24cb#;
   pragma Export (C, u00229, "system__tasking__rendezvousB");
   u00230 : constant Version_32 := 16#ea18a31e#;
   pragma Export (C, u00230, "system__tasking__rendezvousS");
   u00231 : constant Version_32 := 16#2b414a51#;
   pragma Export (C, u00231, "system__tasking__entry_callsB");
   u00232 : constant Version_32 := 16#df420580#;
   pragma Export (C, u00232, "system__tasking__entry_callsS");
   u00233 : constant Version_32 := 16#5e1f99be#;
   pragma Export (C, u00233, "system__tasking__protected_objects__operationsB");
   u00234 : constant Version_32 := 16#ba36ad85#;
   pragma Export (C, u00234, "system__tasking__protected_objects__operationsS");
   u00235 : constant Version_32 := 16#bad2cea3#;
   pragma Export (C, u00235, "system__tasking__utilitiesB");
   u00236 : constant Version_32 := 16#8cb46e11#;
   pragma Export (C, u00236, "system__tasking__utilitiesS");
   u00237 : constant Version_32 := 16#bd6fc52e#;
   pragma Export (C, u00237, "system__traces__taskingB");
   u00238 : constant Version_32 := 16#09f07b39#;
   pragma Export (C, u00238, "system__traces__taskingS");
   u00239 : constant Version_32 := 16#402b6a67#;
   pragma Export (C, u00239, "ada__real_timeB");
   u00240 : constant Version_32 := 16#c3d451b0#;
   pragma Export (C, u00240, "ada__real_timeS");

   --  BEGIN ELABORATION ORDER
   --  ada%s
   --  ada.characters%s
   --  ada.characters.latin_1%s
   --  gnat%s
   --  gnat.io%s
   --  gnat.io%b
   --  interfaces%s
   --  system%s
   --  system.address_operations%s
   --  system.address_operations%b
   --  system.atomic_counters%s
   --  system.atomic_counters%b
   --  system.case_util%s
   --  system.case_util%b
   --  gnat.case_util%s
   --  gnat.case_util%b
   --  system.exn_llf%s
   --  system.exn_llf%b
   --  system.float_control%s
   --  system.float_control%b
   --  system.img_bool%s
   --  system.img_bool%b
   --  system.img_enum_new%s
   --  system.img_enum_new%b
   --  system.img_int%s
   --  system.img_int%b
   --  system.img_lli%s
   --  system.img_lli%b
   --  system.io%s
   --  system.io%b
   --  system.os_primitives%s
   --  system.os_primitives%b
   --  system.parameters%s
   --  system.parameters%b
   --  system.crtl%s
   --  interfaces.c_streams%s
   --  interfaces.c_streams%b
   --  system.powten_table%s
   --  system.restrictions%s
   --  system.restrictions%b
   --  system.storage_elements%s
   --  system.storage_elements%b
   --  system.stack_checking%s
   --  system.stack_checking%b
   --  system.stack_usage%s
   --  system.stack_usage%b
   --  system.string_hash%s
   --  system.string_hash%b
   --  system.htable%s
   --  system.htable%b
   --  system.strings%s
   --  system.strings%b
   --  system.traceback_entries%s
   --  system.traceback_entries%b
   --  system.traces%s
   --  system.traces%b
   --  system.unsigned_types%s
   --  system.img_llu%s
   --  system.img_llu%b
   --  system.img_uns%s
   --  system.img_uns%b
   --  system.wch_con%s
   --  system.wch_con%b
   --  system.wch_jis%s
   --  system.wch_jis%b
   --  system.wch_cnv%s
   --  system.wch_cnv%b
   --  system.compare_array_unsigned_8%s
   --  system.compare_array_unsigned_8%b
   --  system.concat_2%s
   --  system.concat_2%b
   --  system.concat_3%s
   --  system.concat_3%b
   --  system.traceback%s
   --  system.traceback%b
   --  system.val_util%s
   --  system.standard_library%s
   --  system.exception_traces%s
   --  ada.exceptions%s
   --  system.wch_stw%s
   --  system.val_util%b
   --  system.val_llu%s
   --  system.val_lli%s
   --  system.os_lib%s
   --  system.bit_ops%s
   --  ada.characters.handling%s
   --  ada.exceptions.traceback%s
   --  system.soft_links%s
   --  system.exception_table%s
   --  system.exception_table%b
   --  ada.io_exceptions%s
   --  ada.strings%s
   --  ada.containers%s
   --  system.exceptions%s
   --  system.exceptions%b
   --  system.secondary_stack%s
   --  system.address_image%s
   --  system.bounded_strings%s
   --  system.soft_links%b
   --  ada.exceptions.last_chance_handler%s
   --  system.exceptions_debug%s
   --  system.exceptions_debug%b
   --  system.exception_traces%b
   --  system.memory%s
   --  system.memory%b
   --  system.wch_stw%b
   --  system.val_llu%b
   --  system.val_lli%b
   --  system.os_lib%b
   --  system.bit_ops%b
   --  ada.strings.maps%s
   --  ada.strings.maps.constants%s
   --  ada.characters.handling%b
   --  interfaces.c%s
   --  ada.exceptions.traceback%b
   --  system.exceptions.machine%s
   --  system.exceptions.machine%b
   --  system.secondary_stack%b
   --  system.address_image%b
   --  system.bounded_strings%b
   --  ada.exceptions.last_chance_handler%b
   --  system.standard_library%b
   --  system.mmap%s
   --  ada.strings.maps%b
   --  interfaces.c%b
   --  system.object_reader%s
   --  system.dwarf_lines%s
   --  system.dwarf_lines%b
   --  system.mmap.unix%s
   --  system.mmap.os_interface%s
   --  system.mmap%b
   --  system.traceback.symbolic%s
   --  system.traceback.symbolic%b
   --  ada.exceptions%b
   --  system.object_reader%b
   --  system.mmap.os_interface%b
   --  ada.exceptions.is_null_occurrence%s
   --  ada.exceptions.is_null_occurrence%b
   --  ada.strings.search%s
   --  ada.strings.search%b
   --  ada.tags%s
   --  ada.tags%b
   --  ada.streams%s
   --  ada.streams%b
   --  gnat.os_lib%s
   --  interfaces.c.extensions%s
   --  system.communication%s
   --  system.communication%b
   --  system.file_control_block%s
   --  system.finalization_root%s
   --  system.finalization_root%b
   --  ada.finalization%s
   --  system.file_io%s
   --  system.file_io%b
   --  ada.streams.stream_io%s
   --  ada.streams.stream_io%b
   --  system.linux%s
   --  system.multiprocessors%s
   --  system.multiprocessors%b
   --  system.os_constants%s
   --  system.os_interface%s
   --  system.os_interface%b
   --  system.storage_pools%s
   --  system.storage_pools%b
   --  system.finalization_masters%s
   --  system.finalization_masters%b
   --  system.storage_pools.subpools%s
   --  system.storage_pools.subpools.finalization%s
   --  system.storage_pools.subpools%b
   --  system.storage_pools.subpools.finalization%b
   --  system.stream_attributes%s
   --  system.stream_attributes%b
   --  ada.strings.unbounded%s
   --  ada.strings.unbounded%b
   --  system.task_info%s
   --  system.task_info%b
   --  system.task_primitives%s
   --  system.interrupt_management%s
   --  system.interrupt_management%b
   --  system.tasking%s
   --  system.tasking.debug%s
   --  system.task_primitives.operations%s
   --  system.tasking%b
   --  system.tasking.debug%b
   --  system.task_primitives.operations%b
   --  system.traces.tasking%s
   --  system.traces.tasking%b
   --  system.val_real%s
   --  system.val_real%b
   --  system.val_uns%s
   --  system.val_uns%b
   --  system.val_int%s
   --  system.val_int%b
   --  ada.calendar%s
   --  ada.calendar%b
   --  ada.calendar.delays%s
   --  ada.calendar.delays%b
   --  ada.calendar.time_zones%s
   --  ada.calendar.time_zones%b
   --  ada.calendar.formatting%s
   --  ada.calendar.formatting%b
   --  ada.real_time%s
   --  ada.real_time%b
   --  ada.text_io%s
   --  ada.text_io%b
   --  gnat.calendar%s
   --  gnat.calendar%b
   --  gnat.calendar.time_io%s
   --  gnat.calendar.time_io%b
   --  system.pool_global%s
   --  system.pool_global%b
   --  gnat.serial_communications%s
   --  gnat.serial_communications%b
   --  system.soft_links.tasking%s
   --  system.soft_links.tasking%b
   --  system.strings.stream_ops%s
   --  system.strings.stream_ops%b
   --  system.tasking.initialization%s
   --  system.tasking.task_attributes%s
   --  system.tasking.task_attributes%b
   --  system.tasking.initialization%b
   --  system.tasking.protected_objects%s
   --  system.tasking.protected_objects%b
   --  system.tasking.protected_objects.entries%s
   --  system.tasking.protected_objects.entries%b
   --  system.tasking.queuing%s
   --  system.tasking.queuing%b
   --  system.tasking.utilities%s
   --  system.tasking.utilities%b
   --  system.tasking.entry_calls%s
   --  system.tasking.rendezvous%s
   --  system.tasking.protected_objects.operations%s
   --  system.tasking.protected_objects.operations%b
   --  system.tasking.entry_calls%b
   --  system.tasking.rendezvous%b
   --  system.tasking.stages%s
   --  system.tasking.stages%b
   --  tm_receiver%s
   --  tm_receiver%b
   --  host%b
   --  END ELABORATION ORDER

end ada_main;
