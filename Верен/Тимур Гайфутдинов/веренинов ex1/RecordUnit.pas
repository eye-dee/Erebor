Unit RecordUnit; //������ RecordUnit
interface //����� ������� ��������� ������,  �� ���� ��� ��������� ���� � ���������� ��������
const
  input = 'in1.txt'; //��� �������� �����
  output = 'out1.txt'; //��� ��������� �����
  outputType = 'out1(type).txt';
  NUMBER_OF_STRING = 10; //���������� ����
  NUMBER_OF_SYMBOL = 10; //���������� �������� � ������
  
type
  stringRecord = record
    inf : string[NUMBER_OF_SYMBOL];
    count : integer;
  end;
  stringMas = array [1..NUMBER_OF_STRING] of stringRecord;
  
  stringRecordFile = file of stringRecord;
  
///
procedure writeStringMas(s : string;var a : stringMas);
procedure makeTypeFileFromText(inp,ou : string);
///

implementation //����� ������� ����������� ���� ��������

procedure makeTypeFileFromText(inp,ou : string);
var
  temp : stringRecord;
  f : text;
  fout : stringRecordFile;
  i,j : integer;
  ch : char;
begin
  assign(f,inp);
  assign(fout,ou);
  reset(f);
  rewrite(fout);
    for i := 1 to NUMBER_OF_STRING do
    begin
      readln(f,temp.inf);
      ch := temp.inf[1];
      temp.count := 0;
      for j := 1 to NUMBER_OF_SYMBOL do
      begin
        if (upCase(ch) = upCase(temp.inf[j])) then
          temp.count := temp.count + 1;
      end;
      write(fout,temp);
    end;
  close(f);
  close(fout);
end;

procedure writeStringMas(s : string;var a : stringMas);
var
  f : text;
  i : integer;
begin
  assign(f,s);
  rewrite(f);
    for i := 1 to NUMBER_OF_STRING do
      writeln(f,a[i].inf,' ',a[i].count);
  close(f);
end;


BEGIN
END.