//*
//Задание анологично 3ему и реализованно так же, за одним лишь исключением все типы, константы и процедуры вынесены в модуль
//*/
uses RecordUnit;
  
VAR
  mas : stringMas;//рабочий массив
  i : integer; //счетчики
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