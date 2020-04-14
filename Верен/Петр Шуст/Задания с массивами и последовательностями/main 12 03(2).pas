VAR
  i : integer;
  temp : integer;
  
BEGIN
  for i := 20 to 30 do
  begin
    temp := i;
    while temp <> 1 do
    begin
      if (temp mod 2 = 0) then
        temp := temp div 2
      else
        temp := (temp*3 + 1) div 2;
    end;
    writeln('гипотеза Сиракуз работает для числа ',i);
  end;
END.