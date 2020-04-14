const
  input = 'input.txt';
  output = 'output.txt';
  
type
  list = ^LinkedList1;
  LinkedList1 = record
    inf : char;
    next : list;
  end;
  
function create(s : string) :list;
var
  f : text;
  temp : list;
begin
  assign(f,s);
  reset(f);
  new(temp);
  create := temp;
  new(temp^.next);
  temp := temp^.next;
  temp^.next := nil;
  temp^.inf := '(';
  while not(eof(f)) do
  begin
    new(temp^.next);
    temp := temp^.next;
    read(f,temp^.inf);
    temp^.next := nil;
  end;
  
  new(temp^.next);
  temp := temp^.next;
  temp^.inf := ')';
  temp^.next := nil;
  
  close(f);
end;

procedure writeList(s : string;cur : list);
var
  f : text;
begin
  assign(f,s);
  rewrite(f);
  
  cur := cur^.next;
  
  while cur <> nil do
  begin
    write(f,cur^.inf);
    cur := cur^.next;
  end;
  
  close(f);
end;
 
function isCorrect(start,finish : list) : boolean;
var
  temp,tempStart,tempEnd : list;
  count : integer;
begin
    isCorrect := true;
    temp := start;
    tempStart := temp;
    tempEnd := finish;
    while (temp <> finish^.next) do
    begin
      if (temp^.inf = '(') then
      begin
        inc(Count);
        tempStart := temp;
      end else if (temp^.inf = ')') then
      begin
        dec(count);
        tempEnd := temp;
      end;
      temp := temp^.next;
    end;
    if (count <> 0) then
    begin
      writeln('скобок разное количество');
      isCorrect := false;
      exit;
    end;
    if (tempStart <> start) and (tempEnd <> finish) then
    begin
      if(not(isCorrect(tempStart,tempEnd))) then
      begin
        isCorrect := false;
        exit;
      end;
    end;
    while (start^.next^.next <> finish) do
    begin
      if (start^.next^.inf in ['1'..'9']) and (start^.next^.next^.inf in ['1'..'9']) then
      begin
        writeln('две цифры подряд');
        isCorrect := false;
        exit;
      end else if ((start^.next^.inf in ['a'..'z']) and (start^.next^.next^.inf in ['a'..'z'])) then
      begin
        writeln('две переменные подряд');
        isCorrect := false;
        exit;
      end else if ((start^.next^.inf in ['+','*','-','/']) and (start^.next^.next^.inf in ['+','*','-','/',')'])) then
      begin
        writeln('два знака подряд');
        isCorrect := false;
        exit;
      end else if ((start^.next^.inf in [')']) and not(start^.next^.next^.inf in ['+','*','-','/',')'])) then
      begin
        writeln('после скобки какое то говно');
        isCorrect := false;
        exit;
      end else
      begin
        start := start^.next;
      end;
    end;
end;

var
  main,temp : list;
  f : text;
  
BEGIN
  main := create(input);
  
  writeList(output,main);
  
  temp := main;
  while( temp^.next <> nil) do
    temp := temp^.next;
  
  writeln(isCorrect(main^.next,temp));
  
END.