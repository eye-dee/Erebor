const
  input = 'in1.txt'; //имя входного файла
  output = 'out1.txt'; //имя выходного файла
  NUMBER_OF_STRING = 10; //количество слов
  NUMBER_OF_SYMBOL = 10; //количество символов в строке

type
  stringMas = array [1..NUMBER_OF_STRING] of string[NUMBER_OF_SYMBOL]; //объявление рабочего массива 
procedure readMas(s : string; var a : stringMas); //процедура считывания массива из файла с именем s
var
  i : integer; //счетчик
  f : text; //файловая переменная
begin
  assign(f,s); //связываем файловую переменную с файлом на диске
  reset(f); //открываем для чтения
  for i := 1 to NUMBER_OF_STRING do //для каждой строки в файле
    readln(f,a[i]); //считываем в каждую строку массива
  close(f); //закрываем файл
end;
  
VAR
  mas : stringMas;//рабочий массив
  i,j : integer; //счетчики
  f : text; //файловая переменная
  ch : char; //дополнительная переменная
  count : integer; //переменная считающая, сколько раз повторяется символ в первой строке

BEGIN
  readMas(input,mas); //запускаем процедуру считывания
  
  assign(f,output); //связываем файловую переменную с файлом на диске
  rewrite(f,output); //открываем для записи стерев все предыдущеe
    writeln(f,'Слова      кол-во вхождений');
    for i := 1 to NUMBER_OF_STRING do //для каждой строки массива
    begin
      ch := mas[i][1]; //берем первый символ
      count := 0; //далее анологично первой программе
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