--          Copyright (C) 2019, Universidad Politécnica de Madrid           --
--                                                                          --
-- This is free software;  you can redistribute it  and/or modify it  under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 3,  or (at your option) any later ver- --
-- sion.  This software is distributed in the hope  that it will be useful, --
-- but WITHOUT ANY WARRANTY;  without even the implied warranty of MERCHAN- --
-- TABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public --
-- License for  more details.  You should have  received  a copy of the GNU --
-- General  Public  License  distributed  with  this  software;   see  file --
-- COPYING3.  If not, go to http://www.gnu.org/licenses for a complete copy --
-- of the license.                                                          --
--                                                                          --
------------------------------------------------------------------------------
pragma Ada_2012;

package body Storage is

   ------------------------
   -- Buffer (protected) --
   ------------------------

   type Index is mod Capacity;
   type Store is array (Index) of State;

   protected Buffer is
      procedure Put (Data : in  State);
      procedure Get (Data : out State);
      function  Last  return State;
      function  Empty return Boolean;
      function  Full  return Boolean;
   private
      Box      :  Store;
      Next_In  :  Index   := 0; -- next new item
      Last_In  :  Index   := 0; -- newest item in buffer
      Next_Out :  Index   := 0; -- oldest item in buffer
      Count    :  Natural := 0;
   end Buffer;

   ---------
   -- Put --
   ---------

   procedure Put (Data : in State) is
   begin
      Buffer.Put (Data);
   end Put;

   ---------
   -- Get --
   ---------

   procedure Get (Data : out State) is
   begin
      Buffer.Get (Data);
   end Get;

   ----------
   -- Last --
   ----------

   function Last return State is
   begin
      return Buffer.Last;
   end Last;

   -----------
   -- Empty --
   -----------

   function Empty return Boolean is
   begin
      return Buffer.Empty;
   end Empty;

   ----------
   -- Full --
   ----------

   function Full return Boolean is
   begin
      return Buffer.Full;
   end Full;

   ---------------------------
   -- Protected object body --
   ---------------------------

   protected body Buffer is

      procedure Put (Data : in  State) is
      begin
         Box (Next_In) := Data;
         Last_In := Next_In;
         Next_In := Next_In + 1;
         if Count < Capacity then
            Count   := Count + 1;
         else -- buffer full, overwrite oldest Sensor_Data
            Next_Out := Next_Out + 1;
         end if;
      end Put;

      procedure Get (Data : out State) is
      begin
         if Empty then
            raise Constraint_Error;
         end if;
         Data := Box (Next_Out);
         Next_Out := Next_Out + 1;
         Count := Count - 1;
      end Get;

      function Last return State is
      begin
         return Box (Last_In);
      end Last;

      function Empty return Boolean is
      begin
         return Count = 0;
      end Empty;

      function Full return Boolean is
      begin
         return Count = Capacity;
      end Full;

   end Buffer;


end Storage;
