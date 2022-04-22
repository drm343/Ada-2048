with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings;

with CType; use CType;


package SDL2 is
  package C renames Interfaces.C;

  type Init_Flags is mod 2 ** 32 with
    Convention => C;

  Null_Init_Flags        : constant Init_Flags := 16#0000_0000#;
  Enable_Timer           : constant Init_Flags := 16#0000_0001#;
  Enable_Audio           : constant Init_Flags := 16#0000_0010#;
  Enable_Screen          : constant Init_Flags := 16#0000_0020#;
  Enable_Joystick        : constant Init_Flags := 16#0000_0200#;
  Enable_Haptic          : constant Init_Flags := 16#0000_1000#;
  Enable_Game_Controller : constant Init_Flags := 16#0000_2000#;
  Enable_Events          : constant Init_Flags := 16#0000_4000#;
  Enable_No_Parachute    : constant Init_Flags := 16#0010_0000#;
  Enable_Everything      : constant Init_Flags :=
    Enable_Timer or Enable_Audio or Enable_Screen or Enable_Joystick or Enable_Haptic or
    Enable_Game_Controller or Enable_Events or Enable_No_Parachute;

  function SDL_Init (Flags : in Init_Flags := Enable_Everything) return Boolean;

  procedure SDL_Quit with
    Import        => True,
    Convention    => C,
    External_Name => "SDL_Quit";


  type Windows is null record;
  type Windows_Pointer is access all Windows with
    Convention => C;

  type Window_Flags is mod 2 ** 32 with
    Convention => C;

  Windowed            : constant Window_Flags := 16#0000_0000#;
  Full_Screen         : constant Window_Flags := 16#0000_0001#;
  OpenGL              : constant Window_Flags := 16#0000_0002#;
  Shown               : constant Window_Flags := 16#0000_0004#;
  Hidden              : constant Window_Flags := 16#0000_0008#;
  Borderless          : constant Window_Flags := 16#0000_0010#;
  Resizable           : constant Window_Flags := 16#0000_0020#;
  Minimised           : constant Window_Flags := 16#0000_0040#;
  Maximised           : constant Window_Flags := 16#0000_0080#;
  Input_Grabbed       : constant Window_Flags := 16#0000_0100#;
  Input_Focus         : constant Window_Flags := 16#0000_0200#;
  Mouse_Focus         : constant Window_Flags := 16#0000_0400#;
  Full_Screen_Desktop : constant Window_Flags := Full_Screen or 16#0000_1000#;

  function SDL_CreateWindow
    (Title      : C.Strings.chars_ptr;
    X, Y, W, H : in C.int;
    F          : in Window_Flags) return Windows_Pointer with
    Import        => True,
    Convention    => C,
    External_Name => "SDL_CreateWindow";

  procedure SDL_DestroyWindow
    (Window : in out Windows_Pointer) with
    Import        => True,
    Convention    => C,
    External_Name => "SDL_DestroyWindow";

  type SDL_Rect is
      record
         X      : C.int;
         Y      : C.int;
         Width  : C.int;
         Height : C.int;
      end record with
     Convention => C;
  type Rect_Pointer is access all SDL_Rect with
    Convention => C;

  type Renderers is null record;
  type Renderer_Pointer is access all Renderers with
    Convention => C;

  function SDL_RenderFillRect (R  : in Renderer_Pointer;
      Rect : in SDL_Rect) return C.int with
      Import        => True,
      Convention    => C,
      External_Name => "SDL_RenderFillRect";

  function SDL_RenderClear (R : in Renderer_Pointer) return C.int with
    Import        => True,
    Convention    => C,
    External_Name => "SDL_RenderClear";


  SDL_ALPHA_OPAQUE : constant := 255;


  function SDL_SetRenderDrawColor (R : in Renderer_Pointer;
                                    red   : C.unsigned_char;
                                    green : C.unsigned_char;
                                    blue  : C.unsigned_char;
                                    alpha : C.unsigned_char) return C.int with
    Import        => True,
    Convention    => C,
    External_Name => "SDL_SetRenderDrawColor";


  procedure SDL_RenderPresent (R : in Renderer_Pointer) with
    Import        => True,
    Convention    => C,
    External_Name => "SDL_RenderPresent";

  type Renderer_Flags is mod 2 ** 32 with
     Convention => C;

  Default_Renderer_Flags      : constant Renderer_Flags := 16#0000_0000#;
  SDL_RENDERER_SOFTWARE       : constant Renderer_Flags := 16#0000_0001#;
  SDL_RENDERER_ACCELERATED    : constant Renderer_Flags := 16#0000_0002#;
  SDL_RENDERER_PRESENTVSYNC   : constant Renderer_Flags := 16#0000_0004#;
  SDL_RENDERER_TARGET_TEXTURE : constant Renderer_Flags := 16#0000_0008#;

  function SDL_CreateRenderer (W : in Windows_Pointer;
                               Index : in C.int;
                               Flags : in Renderer_Flags) return Renderer_Pointer with
        Import        => True,
        Convention    => C,
        External_Name => "SDL_CreateRenderer";

  procedure SDL_DestroyRenderer (R : in out Renderer_Pointer) with
        Import        => True,
        Convention    => C,
        External_Name => "SDL_DestroyRenderer";

--  function SDL_PollEvent (Event : out SDL_Event) return C.int with
--    Import        => True,
--    Convention    => C,
--    External_Name => "SDL_PollEvent";

  type SDL_Color is
    record
      r : UInt8 := UInt8'First;
      g : UInt8 := UInt8'First;
      b : UInt8 := UInt8'First;
      a : UInt8 := UInt8'First;
    end record with
  Convention => C_Pass_by_Copy,
  Size       => UInt8'Size * 4;


  type SDL_Surface is null record;
  type Surface_Pointer is access all SDL_Surface with
    Convention => C;

  procedure SDL_FreeSurface(surface : in Surface_Pointer) with
    Import        => True,
    Convention    => C,
    External_Name => "SDL_FreeSurface";


  type SDL_Texture is null record;
  type Texture_Pointer is access all SDL_Texture with
    Convention => C;


  function SDL_CreateTextureFromSurface(render : in Renderer_Pointer; surface : in Surface_Pointer) return Texture_Pointer with
    Import        => True,
    Convention    => C,
    External_Name => "SDL_CreateTextureFromSurface";


  procedure SDL_DestroyTexture(texture : in Texture_Pointer) with
    Import        => True,
    Convention    => C,
    External_Name => "SDL_DestroyTexture";


  procedure SDL_RenderCopy(render : in Renderer_Pointer;
                           texture: in Texture_Pointer;
                           source : in Rect_Pointer;
                           target : in Rect_Pointer) with
                           Import        => True,
                           Convention    => C,
                           External_Name => "SDL_RenderCopy";
end SDL2;
