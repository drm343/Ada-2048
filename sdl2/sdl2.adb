package body SDL2 is
  function SDL_Init (Flags : in Init_Flags := Enable_Everything) return Boolean is
    function Init (Flags : in Init_Flags := Enable_Everything) return C.int with
      Import        => True,
      Convention    => C,
      External_Name => "SDL_Init";

    Result : constant C.int := Init (Flags);
  begin
    return (Result = 0);
  end SDL_Init;
end SDL2;
