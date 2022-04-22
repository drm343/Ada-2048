package body World_Machine.View is
  procedure Base_Screen (render : in out Renderer_Pointer) is
    score_text : RC_CString.RC_CString;

    program : Program_Code(1 .. 5) := (BG_Color,
                                       (option => Clear),
                                       White,
                                       others => (option => Present));

    w : aliased C.int;
    h : aliased C.int;
    discard : C.int;
  begin
    score_text.Make("Score:");
    discard := TTF_SizeText(font, score_text.To_C, w'Access, h'Access);
    score_area.Height := h;

    program(4) := (option => Rect,
                   X      => Sign_32bits(score_area.X),
                   Y      => Sign_32bits(score_area.Y),
                   w      => Sign_32bits(score_area.Width),
                   h      => Sign_32bits(score_area.Height));

    program(5) := (option => Text,
                   t_red => Black.red, t_green => Black.green, t_blue => Black.blue,
                   t_x   => 100, t_y => 100, t_w => Sign_32bits(w), t_h => Sign_32bits(h),
                   text  => score_text);
    TTF_SetFontStyle(font, TTF_STYLE_BOLD);
    Draw_View(render, program);
    TTF_SetFontStyle(font, TTF_STYLE_NORMAL);
  end Base_Screen;


  procedure Render_Screen (render : in out Renderer_Pointer) is
    program : Command_Code := (option => Present);
  begin
    Draw_View(render, program);
  end Render_Screen;


  procedure Start_Screen (render : in out Renderer_Pointer) is
    press   : RC_CString.RC_CString;

    program : Program_Code(1 .. 2) := (others => (option => Present));

    w : aliased C.int;
    h : aliased C.int;
    discard : C.int;
  begin
    press.Make("請按下 select 開始新遊戲");
    discard := TTF_SizeUTF8(font, press.To_C, w'Access, h'Access);
    score_area.Height := h;

    program(1) := (option => Text,
                   t_red => Black.red, t_green => Black.green, t_blue => Black.blue,
                   t_x   => 500, t_y => 100, t_w => Sign_32bits(w), t_h => Sign_32bits(h),
                   text  => press);

    TTF_SetFontStyle(font, TTF_STYLE_BOLD);
    Draw_View(render, program);
    TTF_SetFontStyle(font, TTF_STYLE_NORMAL);
  end Start_Screen;


  procedure Clean_Screen (render : in out Renderer_Pointer) is
  begin
    Base_Screen(render);
  end Clean_Screen;


  procedure Draw_Board (render : in out Renderer_Pointer; board : Matrix_2048.Matrix_2048) is
    START_X : constant := 200;
    START_Y : constant := 150;
    GRID_WIDTH : constant := 400;

    program : Program_Code(1 .. 2) := (White,
                                       (option => Rect,
                                        X      => START_X,
                                        Y      => START_Y,
                                        w      => GRID_WIDTH,
                                        h      => GRID_WIDTH),
                                       others => (option => Present));

    Last  : constant := board'Last;
    Pixel : constant := 400 / Last - 1;
  begin
    Draw_View(render, program);

    for I in board'Range(1) loop
      for J in board'Range(1) loop
        declare
          use Interfaces.C;

          w : aliased C.int;
          h : aliased C.int;
          discard : C.int;

          X : Integer := START_X + 1 + Pixel * (J - 1);
          Y : Integer := START_Y + 1 + Pixel * (I - 1);

          program : Program_Code(1 .. 3) := (Green,
                                            (option => Rect,
                                             X      => Sign_32bits(X),
                                             Y      => Sign_32bits(Y),
                                             w      => Sign_32bits(Pixel - 1),
                                             h      => Sign_32bits(Pixel - 1)), others => Green);

          number : Integer := board(I, J);
          board_text : RC_CString.RC_CString;
        begin
          board_text.Make(Integer'Image(number));
          discard := TTF_SizeUTF8(font, board_text.To_C, w'Access, h'Access);

          if w >= Pixel - 1 then
            w := Pixel - 1;
          end if;

          program(3) := (option => Text,
                         t_red => Black.red, t_green => Black.green, t_blue => Black.blue,
                         t_x   => Sign_32bits(X), t_y => Sign_32bits(Y), t_w => Sign_32bits(w), t_h => Sign_32bits(h),
                         text  => board_text);
          Draw_View(render, program);
        end;
      end loop;
    end loop;
  end Draw_Board;


  procedure Update_Score (render : in out Renderer_Pointer; score : Integer) is
    score_text : RC_CString.RC_CString;

    w : aliased C.int;
    h : aliased C.int;
    discard : C.int;

    program : Program_Code(1 .. 3) := (White,
                                       (option => Rect,
                                        X      => Sign_32bits(score_area.X),
                                        Y      => Sign_32bits(score_area.Y),
                                        w      => Sign_32bits(score_area.Width),
                                        h      => Sign_32bits(score_area.Height)),
                                       others => (option => Present));
  begin
    score_text.Make(Integer'Image(score));
    discard := TTF_SizeUTF8(font, score_text.To_C, w'Access, h'Access);

    program(3) := (option => Text,
                   t_red => Black.red, t_green => Black.green, t_blue => Black.blue,
                   t_x   => 200, t_y => 100, t_w => Sign_32bits(w), t_h => Sign_32bits(h),
                   text  => score_text);

    TTF_SetFontStyle(font, TTF_STYLE_BOLD);
    Draw_View(render, program);
    TTF_SetFontStyle(font, TTF_STYLE_NORMAL);
  end Update_Score;
end World_Machine.View;
