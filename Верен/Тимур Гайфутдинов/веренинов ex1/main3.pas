const
  input = 'in1.txt'; //имя входного файла
  output = 'out1.txt'; //имя выходного файла
  outputType = 'out1(type).txt'; //имя выходного типизированного файла
  NUMBER_OF_STRING = 10; //количество слов
  NUMBER_OF_SYMBOL = 10; //количество символов в строке

type
  stringRecord = record //запись stringRecord
    inf : string[NUMBER_OF_SYMBOL]; //поле информации
    count : integer; //поле счетчика (см условие)
  end;
  stringMas = array [1..NUMBER_OF_STRING] of stringRecord; //массив записей
  
  stringRecordFile = file of stringRecord; //типизированный файл

procedure makeTypeFileFromText(inp,ou : string); //процедура создающая типизированный с именем ou файл на основе исходного с именем inp
var
  temp : stringRecord; //временная переменная
  f : text; //файловая переменная
  fout : stringRecordFile; //типизированная файловая переменная
  i,j : integer; //счетчики
  ch : char; //вспомогательная переенная
begin
  assign(f,inp); //связываем файловую переменную с файлом на диске
  assign(fout,ou); //связываем типизированную файловую переменную с файлом на диске
  reset(f); //открываем для чтения
  rewrite(fout); //открываем для записи стерев все предыдущее
    for i := 1 to NUMBER_OF_STRING do //для каждой строчки файла
    begin
      readln(f,temp.inf); //считать из файла текущую запись
      ch := temp.inf[1]; //далее алгоритм анологичный первому заданию подсчитывающий количество совпадений первого символа
      temp.count := 0;
      for j := 1 to NUMBER_OF_SYMBOL do
      begin
        if (upCase(ch) = upCase(temp.inf[j])) then
          temp.count := temp.count + 1;
      end;
      write(fout,temp);
    end;
  close(f); //закрыть файл
  close(fout); //закрыть файл
end;

procedure writeStringMas(s : string;var a : stringMas); //печать массива записей в файл с именем s
var
  f : text; //файловая переменная
  i : integer; //счетчик
begin
  assign(f,s); //связываем файловую переменную с файлом на диске
  rewrite(f); //открываем для записи стерев всю предыдущую информацию
    for i := 1 to NUMBER_OF_STRING do //для каждого элемента массива вывести информацию в файл
      writeln(f,a[i].inf,' ',a[i].count);
  close(f); //закрыть файл
end;
  
VAR
  mas : stringMas;//рабочий массив
  i,j : integer; //счетчики
  fType : stringRecordFile; //типизированная файловая переменная

BEGIN

  makeTypeFileFromText(input,outputType); //сделать тип файл из обыного
  
  assign(fType,outputType); // открыть типизированный файл и считать оттуда информацию
  reset(fType);
    for i := 1 to NUMBER_OF_STRING do
      read(fType,mas[i]);
  close(fType);
  
  writeStringMas(output,mas); //вывести инфомарцию
END.