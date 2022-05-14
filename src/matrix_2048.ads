with Base_2048;
with Base_2048.Generic_Matrix_2048;


package Matrix_2048 is
  package My_2048 is new Base_2048.Generic_Matrix_2048(Grid_Size => 4,
                                                       Win_Value => 2048);

  use My_2048;

  new_game : constant My_2048.Matrix_2048 := My_2048.new_game;

  use type Base_2048.Process_State;
  use type My_2048.Matrix_2048;
  subtype Matrix_2048 is My_2048.Matrix_2048;

------------------------------------------------------------
-- Direction Change                                       --
------------------------------------------------------------
  function Swap(X : Matrix_2048) return Matrix_2048 renames My_2048.Swap;
  function Rotate_Right(X : Matrix_2048) return Matrix_2048 renames My_2048.Rotate_Right;
  function Rotate_Left(X : Matrix_2048) return Matrix_2048 renames My_2048.Rotate_Left;

------------------------------------------------------------
-- Socre And Game Status                                  --
------------------------------------------------------------
  function Score(X : Matrix_2048) return Integer renames My_2048.Score;
  function Scan_Win(X : Matrix_2048) return Boolean renames My_2048.Scan_Win;
  function Scan_Lost(X : Matrix_2048) return Boolean renames My_2048.Scan_Lost;

  procedure Set_Number(X : in out Matrix_2048) renames My_2048.Set_Number;
  function Process_Rule(board : in out Matrix_2048; score_value : in out Integer)
    return Base_2048.Process_State renames My_2048.Process_Rule;
end Matrix_2048;
