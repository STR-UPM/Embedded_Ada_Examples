------------------------------------------------------------------------------
--                                                                          --
--  Copyright (C) 2017-2018, Universidad Politécnica de Madrid              --
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
------------------------------------------------------------------------------

package body Buffer is

   ------------------------------------
   -- Protected object specification --
   ------------------------------------

   type Index is mod Capacity;
   type Store is array (Index) of Measurement;

   protected Buffer is
      procedure Put (M : in  Measurement);
      procedure Get (M : out Measurement);
      function  Last  return Measurement;
      function  Empty return Boolean;
      function  Full  return Boolean;
   private
      Data     :  Store;
      Next_In  :  Index   := 0; -- next new item
      Last_In  :  Index   := 0; -- newest item in buffer
      Next_Out :  Index   := 0; -- oldest item in buffer
      Count    :  Natural := 0;
   end Buffer;

   ---------
   -- Put --
   ---------

   procedure Put  (M : in  Measurement) is
   begin
      Buffer.Put (M);
   end Put;

   ---------
   -- Get --
   ---------

   procedure Get (M : out Measurement) is
   begin
      Buffer.Get (M);
   end Get;

   ----------
   -- Last --
   ----------

   function Last return Measurement is
   begin
      return Buffer.Last;
   end Last;

   -----------
   -- Empty --
   -----------

   function  Empty return Boolean is
   begin
      return Buffer.Empty;
   end Empty;

   function  Full return Boolean is
   begin
      return Buffer.Full;
   end Full;

   ---------------------------
   -- Protected object body --
   ---------------------------

   protected body Buffer is

      procedure Put (M : in  Measurement) is
      begin
         Data (Next_In) := M;
         Last_In := Next_In;
         Next_In := Next_In + 1;
         if Count < Capacity then
            Count   := Count + 1;
         else -- buffer full, overwrite oldest measurement
            Next_Out := Next_Out + 1;
         end if;
      end Put;

      procedure Get (M : out Measurement) is
      begin
         if Empty then
            raise Constraint_Error;
         end if;
         M := Data (Next_Out);
         Next_Out := Next_Out + 1;
         Count := Count - 1;
      end Get;

      function Last return Measurement is
      begin
         return Data (Last_In);
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

end Buffer;
