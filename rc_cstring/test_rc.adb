with Ada.Text_IO; use Ada.Text_IO;

with RC_CString; use RC_CString;


procedure Test_Rc is
  type A is
    record
      Title : RC_CString.RC_CString;
      Name  : RC_CString.RC_CString;
    end record;


  procedure IIO(hi : in out A) is
    rc : RC_CString.RC_CString := hi.Title;
  begin
    rc := hi.Name;

    hi.Title.make("Ada 2048");
    hi.Name.make("hello");
    rc := hi.Name;

    Put_Line("suck");
    Put_Line(hi.Title.to_c);
    Put_Line(hi.Name.to_c);
    Put_Line(rc.to_c);
  end IIO;

  hi : A;
begin
  IIO(hi);
  Put_Line(hi.Title.to_c);
  Put_Line(hi.Name.to_c);
end Test_Rc;
