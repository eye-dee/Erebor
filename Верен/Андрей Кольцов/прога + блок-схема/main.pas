CONST
  LINE = 100;
  COLUMN = 60;
  MAX_VALUE = 5000;

type
  mas = array [1..LINE,1..COLUMN] of integer;
  
procedure swap(var lhs,rhs : integer);
var
  temp : integer;
begin
  temp := lhs;
  lhs := rhs;
  rhs := temp;
end;
  
procedure setRandom(var a : mas);
var
  i,j : integer;
begin
  for i := 1 to LINE do
    for j := 1 to COLUMN do
      a[i,j] := random(MAX_VALUE);
end;

procedure replacement(var a : mas);
var
  i,j : integer;
begin
  for i := 1 to LINE-1 do
    for j:= 1 to COLUMN do
      swap(a[i,j],a[i+1,j]);
end;

VAR
  b : mas;
  
BEGIN
  setRandom(b);
  
  replacement(b);
END.