------------------------------------------------------------------------------
--                                                                          --
--          Copyright (C) 2017, Universidad Politécnica de Madrid           --
--                                                                          --
--  Redistribution and use in source and binary forms, with or without      --
--  modification, are permitted provided that the following conditions are  --
--  met:                                                                    --
--     1. Redistributions of source code must retain the above copyright    --
--        notice, this list of conditions and the following disclaimer.     --
--     2. Redistributions in binary form must reproduce the above copyright --
--        notice, this list of conditions and the following disclaimer in   --
--        the documentation and/or other materials provided with the        --
--        distribution.                                                     --
--     3. Neither the name of the copyright holder nor the names of its     --
--        contributors may be used to endorse or promote products derived   --
--        from this software without specific prior written permission.     --
--                                                                          --
--   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS    --
--   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT      --
--   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR  --
--   A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT   --
--   HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, --
--   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT       --
--   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,  --
--   DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY  --
--   THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT    --
--   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE  --
--   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.   --
--                                                                          --
-------------------------------------------------------------------------------

-- Partial implementation by Antonio Ramos Nieto
-- Adapted to MUSE lab by Juan A. de la Puente

-- Telemetry reception subsystem

with HK_Data;          use HK_Data;
with TTC_Data;         use TTC_Data;
with Ada.Real_Time;    use Ada.Real_Time;

with System;
with GNAT.Serial_Communications; use GNAT.Serial_Communications;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
--with AWS.Client;
--with client_mqtt; use client_mqtt;

package TTC is

   procedure Init;
   -- Initialize TTC sybsystem

   procedure Send (TC : TC_Type := HK);
   -- Send a telecommand

private

   ----------------------
   -- MQTT definitions --
   ----------------------
--     Connection_Param : constant Connection_Parameters :=
--       (Host => To_Unbounded_String ("acrux.dit.upm.es"),
--        Port => To_Unbounded_String ("8883"),
--        Client_ID => To_Unbounded_String ("AABBCC"),
--        Username => To_Unbounded_String ("antonio52"),
--        Password => To_Unbounded_String ("TFGantonio9"));
--     Subscribe_Param : constant Subscribe_Parameters :=
--       (Topic => To_Unbounded_String ("tc"),
--        QoS => Character'Val(16#00#),
--        Packet_ID => Character'Val(16#00#) & Character'Val(16#01#),
--        Expected_Message => To_Unbounded_String ("tc"));
--
--     Con_MQTT : Connection_MQTT;

   ----------------------
   -- Port definitions --
   ----------------------

   COM : aliased Serial_Port;
   USB : constant Port_Name := "/dev/ttyUSB0";

   -----------
   -- Tasks --
   -----------

   task TM_Receiver
     with Priority =>  System.Default_Priority;
   -- replace with DMS priority when available

   task TC_Sender
     with Priority => System.Default_Priority;
   -- replace with DMS priority when available

end TTC;
