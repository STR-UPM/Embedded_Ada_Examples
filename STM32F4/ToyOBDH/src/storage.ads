------------------------------------------------------------------------------
--                                                                          --
--          Copyright (C) 2018, Universidad Politécnica de Madrid           --
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

--  Buffer for storing measurements. Measurements are inserted
--  and extracted in FIFO order.

with HK_Data;    use  HK_Data;

package Storage is -- protected

   Capacity : constant Positive := 5;

   procedure Put  (Data : in  Sensor_Data);
   --  Insert a measurement into the buffer.
   --  Overwrite the oldest element if the buffer is full.

   procedure Get (Data : out Sensor_Data);
   --  Extract a measurement from the buffer.
   --  Raise Constraint_Error if the buffer is empty.

   function Last return Sensor_Data;
   --  Get most recent measurement. The data is not erased.
   --  Raise Constraint_Error if the buffer is empty.

   function  Empty return Boolean;
   --  Test for empty buffer

   function  Full  return Boolean;
   --  Test for full bufer

end Storage;
