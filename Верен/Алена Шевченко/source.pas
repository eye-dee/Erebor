type
  list = ^LiList;
  Lilist = record
    inf: char;
    next: list;
  end;
  
  stack = ^St;
  St = record
    inf: char;
    next: stack;
  end;

 // operandSet = set of 'A' .. 'Z';
 // operatorSer = set ['a','o','n'];

const
  input = 'input.txt';
  output = 'output.txt';
  
  operand = ['A'.. 'Z'];
  operat = ['a', 'o', 'n'];

procedure pushStack(var top: stack; value: char);
var
  temp: stack;
begin
  new(temp);
  temp^.next := top;
  temp^.inf := value;
  top := temp;
end;

procedure popStack(var top: stack);
begin
  top := top^.next;
end;

procedure pushBack(var en: list; value: char);
begin
  new(en^.next);
  en := en^.next;
  en^.next := nil;
  en^.inf := value;
end;

procedure create(s: string; var l: list);
var
  f: text;
  temp: list;
begin
  assign(f, s);
  reset(f);
  new(l);
  temp := l;
  l^.next := nil;
  
  while (not (eof(f))) do
  begin
    new(temp^.next);
    temp := temp^.next;
    read(f, temp^.inf);
    temp^.next := nil;
  end;
  
  close(f);
end;

function getPriority(ch: char): integer;
begin
  if not (ch in operat) then
    writeln('в функцию getPriority был передан неизвестный оператор')
  else
  begin
    case(ch) of 
      'o': getPriority := 1;
      'a': getPriority := 2;
      'n': getPriority := 3;
    end;
  end;
end;

procedure writer(s: string; cur: list);
var
  f: text;
begin
  assign(f, s);
  append(f);
  
  if (cur = nil) then
    exit;
  
  cur := cur^.next;
  
  writeln(f, 'write list');
  
  while cur <> nil do
  begin
    write(f, cur^.inf);
    cur := cur^.next;
  end;
  
  writeln(f);
  
  close(f);
end;

procedure makePre(infics: list; var pre: list);
var
  s: stack;
  temp: list;
begin
  new(pre);
  pre^.next := nil;
  temp := pre;
  
  infics := infics^.next;
  
  while infics <> nil do
  begin
    if (infics^.inf in operand) then
    begin
      pushBack(temp, infics^.inf);
    end else if (infics^.inf = '(') then
    begin
      pushStack(s, infics^.inf);
    end else if (infics^.inf = ')') then
    begin
      while s^.inf <> '(' do
      begin
        pushBack(temp, s^.inf);
        s := s^.next;
      end;
      if (s^.inf = '(') then
        s := s^.next;
    end else if (infics^.inf in operat) then
    begin
      if (s <> nil) then
        if (s^.inf in operat) then
          if (getPriority(infics^.inf) <= getPriority(s^.inf)) then
          begin
            while (s^.inf in operat) do
            begin
              pushBack(temp, s^.inf);
              s := s^.next;
              if (s = nil) then
                break;
            end;
          end;
      pushStack(s, infics^.inf);
    end;
    infics := infics^.next;
  end;
  while (s <> nil) do
  begin
    pushBack(temp, s^.inf);
    s := s^.next;    
  end;
end;

function check(l: list): boolean;
var
  s: stack;
  temp: list;
begin
  check := true;
  temp := l^.next;
  
  while (temp <> nil) do
  begin
    if (temp^.inf = '(') then
      pushStack(s, temp^.inf);
    if (temp^.inf = ')') then
      if (s = nil) then
      begin
        check := false;
        exit;
      end else
        s := s^.next;
    
    temp := temp^.next;
  end;
  
  if (s <> nil) then
  begin
    check := false;
    exit;
  end;
  
  temp := l^.next;
  
  while temp <> nil do
  begin
    if (temp^.inf = '(') then
    begin
      if (temp^.next = nil) then
      begin
        check := false;
        exit;
      end;
      if (temp^.next^.inf in operat) and (temp^.next^.inf <> 'n')  then
      begin
        check := false;
        exit;
      end;
    end;
    
    if (temp^.inf in operand) then
    begin
      if (temp^.next = nil) then
      begin
        exit;
      end;
      if (temp^.next^.inf in operand) then
      begin
        check := false;
        exit;
      end;
    end;
    
    if (temp^.inf in operat) then
    begin
      if (temp^.next = nil) then
      begin
        check := false;
        exit;
      end;
      if (temp^.next^.inf in operat) and (temp^.next^.inf <> 'n') then
      begin
        check := false;
        exit;
      end;
    end;
    
    temp := temp^.next;
  end;
  
end;

VAR
  main, res: list;
  f: text;

BEGIN
  assign(f, output);
  rewrite(f);
  close(f);
  
  create(input, main);
  
  writer(output, main);
  
  if (check(main)) then
    makePre(main, res);
  
  writer(output, res);
  
END.