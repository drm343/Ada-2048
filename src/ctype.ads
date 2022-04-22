package CType is
  type UInt8 is mod 256 with -- unsign 8 bits;
    Size       => 8,
    Convention => C;
  --type UInt8 is range 0 .. 255 with
end CType;
