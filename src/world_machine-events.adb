package body World_Machine.Events is
  function Press_Event return Events is
    v : C.int  := C_Press_Event;
    e : Events := Events'Enum_Val(v);
  begin
    return e;
  end Press_Event;
end World_Machine.Events;
