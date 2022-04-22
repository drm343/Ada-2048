with Ada.Text_IO;
with Interfaces.C;
with Ada.Unchecked_Deallocation;

with SDL2; use SDL2;
with SDL2.TTF; use SDL2.TTF;

with CType ; use CType ;
with RC_CString; use RC_CString;


package World_Machine is
  type Command is (Clear, Color, Rect, Text, Present);
  type Sign_32bits is range -2_147_483_648 .. 2_147_483_647; -- sign 32 bits;

  font : Fonts_Pointer;


  type Command_Code(option : Command := Clear) is
    record
      case option is
        when Color =>
          red   : UInt8; -- unsign 8 bits
          green : UInt8; -- unsign 8 bits
          blue  : UInt8; -- unsign 8 bits
        when Rect =>
          x : Sign_32bits; -- sign 32 bits 
          y : Sign_32bits; -- sign 32 bits
          w : Sign_32bits; -- sign 32 bits
          h : Sign_32bits; -- sign 32 bits
        when Text =>
          t_red   : UInt8; -- unsign 8 bits
          t_green : UInt8; -- unsign 8 bits
          t_blue  : UInt8; -- unsign 8 bits
          t_x : Sign_32bits; -- sign 32 bits 
          t_y : Sign_32bits; -- sign 32 bits
          t_w : Sign_32bits; -- sign 32 bits
          t_h : Sign_32bits; -- sign 32 bits
          text : RC_CString.RC_CString;
        when others =>
          NULL;
      end case;
    end record;


  procedure Put_Line(c : in Command_Code);


  type Program_Code is array (Integer range <>) of Command_Code;

  procedure Open_Font (file   : in Fonts_Pointer);
  procedure Close_Font;

  procedure Draw_View   (render : in out Renderer_Pointer; code : Command_Code);
  procedure Draw_View   (render : in out Renderer_Pointer; code : Program_Code);
private
  procedure Dispatch    (render : in out Renderer_Pointer; code : Command_Code);
  procedure Draw_Rect   (render : in out Renderer_Pointer; code : Command_Code);
  procedure Draw_Text   (render : in out Renderer_Pointer; code : Command_Code);
  procedure Set_Color   (render : in out Renderer_Pointer; code : Command_Code);
  procedure Clean_Screen(render : in out Renderer_Pointer; code : Command_Code);
  procedure Present_Screen(render : in out Renderer_Pointer; code : Command_Code);
end World_Machine;
