with Matrix_2048;


package World_Machine.View is
  Black : constant Command_Code := (option => Color, red => 0, green => 0, blue => 0);
  White : constant Command_Code := (option => Color, red => 255, green => 255, blue => 255);
  Red   : constant Command_Code := (option => Color, red => 255, green => 0, blue => 0);
  Green : constant Command_Code := (option => Color, red => 0, green => 255, blue => 0);
  Blue  : constant Command_Code := (option => Color, red => 0, green => 0, blue => 255);

  BG_Color : constant Command_Code := (option => Color, red => 245, green => 194, blue => 66);

  Score_Area : SDL_Rect := (200, 100, 300, 0);

  procedure Base_Screen  (render : in out Renderer_Pointer);
  procedure Render_Screen (render : in out Renderer_Pointer);
  procedure Start_Screen (render : in out Renderer_Pointer);
  procedure Clean_Screen (render : in out Renderer_Pointer);
  procedure Draw_Board   (render : in out Renderer_Pointer; board : Matrix_2048.Matrix_2048);
  procedure Update_Score (render : in out Renderer_Pointer; score : Integer);
end World_Machine.View;
