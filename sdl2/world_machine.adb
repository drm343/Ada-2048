package body World_Machine is
  procedure Put_Line(c : in Command_Code) is
    package IO renames Ada.Text_IO;
  begin
    case c.option is
      when Clear =>
        IO.Put_Line("Clear");
      when Color =>
        IO.Put("Color:");
        IO.Put(UInt8'Image(c.red));
        IO.Put(UInt8'Image(c.green));
        IO.Put(UInt8'Image(c.blue));
        IO.New_Line;
      when Rect =>
        IO.Put("Rect:");
        IO.Put(Sign_32bits'Image(c.x));
        IO.Put(Sign_32bits'Image(c.y));
        IO.Put(Sign_32bits'Image(c.w));
        IO.Put(Sign_32bits'Image(c.h));
        IO.New_Line;
      when Text =>
        IO.Put("Text:");
        Put_Line(c.text.To_C);
        IO.Put(UInt8'Image(c.t_red));
        IO.Put(UInt8'Image(c.t_green));
        IO.Put(UInt8'Image(c.t_blue));
        IO.Put(Sign_32bits'Image(c.t_x));
        IO.Put(Sign_32bits'Image(c.t_y));
        IO.Put(Sign_32bits'Image(c.t_w));
        IO.Put(Sign_32bits'Image(c.t_h));
        IO.New_Line;
      when Present =>
        IO.Put("Present:");
        IO.New_Line;
    end case;
  end Put_Line;


  procedure Draw_Text (render : in out Renderer_Pointer; code : Command_Code) is
    Press_Message : RC_CString.RC_CString := code.text;
    color : SDL_Color := (r => code.t_red,
                          g => code.t_green,
                          b => code.t_blue, a => 255);
    surface : Surface_Pointer;
    texture : Texture_Pointer;

    procedure Free_SDL_Rect is new Ada.Unchecked_Deallocation
      (Object => SDL_Rect, Name => Rect_Pointer);

    target : Rect_Pointer := new SDL_Rect;
  begin
    target.all := (C.int(code.t_x),
                   C.int(code.t_y),
                   C.int(code.t_w),
                   C.int(code.t_h));
    surface := TTF_RenderUTF8_Solid(font, Press_Message.To_C, color);
    texture := SDL_CreateTextureFromSurface(render, surface);
    SDL_RenderCopy(render, texture, NULL, target);
    SDL_DestroyTexture(texture);
    SDL_FreeSurface(surface);
    Free_SDL_Rect(target);
  end Draw_Text;


  procedure Draw_Rect(render : in out Renderer_Pointer; code : Command_Code) is
    package C renames Interfaces.C;

    rect : SDL_Rect := (C.int(code.x),
                        C.int(code.y),
                        C.int(code.w),
                        C.int(code.h));

    discard : C.int := SDL_RenderFillRect(render, rect);
  begin
    NULL;
  end Draw_Rect;


  procedure Set_Color(render : in out Renderer_Pointer; code : Command_Code) is
    discard : C.int := SDL_SetRenderDrawColor(render,
                                              C.unsigned_char(code.red),
                                              C.unsigned_char(code.green),
                                              C.unsigned_char(code.blue),
                                              SDL_ALPHA_OPAQUE);
  begin
    NULL;
  end Set_Color;


  procedure Clean_Screen(render : in out Renderer_Pointer; code : Command_Code) is
    discard : C.int := SDL_RenderClear(render);
  begin
    NULL;
  end Clean_Screen;


  procedure Dispatch(render : in out Renderer_Pointer; code : Command_Code) is
  begin
    case code.option is
      when Color =>
        Set_Color(render, code);
      when Rect =>
        Draw_Rect(render, code);
      when Clear =>
        Clean_Screen(render, code);
      when Text =>
        Draw_Text(render, code);
      when Present =>
        Present_Screen(render, code);
    end case;
  end Dispatch;


  procedure Draw_View(render : in out Renderer_Pointer; code : Command_Code) is
  begin
    Dispatch (render, code);
  end Draw_View;


  procedure Draw_View(render : in out Renderer_Pointer; code : Program_Code) is
    discard : C.int;
  begin
    for i in code'Range loop
      Dispatch (render, code(i));
    end loop;
  end Draw_View;


  procedure Present_Screen(render : in out Renderer_Pointer; code : Command_Code) is
  begin
    SDL_RenderPresent(render);
  end Present_Screen;


  procedure Open_Font (file : in Fonts_Pointer) is
  begin
    font := file;
  end Open_Font;


  procedure Close_Font is
  begin
    TTF_CloseFont(font);
    font := NULL;
  end Close_Font;
end World_Machine;
