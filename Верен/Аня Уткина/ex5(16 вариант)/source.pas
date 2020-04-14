const
  input = 'input.txt';
  output = 'output.txt';

type
  tree = ^treeString;
  treeString = record
    inf : string;
    left : tree;
    right : tree;
  end;
  
procedure create(s : string; var root : tree);
var
  f : text;
  temp : string;
  tempTree : tree;
begin
  assign(f,s);
  reset(f);
  
  new(root);
  readln(f,temp);
  root^.inf := temp;
  root^.left := nil;
  root^.right := nil;
  
  while not(eof(f)) do
  begin
    readln(f,temp);
    tempTree := root;
    while(true) do
    begin  
      if (temp > tempTree^.inf) then
      begin
        if (tempTree^.right = nil) then
        begin
          new(tempTree^.right);
          tempTree := tempTree^.right;
          tempTree^.right := nil;
          tempTree^.left := nil;
          tempTree^.inf := temp;
          break;
        end;
        tempTree := tempTree^.right;
      end else
      begin
        if (tempTree^.left = nil) then
        begin
          new(tempTree^.left);
          tempTree := tempTree^.left;
          tempTree^.right := nil;
          tempTree^.left := nil;
          tempTree^.inf := temp;
          break;
        end;        
        tempTree := tempTree^.left;
      end;
    end;
  end;
  
  close(f);
  
end;

procedure writer(var f: text; cur : tree);
begin
  writeln(f,cur^.inf);
  if (cur^.left <> nil) then
    writer(f,cur^.left);
  if (cur^.right <> nil) then
    writer(f,cur^.right);
end;

procedure writerTree(s : string; root : tree);
var
  f : text;
begin
  assign(f,s);
  rewrite(f);
  
  writer(f,root);
  
  close(f);
end;

procedure counterDist(var f : text;cur : tree; count : integer);
begin
  if (cur^.left <> nil) then
    counterDist(f,cur^.left,count+1);
  if (cur^.right <> nil) then
    counterDist(f,cur^.right,count+1);
  if (cur^.left = nil) and (cur^.right = nil) then
    writeln(f,count);
end;

procedure counterDist(s : string;root : tree);
var
  f : text;
begin
  assign(f,s);
  append(f);
  
  writeln(f,'///////////////');
  
  counterDist(f,root,0);
  
  close(f);
end;

var
  main : tree;

BEGIN
  create(input,main);
  
  writerTree(output,main);
  
  counterDist(output,main);
  
END.