const
  input = 'in1.txt'; //��� �������� �����
  output = 'out1.txt'; //��� ��������� �����
  NUMBER_OF_STRING = 10; //���������� ����
  NUMBER_OF_SYMBOL = 10; //���������� �������� � ������

type
  list = ^Linked; //����������� ���������� ����������������� ������ list-��������� �� ������ Linked
  Linked = record //������ Linked 
    inf : string[NUMBER_OF_SYMBOL]; //���� ������
    count : integer; //���� ��������(�� �������)
    next : list; //���� ��������� �� ��������� �������
  end;
  
function createList(s : string) : list; //������� ��������� ������ �� ������ ����� � ������ s � ������������ ��������� �� ������ ������ 
var
  f : text; //�������� ����������
  temp : list := nil; //��������� ���������� - ��������� �� Linked
begin
  assign(f,s); //��������� �������� ���������� � ������ �� �����
  reset(f); //��������� ��� ������
    if (not(eof(f))) then //���� ���� �� ����
    begin
      new(temp); //�������� ����� � ������
      readln(f,temp^.inf); //��������� ���� ������
      temp^.count :=0; //�������� �������
      temp^.next := nil; //��������� ������ �� ������ ����� �� ����������
    end;
    createList := temp; //������ �������, ��� ����� ����������(��������� �� ������ �������, ���� nil, ���� ���� ����
    while(not(eof(f))) do //���� �� ����� �����
    begin
      new(temp^.next); //������� ����� ��� ���������� ��������
      temp := temp^.next; //������ ��������� �� ����� �������
      readln(f,temp^.inf); //��������� ��� ���� ����������
      temp^.count :=0; //�������� �������
      temp^.next := nil; //��������� ������ �� ������ ����� �� ����������
    end;
    //� ����� ���� next 10��� �������� ������ ����� ����� nil, ��� �������� ����� ������
  close(f);
end;

procedure printList(s : string; l : list); //������ ������
var
  f : text;
begin
  assign(f,s); //���������� ���������� ������� ������
  rewrite(f);
    while l <> nil do //���� �� ����� ������
    begin
      writeln(f,l^.inf,' ',l^.Count); //l^ - ������������� (����, ���� ���������� ��������)
      l := l^.next; //�� ����������� ����, ��� ������ �� ������ ����������������� �������� ��������� � ���������� �������� � ������
    end;
  close(f);
end;

procedure countList(l : list); //������������ ����������� ���� count ��� ������� ��������
var
  i : integer;
  ch : char;
begin
  while l <> nil do //���� �� ����� ������
  begin
    ch :=  l^.inf[1]; //��������� �������� ��������
    for i := 1 to NUMBER_OF_SYMBOL do
    begin
      if (upCase(ch) = upCase(l^.inf[i])) then
          l^.count := l^.count + 1;
    end;
    l := l^.next;
  end;
end;

VAR
  main : list := nil;

BEGIN
  main := createList(input); //������� ������
 
  countList(main); //������������ ���� count
  
  printList(output,main); //������� ������
END.