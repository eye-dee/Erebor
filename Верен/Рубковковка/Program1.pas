const
  input = 'input.txt';
  output = 'output.txt';

type
  list = ^Linked;
  Linked = record
    inf : integer;
    next : list;
  end;
  
procedure create(s : string; var a :list);
var
  f :text;
  temp : list;
begin
  assign(f,s);
  reset(f);
  
  new(a);
  temp := a;
  
  {if (not(EOF(f)) then
    read(a^.inf);}
  
  while (not(EOF(f))) do
  begin
    new(temp^.next);
    temp := temp^.next;
    read(f,temp^.inf);
  end;
  
  close(f);
  
end;

procedure print(s : string;t : list);
var
  f : text;
begin
  assign(f,s);
  rewrite(f);
  
  t := t^.next;
  
  while t <> nil do
  begin
    write(f,t^.inf, ' ');
    t := t^.next;
  end;
  
  close(f);
end;
  
VAR
  main : list;

BEGIN
  create(input,main);
  
  print(output,main);
END.