uses
  QueueUnit, SourceUnit, PerfomerUnit,Data;

const
  input = 'input.txt';
  output = 'output.txt';
  sourceCount = 2;

type
  matrix = array [1..sourceCount] of source;
 
var  
  masSource : matrix;
  mainQueue: queue := new queue();
  mainPerfomer: perfomer;
  Time: integer;
  inp,f: text;
  sourceNumber : integer;
  lambda : real;
  tau : integer;
  mainRepository : repository := new repository();
  i,j : integer;
  Kmin : integer;
  flag :  integer;
  min : integer; //источник с минимальным временем нового запроса

function getMin() : integer;
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

procedure setClaims(var r : repository;var m : matrix;j : integer);
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
  writeln(f,'отказы | обработанные | всего | вероятность отказа | среднее время ожидания');
  assign(inp,input);
  reset(inp);
  lambda := 2;
  i := 0;
  
  readln(inp,Kmin);

  //InitGraph();
  //DataInputing(Kmin,flag);
  //drawAxesSystem(); 
  while (lambda < 4.005) do
  begin 
    mainPerfomer := new perfomer(lambda);
    masSource[1] := new source(1,2);
    masSource[2] := new source(2,4);
    min := getMin();
    mainPerfomer := new perfomer(lambda);
    masSource[min].incrementationProcessedClaim();
    mainPerfomer.GenerateTimeRelease(masSource[min].getNextClaimTime());
    mainPerfomer.pushClaim(getClaim(masSource[min]));
    masSource[min].generateNextClaim();
    i := i+1;
    //changeColor(i);
    randomize;
    Time := 0;
    assign(f, output);
    rewrite(f);
    while (true) do
    begin
      if (mainQueue.isEmpty()) then
      begin
        min := getMin();
        mainQueue.push(getClaim(masSource[min]));
        masSource[min].generateNextClaim();
      end;
      while ((masSource[1].getNextClaimTime < mainPerfomer.getTimeRelease()) or 
             (masSource[2].getNextClaimTime < mainPerfomer.getTimeRelease())) do
      begin
        min := getMin();
        if (mainQueue.isBusy) then
        begin
          masSource[min].generateNextClaim();
          masSource[min].incrementationFailure();
        end else
        begin
          mainQueue.push(getClaim(masSource[min]));
          masSource[min].generateNextClaim();
        end;
      end;
      mainQueue.correcting(mainPerfomer);
      if (mainPerfomer.getTimeRelease <= mainQueue.get().getNextClaimTime()) then
      begin
        sourceNumber := mainPerfomer.release();
        if (sourceNumber <> 0) then
        begin
          //draw(masSource[flag].getCurrentClaimNumber(),masSource[flag].getFailureCount());
          //sleep(5);
          masSource[sourceNumber].incrementationProcessedClaim();
          mainPerfomer.GenerateTimeRelease(mainQueue.get().getNextClaimTime());
          mainPerfomer.pushClaim(getClaim(mainQueue.get()));
          mainQueue.Calculate();
          mainQueue.pop();
        end;
      end;
    if ((masSource[1].getCurrentClaimNumber() > Kmin) and (masSource[2].getCurrentClaimNumber() > Kmin))  then //Kmin задать пользователем
    begin
      lambda := lambda + 0.2;
      break;
    end;
    end; //end of main cycle
    while not (mainQueue.isEmpty()) do
    begin
      sourceNumber := mainQueue.get().getSourceNumber();
      mainQueue.Calculate();
      mainQueue.pop();
      masSource[sourceNumber].incrementationFailure();
    end;
    //sleep(500);
    setClaims(mainRepository,masSource,i);
    mainrepository.setCount(i,mainQueue.getMiddleCount()*mainPerfomer.getTimeRelease()/mainQueue.getSumCount());
    writeln(f,'#1 ',masSource[1].getFailureCount,' ',masSource[1].getProcessedClaimCount(),' ',masSource[1].getCurrentClaimNumber(),' ',
                   masSource[1].getFailureCount()/masSource[1].getCurrentClaimNumber(), ' ',mainRepository.getterCount(i));
    writeln(f,'#2 ',masSource[2].getFailureCount,' ',masSource[2].getProcessedClaimCount(),' ',masSource[2].getCurrentClaimNumber(),' ',
                   masSource[2].getFailureCount()/masSource[2].getCurrentClaimNumber());
    mainQueue.nulling();
  end;
  
  close(inp);
  close(f);
  //main(mainRepository);
  
end.