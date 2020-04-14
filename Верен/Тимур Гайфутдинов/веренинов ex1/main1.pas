const
  input = 'in1.txt'; //имя входного файла
  output = 'out1.txt'; //имя выходного файла
  NUMBER_OF_STRING = 10; //количество слов
  NUMBER_OF_SYMBOL = 10; //количество символов в строке
  
VAR
  mas : array [1..NUMBER_OF_STRING,1..NUMBER_OF_SYMBOL] of char; //рабочий массив
  i,j : integer; //счетчики
  f : text; //файловая переменная
  ch : char; //дополнительная переменная
  count : integer; //переменная считающая, сколько раз повторяется символ в первой строке

BEGIN
  assign(f,input); //связываем файловую переменную с файлом на диске
  reset(f); //открываем файл для чтения
    for i := 1 to NUMBER_OF_STRING do //для каждой строчки
    begin
      for j := 1 to NUMBER_OF_SYMBOL do //для каждого символа
        read(f,mas[i,j]); //считываем в основной массив
      readln(f); //переходим на следующую строчку
    end;
  close(f); //закрываем входной файл
  
  assign(f,output); //связываем файловую переменную с файлом на диске
  rewrite(f,output); //открываем для записи стерев все предыдущее
    writeln(f,'Слова      кол-во вхождений');
    for i := 1 to NUMBER_OF_STRING do //для каждой строчки
    begin
      ch := mas[i,1]; //берем первый символ
      count := 0; //счетчик повторяющихся символов = 0
      for j := 1 to NUMBER_OF_SYMBOL do //для каждого символа в текущей строке
      begin
        if (upCase(ch) = upCase(mas[i,j])) then //сравниваем символ с исходным ch вне зависимости от регистра буквы
          //(переводим все в верхний
          count := count + 1; //прибаляем счетчик, если нужно
        write(f,mas[i,j]); //сразу выводим каждый символ
      end;
      writeln(f,' ',count); //в конце строки вставляем результат
    end;
  close(f); //закрываем файл
END.