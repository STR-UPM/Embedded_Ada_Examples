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

-- Implementation of the user interface using GTK

with Gdk.Threads;
with Gtk.Main;
with Gtk.Window;          use Gtk.Window;
with Gtk.Grid;            use Gtk.Grid;
with Gtk.Enums;           use Gtk.Enums;
with Gtk.Button;          use Gtk.Button;
with Gtk.Label;           use Gtk.Label;
with Gtk.Text_View;       use Gtk.Text_View;
with Gtk.Text_Buffer;     use Gtk.Text_Buffer;
with Gtk.Text_Iter;       use Gtk.Text_Iter;
with Gtk.Scrolled_Window; use Gtk.Scrolled_Window;
with Gtk.Widget;          use Gtk.Widget;
with Pango.Font;          use Pango.Font;

with TTC_Data.Strings;

package body User_Interface is

   ----------------------
   -- Graphic objects --
   ----------------------

   Window      : Gtk_Window;
   Grid        : Gtk_Grid;
   Label       : Gtk_Label;
   Button      : Gtk_Button;
   Scrolled    : Gtk_Scrolled_Window;
   Text_Buffer : Gtk_Text_Buffer;
   Text        : Gtk_Text_View;
   Iterator    : Gtk_Text_Iter;

   ---------------
   -- Callbacks --
   ---------------

   -- quit GUI
   procedure main_quit (Self : access Gtk_Widget_Record'Class) is
   begin
      Gtk.Main.Main_Quit;
   end main_quit;

   -- send a TC message
   procedure button_clicked(Self : access Gtk_Button_Record'Class) is
   begin
     Send_TC := True;
   end button_clicked;

   ----------
   -- Init --
   ----------

   procedure Init is

   begin
      -- use thread-aware gdk
      Gdk.Threads.G_Init;
      Gdk.Threads.Init;
      Gtk.Main.Init;

      -- create window
      Gtk_New(Window);
      Window.Set_Title("Toy Satellite Ground Station");
      Window.Set_Border_Width (10);
      Window.Set_Resizable (False);
      Window.On_Destroy (main_quit'Access);

      -- grid for placing widgets
      Gtk_New (Grid);
      Window.Add(Grid);

      -- TM area
      Gtk_New(Label, "Telemetry");
      Grid.Attach(Label, 0, 0, 3, 1);

      Gtk_New(Text_Buffer);
      Gtk_New(Text, Text_Buffer);
      Text.Set_Editable(False);
      Text.Modify_Font(From_String("Monospace 10"));
--      Text.Modify_Font(From_String("Menlo 12"));

      Gtk_New(Scrolled);
      Scrolled.Set_Policy(Policy_Automatic, Policy_Automatic);
      Scrolled.Set_Size_Request(60,400);
      --Scrolled.Set_Size_Request(850,400);
      Scrolled.Add(Text);
      Grid.Attach(Scrolled, 0,1,3,12);

      -- TC area
      Gtk_New(Label, "Telecommands");
      Grid.Attach(Label, 3, 0, 1, 1);
      Gtk_New(Button, "Request HK");
      Button.On_Clicked(button_clicked'Access);
      Grid.Attach(Button, 3,1,1,1);

      -- show window
      Grid.Set_Column_Homogeneous(True);
      Grid.Set_Column_Spacing(10);
      Grid.Set_Row_Spacing(10);
      Window.Show_All;

      -- GTK main loop
      Gdk.Threads.Enter;
      Gtk.Main.Main;
      Gdk.Threads.Leave;
   end Init;

   ---------
   -- Put --
   ---------

   procedure Put (S : String) is
   begin
      Gdk.Threads.Enter;
      Text_Buffer.Insert_At_Cursor(" " & S & ASCII.LF);
      Text.Scroll_Mark_Onscreen(Text_Buffer.Get_Insert);
      Text.Show;
      Gdk.Threads.Leave;
   end Put;

   ---------
   -- Put --
   ---------

   procedure Put (M : TM_Message) is
   begin
      Put (TTC_Data.Strings.Image (M));
   end Put;

end User_Interface;
