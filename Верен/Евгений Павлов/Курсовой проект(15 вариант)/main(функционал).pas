uses
  FUNC_MOD,Data;

const
  input = 'input.txt';
  output = 'output.txt';
  sourceCount = 2; //количество источников

type
  matrix = array [1..sourceCount] of source;
 
var  
  masSource : matrix; //массив источников
  mainQueue: queue := new queue(); //буфер
  mainPerfomer: perfomer; //обработчик
  f: text; //файл для вывода
  sourceNumber : integer; //вспомогательная переменная - номер источника
  lambda : lamMas; //массив лямбд
  tau : real; //тау
  mainRepository : repository := new repository(); //хранилище данных
  i,j : integer; 
  Kmin : integer := 1000;
  flag :  integer := 1; 
  min : integer; //источник с минимальным временем нового запроса

function getMin() : integer; //возвращает номер источника с нимимальным времене заявки
var
  i : integer;
  minTime : integer := 1;
begin
  for i:= 2 to sourceCount do
  begin
    if (masSource[i].getNextClaimTime() < masSource[minTime].getNextClaimTime()) then
      minTime := i;
  end;
  getMin := minTime;
end;

procedure setClaims(var r : repository;var m : matrix;j : integer);  //заносит данные по колличуству выполненных,отказанных заявок в хранилище данных
var 
  i : integer;
begin
  for i := 1 to sourceCount do
  begin
    r.setClaim(i,j,m[i].getFailureCount(),m[i].getProcessedClaimCount(),m[i].getCurrentClaimNumber());
  end;
end;

begin
  assign(f,output);
  rewrite(f);
  tau := 0.1;
  lambda[1] := 2.0;
  lambda[2] := 4.0;
  i := 0; 
    for i:= 1 to 11 do
    begin 
      randomize;
      mainPerfomer := new perfomer(tau);  //инициализация обработчика
      for j := 1 to sourceCount do  //инициализация источников
      begin
        masSource[j] := new source(j,lambda[j]);
      end;
      min := getMin(); //находим номер источника с нимимальным времене заявки
      //masSource[min].incrementationProcessedClaim(); //увеличиваем количество выполненных заявок
      mainPerfomer.pushClaim(getClaim(masSource[min])); //заносим заявку в источник
      mainPerfomer.GenerateTimeRelease(masSource[min].getNextClaimTime()); //генерируем время освобождения
      masSource[min].generateNextClaim(); //генерируем время новой заявки
      writeln(f,'     отказы | обработанные | всего | вероятность отказа');
      while (true) do 
      begin
        if (mainQueue.isEmpty()) then //если буфер пуст заносим в нее заявку
        begin
          min := getMin();
          mainQueue.push(getClaim(masSource[min]));
          masSource[min].generateNextClaim();
        end;
        while ((masSource[1].getNextClaimTime < mainPerfomer.getTimeRelease()) or (masSource[2].getNextClaimTime < mainPerfomer.getTimeRelease())) do
        //пока время новых заявок меньше времени освобождения источника
        begin
          min := getMin();
          if (mainQueue.isBusy) then //отказываем заявкам так как буфер занят
          begin
            masSource[min].generateNextClaim();
            masSource[min].incrementationFailure();
          end else //заносим заявку в очередь
          begin
            mainQueue.push(getClaim(masSource[min]));
            masSource[min].generateNextClaim();
          end;
        end;
        mainQueue.correcting(mainPerfomer); //корректируем время освобождения заявок в буфере
        if (mainPerfomer.getTimeRelease <= mainQueue.get().getNextClaimTime()) then 
        //если время освобождения источника меньше чем время генерации новой заявки
        begin
          sourceNumber := mainPerfomer.release(); //номер источника, чью заявку обработал обработчик
          // и одновременно освобождение обаботчика
          if (sourceNumber <> 0) then
          begin
            //Sleep(15);
            masSource[sourceNumber].incrementationProcessedClaim();
            mainPerfomer.GenerateTimeRelease(mainQueue.get().getNextClaimTime());
            mainPerfomer.pushClaim(getClaim(mainQueue.get()));
            mainQueue.pop();
          end;
        end;
      if (masSource[1].getCurrentClaimNumber() > Kmin) and (masSource[2].getCurrentClaimNumber() > Kmin) then //Kmin задать пользователем
      begin
        tau := tau + 0.1; //пока каждый источник не подал Kmin заявок
        break;
      end;
      end; //end of main cycle
      while not (mainQueue.isEmpty()) do
      begin
        sourceNumber := mainQueue.get().getSourceNumber();
        mainQueue.pop();
        masSource[sourceNumber].incrementationFailure();
      end;
      for j:=1 to sourceCount do //вывод
      begin
        writeln(f,'#',j,' ',masSource[j].getFailureCount() : 8,' ',masSource[j].getProcessedClaimCount(): 10,' ',masSource[j].getCurrentClaimNumber(): 10,' ',
                     masSource[j].getFailureCount()/masSource[j].getCurrentClaimNumber(): 7 : 3);
      end;
      writeln(f,'среднее время ожидания');
      writeln(f,'буфер 1 ',mainQueue.getMiddleCount(1));
      writeln(f,'буфер 2 ',mainQueue.getMiddleCount(2));
      writeln(f);
      
      setClaims(mainRepository,masSource,i);//заносим данные в хранилище
      mainrepository.setCount(1,i,mainQueue.getMiddleCount(1));
      mainrepository.setCount(2,i,mainQueue.getMiddleCount(2));
      mainQueue.nulling();
    end;
  close(f);
end.