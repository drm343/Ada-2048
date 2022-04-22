package body My_RC is
  procedure Make (Self : in out Object; V : T) is
    V_Acc : T_Access := new T'(V);
  begin
    if Self.Value /= null then
      Free_T (Self.Value);
    end if;

    Self.Value := V_Acc;
  end Make;


  procedure Set (Self : in out Object; V : T_Access) is
  begin
    if Self.Value /= null then
      Free_T (Self.Value);
    end if;

    Self.Value := V;
  end Set;


  function Get (Self : in Object) return T is
  begin
    return Self.Value.all;
  end Get;

  function Get (Self : in Object) return T_Access is
  begin
    return Self.Value;
  end Get;


  overriding procedure Finalize (Self : in out Object) is
    Count : Integer := Self.Count - 1;
  begin
    if Count = 0 then
      Free_T (Self.Value);
    else
      Self.Count := Count;
    end if;
  end Finalize;


  overriding procedure Adjust (Self : in out Object) is
  begin
    Self.Count := Self.Count + 1;
  end Adjust;
end My_RC;
