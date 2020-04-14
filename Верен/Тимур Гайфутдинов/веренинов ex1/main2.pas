const
  input = 'in1.txt'; //��� �������� �����
  output = 'out1.txt'; //��� ��������� �����
  NUMBER_OF_STRING = 10; //���������� ����
  NUMBER_OF_SYMBOL = 10; //���������� �������� � ������

type
  stringMas = array [1..NUMBER_OF_STRING] of string[NUMBER_OF_SYMBOL]; //���������� �������� ������� 
procedure readMas(s : string; var a : stringMas); //��������� ���������� ������� �� ����� � ������ s
var
  i : integer; //�������
  f : text; //�������� ����������
begin
  assign(f,s); //��������� �������� ���������� � ������ �� �����
  reset(f); //��������� ��� ������
  for i := 1 to NUMBER_OF_STRING do //��� ������ ������ � �����
    readln(f,a[i]); //��������� � ������ ������ �������
  close(f); //��������� ����
end;
  
VAR
  mas : stringMas;//������� ������
  i,j : integer; //��������
  f : text; //�������� ����������
  ch : char; //�������������� ����������
  count : integer; //���������� ���������, ������� ��� ����������� ������ � ������ ������

BEGIN
  readMas(input,mas); //��������� ��������� ����������
  
  assign(f,output); //��������� �������� ���������� � ������ �� �����
  rewrite(f,output); //��������� ��� ������ ������ ��� ���������e
    writeln(f,'�����      ���-�� ���������');
    for i := 1 to NUMBER_OF_STRING do //��� ������ ������ �������
    begin
      ch := mas[i][1]; //����� ������ ������
      count := 0; //����� ���������� ������ ���������
      for j := 1 to NUMBER_OF_SYMBOL do
      begin
        if (upCase(ch) = upCase(mas[i][j])) then
          count := count + 1;
        write(f,mas[i][j]);
      end;
      writeln(f,' ',count);
    end;
  close(f);
END.