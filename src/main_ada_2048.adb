with Ada.Text_IO; use Ada.Text_IO;
with Interfaces.C.Strings;


with SDL2; use SDL2;
with SDL2.TTF; use SDL2.TTF;
with RC_CString;
with My_RC;

with World_Machine; use World_Machine;
with World_Machine.Events; use World_Machine.Events;
with World_Machine.View;

with Mode;


procedure Main_Ada_2048 is
  WIDTH  : constant := 800;
  HEIGHT : constant := 600;

  SDL_WINDOWPOS_UNDEFINED : constant := 16#1FFF_0000#;


  package RC_Window is new My_RC(T => Windows,
                                 T_Access => Windows_Pointer,
                                 Free_T => SDL_DestroyWindow);

  package RC_Render is new My_RC(T => Renderers,
                                 T_Access => Renderer_Pointer,
                                 Free_T => SDL_DestroyRenderer);

  Window : RC_Window.Object;
  Render : RC_Render.Object;
  Title  : RC_CString.RC_CString;

  Font_Path : RC_CString.RC_CString;

  discard : Boolean;
begin
  Title.make("Ada 2048");
  Font_Path.make("/usr/share/fonts/TTF/NotoSansCJK.ttc");

  if SDL_Init = true then
    discard := TTF_Init;
    Open_Font(TTF_OpenFont(Font_Path.To_C, 24));

    RC_Window.Set(window, SDL_CreateWindow(Title.To_C,
                                       SDL_WINDOWPOS_UNDEFINED,
                                       SDL_WINDOWPOS_UNDEFINED,
                                       WIDTH, HEIGHT, Shown or Resizable));

    RC_Render.Set(render, SDL_CreateRenderer(window.Get,
                                             Interfaces.C.int(-1),
                                             SDL_RENDERER_ACCELERATED or SDL_RENDERER_PRESENTVSYNC));


    declare
      r   : Renderer_Pointer := render.Get;

      running : Boolean := true;
      event : World_Machine.Events.Events;
    begin
      World_Machine.View.Clean_Screen(r);
      World_Machine.View.Start_Screen(r);

      while running loop
        event   := Press_Event;
        running := Mode.Dispatch(r, event);
      end loop;
    end;

  end if;

  Close_Font;
  discard := TTF_Quit;
  SDL_Quit;
end Main_Ada_2048;
