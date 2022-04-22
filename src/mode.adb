with Ada.Text_IO; use Ada.Text_IO;


package body Mode is
  function Dispatch(render : in out Renderer_Pointer; event : in World_Machine.Events.Events) return Boolean is
    running : Boolean := true;
  begin
    case event is
      when World_Machine.Events.QUIT =>
        running := false;
      when World_Machine.Events.KEY_RETURN =>
        running := Event_Return(render);
      when World_Machine.Events.SPACE =>
        running := Event_Space(render);
      when World_Machine.Events.KEY_A =>
        running := Event_A(render);
      when World_Machine.Events.KEY_B =>
        running := Event_B(render);
      when World_Machine.Events.Left =>
        running := Event_Left(render);
      when World_Machine.Events.Right =>
        running := Event_Right(render);
      when World_Machine.Events.Up =>
        running := Event_Up(render);
      when World_Machine.Events.Down =>
        running := Event_Down(render);
      when others=>
        null;
    end case;
    return running;
  end Dispatch;


  function Event_Return(r : in out Renderer_Pointer) return Boolean is
  begin
    return false;
  end Event_Return;


  function Event_Space(r : in out Renderer_Pointer) return Boolean is
  begin
    board := new_game;
    score := 0;
    Set_Number(board);

    World_Machine.View.Clean_Screen(r);
    World_Machine.View.Draw_Board(r, board);
    World_Machine.View.Update_Score(r, score);
    World_Machine.View.Render_Screen(r);
    return true;
  end Event_Space;


  function Event_Left(r : in out Renderer_Pointer) return Boolean is
    running : Boolean := true;
    state : Base_2048.Process_State := Process_Rule(board, score);
  begin
    case state is
      when SKIP =>
        null;
      when CONTINUE =>
        World_Machine.View.Update_Score(r, score);
      when WIN =>
        running := false;
        Ada.Text_IO.Put_Line("You Win");
      when LOST =>
        running := false;
        Ada.Text_IO.Put_Line("You Lost");
    end case;

    World_Machine.View.Draw_Board(r, board);
    World_Machine.View.Render_Screen(r);
    return running;
  end Event_Left;


  function Event_Right(r : in out Renderer_Pointer) return Boolean is
    running : Boolean := true;

    tmp : Matrix_2048.Matrix_2048;
    state: Process_State;
  begin
    tmp   := Swap(board);
    state := Process_Rule(tmp, score);

    case state is
      when SKIP =>
        null;
      when CONTINUE =>
        World_Machine.View.Update_Score(r, score);
      when WIN =>
        running := false;
        Ada.Text_IO.Put_Line("You Win");
      when LOST =>
        running := false;
        Ada.Text_IO.Put_Line("You Lost");
    end case;

    board := Swap(tmp);

    World_Machine.View.Draw_Board(r, board);
    World_Machine.View.Render_Screen(r);
    return running;
  end Event_Right;


  function Event_Up(r : in out Renderer_Pointer) return Boolean is
    running : Boolean := true;

    tmp : Matrix_2048.Matrix_2048;
    state: Process_State;
  begin
    tmp   := Rotate_Left(board);
    state := Process_Rule(tmp, score);

    case state is
      when SKIP =>
        null;
      when CONTINUE =>
        World_Machine.View.Draw_Board(r, board);
      when WIN =>
        running := false;
        Ada.Text_IO.Put_Line("You Win");
      when LOST =>
        running := false;
        Ada.Text_IO.Put_Line("You Lost");
    end case;

    board := Rotate_Right(tmp);

    World_Machine.View.Draw_Board(r, board);
    World_Machine.View.Render_Screen(r);
    return running;
  end Event_Up;


  function Event_Down(r : in out Renderer_Pointer) return Boolean is
    running : Boolean := true;

    tmp : Matrix_2048.Matrix_2048;
    state: Process_State;
  begin
    tmp   := Rotate_Right(board);
    state := Process_Rule(tmp, score);

    case state is
      when SKIP =>
        null;
      when CONTINUE =>
        World_Machine.View.Draw_Board(r, board);
      when WIN =>
        running := false;
        Ada.Text_IO.Put_Line("You Win");
      when LOST =>
        running := false;
        Ada.Text_IO.Put_Line("You Lost");
    end case;

    board := Rotate_Left(tmp);

    World_Machine.View.Draw_Board(r, board);
    World_Machine.View.Render_Screen(r);
    return running;
  end Event_Down;

  function Event_A(r : in out Renderer_Pointer) return Boolean is
  begin
    return true;
  end Event_A;

  function Event_B(r : in out Renderer_Pointer) return Boolean is
  begin
    return true;
  end Event_B;
end Mode;
