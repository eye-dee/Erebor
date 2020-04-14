const
  input = 'in1.txt'; //имя входного файла
  output = 'out1.txt'; //имя выходного файла
  NUMBER_OF_STRING = 10; //количество слов
  NUMBER_OF_SYMBOL = 10; //количество символов в строке

type
  list = ^Linked; //определение связанного однонаправленного списка list-указатель на запись Linked
  Linked = record //запись Linked 
    inf : string[NUMBER_OF_SYMBOL]; //поле строки
    count : integer; //поле счетчика(см условие)
    next : list; //поле указателя на следующий элемент
  end;
  
function createList(s : string) : list; //функция создающая список на основе файла с именем s и возвращающая указатель на начало списка 
var
  f : text; //файловая переменная
  temp : list := nil; //временная переменная - указатель на Linked
begin
  assign(f,s); //связываем файловую переменную с файлом на диске
  reset(f); //открываем для чтения
    if (not(eof(f))) then //если файл не пуст
    begin
      new(temp); //выделяем место в памяти
      readln(f,temp^.inf); //считываем туда строку
      temp^.count :=0; //обнуляем счетчик
      temp^.next := nil; //следующий элмент на данном этапе не существует
    end;
    createList := temp; //укажем функции, что нужно возвращать(указатель на первый элемент, либо nil, если файл пуст
    while(not(eof(f))) do //пока не конец файла
    begin
      new(temp^.next); //выделем место для слудующего элемента
      temp := temp^.next; //ставим указатель на новый элемент
      readln(f,temp^.inf); //считываем для него информацию
      temp^.count :=0; //обнуляем счетчик
      temp^.next := nil; //следующий элмент на данном этапе не существует
    end;
    //в конце поле next 10ого элемента списка будет равно nil, что означает конец списка
  close(f);
end;

procedure printList(s : string; l : list); //печать списка
var
  f : text;
begin
  assign(f,s); //анологично предыдущим печатям списка
  rewrite(f);
    while l <> nil do //пока не конец списка
    begin
      writeln(f,l^.inf,' ',l^.Count); //l^ - разыменование (гугл, если неизвестна операция)
      l := l^.next; //за исключением того, что теперь мы вместо инкрементирования счетчика переходим к следующему элементу в списке
    end;
  close(f);
end;

procedure countList(l : list); //установление корректного поля count для каждого элемента
var
  i : integer;
  ch : char;
begin
  while l <> nil do //пока не конец списка
  begin
    ch :=  l^.inf[1]; //применяем знакомый алгоритм
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
  main := createList(input); //создаем список
 
  countList(main); //корректируем поле count
  
  printList(output,main); //выводим список
END.