const
  input = 'in1.txt'; //��� �������� �����
  output = 'out1.txt'; //��� ��������� �����
  NUMBER_OF_STRING = 10; //���������� ����
  NUMBER_OF_SYMBOL = 10; //���������� �������� � ������
  
VAR
  mas : array [1..NUMBER_OF_STRING,1..NUMBER_OF_SYMBOL] of char; //������� ������
  i,j : integer; //��������
  f : text; //�������� ����������
  ch : char; //�������������� ����������
  count : integer; //���������� ���������, ������� ��� ����������� ������ � ������ ������

BEGIN
  assign(f,input); //��������� �������� ���������� � ������ �� �����
  reset(f); //��������� ���� ��� ������
    for i := 1 to NUMBER_OF_STRING do //��� ������ �������
    begin
      for j := 1 to NUMBER_OF_SYMBOL do //��� ������� �������
        read(f,mas[i,j]); //��������� � �������� ������
      readln(f); //��������� �� ��������� �������
    end;
  close(f); //��������� ������� ����
  
  assign(f,output); //��������� �������� ���������� � ������ �� �����
  rewrite(f,output); //��������� ��� ������ ������ ��� ����������
    writeln(f,'�����      ���-�� ���������');
    for i := 1 to NUMBER_OF_STRING do //��� ������ �������
    begin
      ch := mas[i,1]; //����� ������ ������
      count := 0; //������� ������������� �������� = 0
      for j := 1 to NUMBER_OF_SYMBOL do //��� ������� ������� � ������� ������
      begin
        if (upCase(ch) = upCase(mas[i,j])) then //���������� ������ � �������� ch ��� ����������� �� �������� �����
          //(��������� ��� � �������
          count := count + 1; //��������� �������, ���� �����
        write(f,mas[i,j]); //����� ������� ������ ������
      end;
      writeln(f,' ',count); //� ����� ������ ��������� ���������
    end;
  close(f); //��������� ����
END.