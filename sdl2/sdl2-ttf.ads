package SDL2.TTF is
  type TTF_Font is null record;
  type Fonts_Pointer is access all TTF_Font with
    Convention => C;
  subtype Fonts_Ref is not null Fonts_Pointer;

  function TTF_Init return Boolean;
  function TTF_Quit return Boolean;

  function TTF_OpenFont (file : in C.Strings.chars_ptr;
    ptsize : in C.int) return Fonts_Pointer with
    Import        => True,
    Convention    => C,
    External_Name => "TTF_OpenFont";

  procedure TTF_CloseFont (font : in Fonts_Pointer) with
    Import        => True,
    Convention    => C,
    External_Name => "TTF_CloseFont";

  TTF_STYLE_NORMAL    : constant C.int := 16#00#;
  TTF_STYLE_BOLD      : constant C.int := 16#01#;
  TTF_STYLE_ITALIC    : constant C.int := 16#02#;
  TTF_STYLE_UNDERLINE : constant C.int := 16#04#;


  procedure TTF_SetFontStyle(font : in Fonts_Ref; style : C.int) with
    Import        => True,
    Convention    => C,
    External_Name => "TTF_SetFontStyle";

  function TTF_RenderText_Solid (font   : in Fonts_Ref;
                                 Text   : in C.Strings.chars_ptr;
                                 Colour : in SDL_Color)
                                 return Surface_Pointer with
                                 Import        => True,
                                 Convention    => C,
                                 External_Name => "TTF_RenderText_Solid";


  function TTF_RenderUTF8_Solid (font   : in Fonts_Ref;
                                 Text   : in C.Strings.chars_ptr;
                                 Colour : in SDL_Color)
                                 return Surface_Pointer with
                                 Import        => True,
                                 Convention    => C,
                                 External_Name => "TTF_RenderUTF8_Solid";

    function TTF_SizeText(font: in Fonts_Ref;
                          text: in C.Strings.chars_ptr;
                          w   : access C.int;
                          h   : access C.int) return C.int with
                          Import        => True,
                          Convention    => C,
                          External_Name => "TTF_SizeText";

    function TTF_SizeUTF8(font: in Fonts_Ref;
                          text: in C.Strings.chars_ptr;
                          w   : access C.int;
                          h   : access C.int) return C.int with
                          Import        => True,
                          Convention    => C,
                          External_Name => "TTF_SizeUTF8";
end SDL2.TTF;
