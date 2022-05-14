with Ada.Text_IO; use Ada.Text_IO;
with Ada.Numerics.Discrete_Random;


generic
  Grid_Size : Positive;
  Win_Value : Positive;
package Base_2048.Generic_Matrix_2048 is
  subtype Grid_Range is Integer range 1 .. Grid_Size;
  type Matrix_2048 is array (Grid_Range, Grid_Range) of Integer;
  pragma Convention(C, Matrix_2048);

  new_game : Matrix_2048 := (others => (others => 0));

  procedure Put_Line(X : Matrix_2048);

------------------------------------------------------------
-- Direction Change                                       --
------------------------------------------------------------
  function Swap(X : Matrix_2048) return Matrix_2048;
  function Rotate_Right(X : Matrix_2048) return Matrix_2048;
  function Rotate_Left(X : Matrix_2048) return Matrix_2048;

------------------------------------------------------------
-- Compose Matrix                                         --
------------------------------------------------------------
  function Compose(X : in Matrix_2048; Move_Area : out Matrix_2048) return Matrix_2048;

  function "+"(X, Y : Matrix_2048) return Matrix_2048;
  function "*"(r : Integer; X : Matrix_2048) return Matrix_2048;
  function "="(X, Y : Matrix_2048) return Boolean;

------------------------------------------------------------
-- Socre And Game Status                                  --
------------------------------------------------------------
  function Score(X : Matrix_2048) return Integer;
  function Scan_Win(X : Matrix_2048) return Boolean;
  function Scan_Lost(X : Matrix_2048) return Boolean;

  procedure Set_Number(X : in out Matrix_2048);
  function Process_Rule(board : in out Matrix_2048; score_value : in out Integer) return Process_State;
private
  function sum(X : Matrix_2048) return Integer;
end Base_2048.Generic_Matrix_2048;
