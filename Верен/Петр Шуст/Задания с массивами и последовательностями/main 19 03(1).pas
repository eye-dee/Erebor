const 
  MAX_SIZE = 10;
  MAX_VALUE = 100;

type
  arr = array [1..MAX_SIZE] of integer;
  
function getMax(var a : arr; var pos : integer);
var 
  i,max : integer;
begin
  pos := 1;
  max := a[pos];
  for i := 2 to MAX_SIZE do
  begin
    if (a[i] > max) then
    begin
      pos := i;
      max := a[pos];
    end;
  end;
  getMax := max;
end;

VAR
  main : arr;
  i : integer;
  
BEGIN
  for i := 1 to MAX_SIZE do
  begin
    main[i] := MAX_VALUE div 2 - random(MAX_VALUE);
    write(main[i], ' ');
  end;
  
  writeln();
  
  writeln(getMax(main,i));
  
END.