const 
  MAX_SIZE = 20;
  MAX_VALUE = 1000;

type
  arr = array [1..MAX_SIZE] of integer;
  
procedure swap(var lhs,rhs : integer);
var
   temp : integer;
begin
  temp := lhs;
  lhs := rhs;
  rhs := temp;
end;

procedure Qsort(var a : arr; left,right : integer);
var
  m,i,j : integer;
begin
  if (left < right) then
  begin
    m := a[left + random(right - left)];
    i := left;
    j := right;
    while i <= j do
    begin
      while (a[i] < m) do
        i := i + 1;
      while (a[j] > m) do
        j := j - 1;
      if (i > j) then
        break;
      swap(a[i],a[j]);
      i := i+1;
      j := j-1;
    end;
    Qsort(a,left,j);
    Qsort(a,i,right);
  end;
end;

procedure print(a : arr);
var
  i : integer;
begin
  for i := 1 to MAX_SIZE do
  begin
    write(a[i], ' ');
  end;
  writeln();
end; 

VAR
  main : arr;
  i : integer;
  
BEGIN
  writeln('вводите массив');
  for i := 1 to MAX_SIZE do
  begin
    write(i,' :');readln(main[i]);
  end;
  
  Qsort(main,1,MAX_SIZE);
  
  print(main);
END.