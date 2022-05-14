package body Matrix_2048.C is
------------------------------------------------------------
-- Direction Change                                       --
------------------------------------------------------------
  procedure Swap(X : in Matrix_2048; Y : out Matrix_2048) is
  begin
    Y := My_2048.Swap(X);
  end;

  procedure Rotate_Right(X : in Matrix_2048; Y : out Matrix_2048) is
  begin
    Y := My_2048.Rotate_Right(X);
  end;

  procedure Rotate_Left(X : in Matrix_2048; Y : out Matrix_2048) is
  begin
    Y := My_2048.Rotate_Left(X);
  end;

------------------------------------------------------------
-- Socre And Game Status                                  --
------------------------------------------------------------
  procedure Set_Number(X : in out Matrix_2048) is
  begin
    My_2048.Set_Number(X);
  end Set_Number;

  function Process_Rule(board : in out Matrix_2048; score : in p_int.Pointer)
    return Base_2048.Process_State is

    score_value : Integer := Integer(score.all);
    state : Base_2048.Process_State;
  begin
    state := My_2048.Process_Rule(board, score_value);
    score.all := C.int(score_value);
    return state;
  end Process_Rule;
end Matrix_2048.C;
