with Ada.Text_IO; use Ada.Text_IO;


package body RC_CString is
  procedure Make (Self : in out RC_CString; V : String) is
  begin
    Interfaces.C.Strings.Free(Self.Value);
    Self.Value  := Interfaces.C.Strings.New_String(V);
  end Make;


  function To_C (Self : in RC_CString) return CStrings.chars_ptr is
  begin
    return Self.Value;
  end To_C;


  overriding
  procedure Finalize (Self : in out RC_CString) is
    Count : Integer := Self.Count - 1;
  begin
    if Count = 0 then
      Interfaces.C.Strings.Free(Self.Value);
    else
      Self.Count := Count;
    end if;
  end Finalize;


  overriding
  procedure Adjust (Self : in out RC_CString) is
  begin
    Self.Count := Self.Count + 1;
  end Adjust;
end RC_CString;
