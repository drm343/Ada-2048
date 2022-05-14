with Interfaces.C;
with Interfaces.C.Pointers;


package Matrix_2048.C is
  package C renames Interfaces.C;

  h : C.int := 30
    with
      Export => True,
      Convention => C;

------------------------------------------------------------
-- Direction Change                                       --
------------------------------------------------------------
  procedure Swap(X : in Matrix_2048; Y : out Matrix_2048);
  pragma Export(Convention    => C,
                Entity        => Swap,
                External_Name => "swap");

  procedure Rotate_Right(X : in Matrix_2048; Y : out Matrix_2048);
  pragma Export(Convention    => C,
                Entity        => Rotate_Right,
                External_Name => "rotate_right");

  procedure Rotate_Left(X : in Matrix_2048; Y : out Matrix_2048);
  pragma Export(Convention    => C,
                Entity        => Rotate_Left,
                External_Name => "rotate_left");

------------------------------------------------------------
-- Socre And Game Status                                  --
------------------------------------------------------------
  procedure Set_Number(X : in out Matrix_2048);
  pragma Export(Convention    => C,
                Entity        => Set_Number,
                External_Name => "set_number");

  type c_int_array is Array (Integer range <>) of aliased C.int;
  package p_int is new Interfaces.C.Pointers(Integer, C.int, c_int_array, 0);

  function Process_Rule(board : in out Matrix_2048; score : in p_int.Pointer) return Base_2048.Process_State;
  pragma Export(Convention    => C,
                Entity        => Process_Rule,
                External_Name => "process_rule");
end Matrix_2048.C;
