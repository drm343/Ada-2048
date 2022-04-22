with SDL2; use SDL2;

with World_Machine; use World_Machine;
with World_Machine.Events; use World_Machine.Events;
with World_Machine.View;

with Base_2048; use Base_2048;
with Matrix_2048; use Matrix_2048;


package Mode is
  new_game : constant Matrix_2048.Matrix_2048 := Matrix_2048.new_game;
  score : Integer := 0;
  board : Matrix_2048.Matrix_2048 := new_game;

  function Dispatch(render : in out Renderer_Pointer; event : in World_Machine.Events.Events) return Boolean;
private
  function Event_Return(r : in out Renderer_Pointer) return Boolean;
  function Event_Space(r : in out Renderer_Pointer) return Boolean;
  function Event_Left(r : in out Renderer_Pointer) return Boolean;
  function Event_Right(r : in out Renderer_Pointer) return Boolean;
  function Event_Up(r : in out Renderer_Pointer) return Boolean;
  function Event_Down(r : in out Renderer_Pointer) return Boolean;
  function Event_A(r : in out Renderer_Pointer) return Boolean;
  function Event_B(r : in out Renderer_Pointer) return Boolean;
end Mode;
