//*
//Программа идентична 3ей за исключением организации одного цикла
//рядом с которым будут комментарии
//*/
const
  input = 'in1.txt'; //имя входного файла
  output = 'out1.txt'; //имя выходного файла
  outputType = 'out1(type).txt';
  NUMBER_OF_STRING = 10; //количество слов
  NUMBER_OF_SYMBOL = 10; //количество символов в строке

type
  stringRecord = record
    inf : string[NUMBER_OF_SYMBOL];
    count : integer;
  end;
  stringMas = array [1..NUMBER_OF_STRING] of stringRecord;
  
  stringRecordFile = file of stringRecord;

procedure makeLoop(var fout : stringRecordFile;var f : text; i : integer); //цикл через рекурсию
var
  j : integer;
  ch : char;
  temp : stringRecord;
begin
  if (i <= NUMBER_OF_STRING) then //различие лишь в способе управления, если i > NUMBER_OF_STRING выходим из цикла
  begin
    readln(f,temp.inf); //иначе считываем и выполняем знакомый алгоритм подсчета
    ch := temp.inf[1];
    temp.count := 0;
    for j := 1 to NUMBER_OF_SYMBOL do
    begin
      if (upCase(ch) = upCase(temp.inf[j])) then
        temp.count := temp.count + 1;
    end;
    write(fout,temp);
    makeLoop(fout,f,i+1); //рекурсивно вызываем себя же(ту же процедуру в которой находимся), изменяя при этом управлюущую переменную i
  end;
end;

procedure makeTypeFileFromText(inp,ou : string);
var
  f : text;
  fout : stringRecordFile;
begin
  assign(f,inp);
  assign(fout,ou);
  reset(f);
  rewrite(fout);
    makeLoop(fout,f,1);
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