//*
//������� ���������� 3��� � ������������ ��� ��, �� ����� ���� ����������� ��� ����, ��������� � ��������� �������� � ������
//*/
uses RecordUnit;
  
VAR
  mas : stringMas;//������� ������
  i : integer; //��������
  fType : stringRecordFile;

BEGIN

  makeTypeFileFromText(input,outputType);
  
  assign(fType,outputType);
  reset(fType);
    for i := 1 to NUMBER_OF_STRING do
      read(fType,mas[i]);
  close(fType);
  
  writeStringMas(output,mas);
END.