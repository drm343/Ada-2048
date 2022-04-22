with Ada.Finalization;
with Ada.Text_IO; use Ada.Text_IO;


generic
  type T is private;
  type T_Access is access T;

  with procedure Free_T (v : in out T_Access);
package My_RC is
  type Object is new Ada.Finalization.Controlled with private;


  procedure Make (Self : in out Object; V : T);

  procedure Set  (Self : in out Object; V : T_Access);
  function Get (Self : in Object) return T;
  function Get (Self : in Object) return T_Access;

  overriding procedure Finalize (Self : in out Object);
  overriding procedure Adjust   (Self : in out Object);
private
  type Object is new Ada.Finalization.Controlled with
    record
      Value : T_Access := null;
      Count : Integer := 1;
    end record;
end My_RC;
