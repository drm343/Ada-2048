package body Base_2048.Generic_Matrix_2048 is
  procedure Put_Line(X : Matrix_2048) is
  begin
    for I in X'Range(1) loop
      for J in X'Range(2) loop
        Put (Integer'Image (Integer (X (I, J))));
      end loop;
      New_Line;
    end loop;
  end Put_Line;


------------------------------------------------------------
-- Direction Change                                       --
------------------------------------------------------------
  function Swap(X : Matrix_2048) return Matrix_2048 is
    Y : Matrix_2048 := (others => (others => 0));
  begin
    for I in X'Range(1) loop
      for J in X'Range(2) loop
        Y(I, X'Last - J + 1) := X(I, J);
      end loop;
    end loop;

    return Y;
  end Swap;


  function Rotate_Right(X : Matrix_2048) return Matrix_2048 is
    Y : Matrix_2048 := (others => (others => 0));
  begin
    for I in X'Range(1) loop
      for J in X'Range(2) loop
        Y(J, X'Last - I + 1) := X(I, J);
      end loop;
    end loop;

    return Y;
  end Rotate_Right;


  function Rotate_Left(X : Matrix_2048) return Matrix_2048 is
    Y : Matrix_2048 := (others => (others => 0));
  begin
    for I in X'Range(1) loop
      for J in X'Range(2) loop
        Y(X'Last - J + 1, I) := X(I, J);
      end loop;
    end loop;

    return Y;
  end Rotate_Left;


------------------------------------------------------------
-- Compose Matrix                                         --
------------------------------------------------------------
  function "+"(X, Y : Matrix_2048) return Matrix_2048 is
    cell_1 : Matrix_2048 := (others => (others => 0));
  begin
    for I in X'Range(1) loop
      for J in X'Range(2) loop
        cell_1(I, J) := X(I, J) + Y(I, J);
      end loop;
    end loop;
    return cell_1;
  end "+";


  function "*"(r : Integer; X : Matrix_2048) return Matrix_2048 is
    cell_1 : Matrix_2048 := (others => (others => 0));
  begin
    for I in X'Range(1) loop
      for J in X'Range(2) loop
        cell_1(I, J) := r * X(I, J);
      end loop;
    end loop;
    return cell_1;
  end "*";


  function "="(X, Y : Matrix_2048) return Boolean is
  begin
    for I in X'Range(1) loop
      for J in X'Range(2) loop
        if X(I, J) /= Y(I, J) then
          return false;
        end if;
      end loop;
    end loop;
    return true;
  end "=";


  function sum(X : Matrix_2048) return Integer is
    total : Integer := 0;
  begin
    for I in X'Range(1) loop
      for J in X'Range(2) loop
        total := total + X(I, J);
      end loop;
    end loop;
    return total;
  end sum;


  function Score(X : Matrix_2048) return Integer is
  begin
    return sum(2 * X);
  end Score;

  function Compose(X : in Matrix_2048; Move_Area : out Matrix_2048) return Matrix_2048 is
    move : Matrix_2048 := (others => (others => 0));
    add  : Matrix_2048 := (others => (others => 0));

    index : Integer := Matrix_2048'First;
  begin
    Array_Index_1:
    for I in X'Range(1) loop

      index := Matrix_2048'First;

      for J in X'Range(2) loop

        if X (I, J) = 0 then
          goto continue;
        end if;

        if move(I, index) = 0 then
          move(I, index) := X(I, J);
        elsif move(I, index) = X(I, J) then
          add(I, index) := X(I, J);
          index := index + 1;
        else
          index := index + 1;
          move(I, index) := X(I, J);
        end if;
        <<continue>>

      end loop;
    end loop Array_Index_1;

    Move_Area := move;
    return add;
  end Compose;


  function Scan_Win(X : Matrix_2048) return Boolean is
    is_win : Boolean := false;
  begin
    Scan_Loop:
    for I in X'Range(1) loop
      for J in X'Range(2) loop
        if X(I, J) = WIN_VALUE then
          is_win := true;
          exit Scan_Loop;
        end if;
      end loop;
    end loop Scan_Loop;

    return is_win;
  end Scan_Win;


  function Scan_Lost(X : Matrix_2048) return Boolean is
    function Scan_Zero(X : Matrix_2048) return Boolean is
    begin
      for I in X'Range(1) loop
        if X(I, X'Last(2)) = 0 then
          return true;
        end if;
      end loop;
      return false;
    end Scan_Zero;

    is_lost : Boolean := true;

    normal : Matrix_2048 := X;
    rotate : Matrix_2048 := Rotate_Left(X);

    Move_Area : Matrix_2048;
  begin
    if Score(Compose(normal, Move_Area)) /= 0 then
      is_lost := false;
    elsif Scan_Zero(Move_Area) then
      is_lost := false;
    elsif Score(Compose(rotate, Move_Area)) /= 0 then
      is_lost := false;
    elsif Scan_Zero(Move_Area) then
      is_lost := false;
    end if;
    return is_lost;
  end Scan_Lost;


  procedure Set_Number(X : in out Matrix_2048) is
    function Scan_Zero(X : Matrix_2048) return Boolean is
    begin
      for I in X'Range(1) loop
        for J in X'Range(2) loop
          if X(I, J) = 0 then
            return true;
          end if;
        end loop;
      end loop;
      return false;
    end Scan_Zero;


    type Index_Array is array (Grid_Range) of Integer;

    function Scan_I_Zero(X : Matrix_2048) return Index_Array is
      i_array : Index_Array := (others => 0);
    begin
      for I in X'Range(1) loop
        for J in X'Range(2) loop
          if X(I, J) = 0 then
            i_array(I) := i_array(I) + 1;
          end if;
        end loop;
      end loop;
      return i_array;
    end Scan_I_Zero;

    package R is new Ada.Numerics.Discrete_Random(Grid_Range);
    use R;

    G : Generator;
    I : Integer;
    J : Integer;
    i_array : Index_Array;
  begin
    if Scan_Zero(X) then
      i_array := Scan_I_Zero (X);
      Reset (G);

      SET_ZERO:
      loop
        I := Random (G);

        if i_array(I) /= 0 then
          J := Random (G);

          loop
            if X(I, J) = 0 then
              X(I, J) := 2;
              exit SET_ZERO;
            end if;

            J := J + 1;
            if J > Grid_Range'Last then
              J := J - Grid_Range'Last;
            end if;
          end loop;
        end if;
      end loop SET_ZERO;
    end if;
  end Set_Number;


  function Process_Rule(board : in out Matrix_2048; score_value : in out Integer) return Process_State is
    move_area  : Matrix_2048 := board;
    score_area : Matrix_2048 := Compose(board, move_area);
  begin

    if board = (move_area + score_area) then
      if Scan_Lost(board) then
        return LOST;
      end if;
      return SKIP;
    end if;

    score_value := score_value + Score(score_area);
    board := move_area + score_area;

    if Scan_Win(board) then
      return WIN;
    else
      Set_Number(board);

      if Scan_Lost(board) then
        return LOST;
      end if;
    end if;

    return CONTINUE;
  end Process_Rule;
end Base_2048.Generic_Matrix_2048;
