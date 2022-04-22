package body SDL2.TTF is
  function TTF_Init return Boolean is
    function Init return C.int with
      Import        => True,
      Convention    => C,
      External_Name => "TTF_Init";

    Result : constant C.int := Init;
  begin
    return (Result = 0);
  end TTF_Init;


  function TTF_Quit return Boolean is
    function Init return C.int with
      Import        => True,
      Convention    => C,
      External_Name => "TTF_Quit";

    Result : constant C.int := Init;
  begin
    return (Result = 0);
  end TTF_Quit;

end SDL2.TTF;
