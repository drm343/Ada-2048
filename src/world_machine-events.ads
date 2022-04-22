package World_Machine.Events is
  type Events is (
    QUIT,
    NOTHING,
    LEFT,
    RIGHT,
    UP,
    DOWN,
    KEY_RETURN,
    SPACE,
    KEY_A,
    KEY_B) with
    Convention => C;
  for Events'Size use C.int'Size;

  function Press_Event return Events;
private
  function C_Press_Event return C.int with
    Import        => True,
    Convention    => C,
    External_Name => "Press_Event";
end World_Machine.Events;
