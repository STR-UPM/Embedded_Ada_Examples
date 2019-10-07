--------------------------------------------------------------------------------                                                                          --
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

--  Storage subsystem. 

with Housekeeping.Data; use Housekeeping.Data;

with HAL; use HAL;

package Storage is -- protected
   
   T : UInt16;
   V : UInt16;
--  
   Capacity : constant Positive := 5;

   procedure Put  (Data : in  State);
   --  Store a state snapshot.
   --  Overwrite the oldest element if the store is full.

   procedure Get (Data : out State);
   --  Extract a state snapshot from the store.
   --  Raise Constraint_Error if the store is empty.

   function Last return State;
   --  Get most recent state snapshot. The data is not erased.
   --  Raise Constraint_Error if the store is empty.

   function  Empty return Boolean;
   --  Test for empty store

   function  Full  return Boolean;
   --  Test for full store

end Storage;
