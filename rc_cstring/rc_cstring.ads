with Ada.Finalization;
with Interfaces.C.Strings;


package RC_CString is
  package CStrings renames Interfaces.C.Strings;

  type RC_CString is new Ada.Finalization.Controlled with private;

  procedure Make (Self : in out RC_CString; V : String);
  function To_C (Self : in RC_CString) return CStrings.chars_ptr;

  overriding
  procedure Finalize (Self : in out RC_CString);

  overriding
  procedure Adjust   (Self : in out RC_CString);


  procedure Put_Line(C : CStrings.chars_ptr) with
    Import        => True,
    Convention    => C,
    External_Name => "C_Put_Line";
private
  type RC_CString is new Ada.Finalization.Controlled with
    record
      Value  : CStrings.chars_ptr;
      Count  : Integer := 1;
    end record;
end RC_CString;
