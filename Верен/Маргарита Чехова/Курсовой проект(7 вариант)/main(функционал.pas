uses
  QueueUnit, SourceUnit, PerfomerUnit,Data,Canvas;

const
  input = 'input.txt';
  output = 'output.txt';
  sourceCount = 3;

type
  matrix = array [1..sourceCount] of source;
 
var  
  masSource : matrix;
  mainQueue: queue := new queue();
  mainPerfomer: perfomer;
  Time: integer;
  f: text;
  inp : text;
  sourceNumber : integer;
  lambda : real;
  tau : real;
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
  assign(inp,input);
  reset(inp);
  readln(inp,Kmin);
  assign(f,output);
  rewrite(f);
  lambda := 2;
  i := 0;
  InitGraph();
  DataInputing(Kmin,flag);
  drawAxesSystem(); 
  while (lambda < 3.005) do
  begin
    randomize;
    masSource[1] := new source(1,2);
    masSource[2] := new source(2,2);
    masSource[3] := new source(3,3);
    min := getMin();
    mainPerfomer := new perfomer(lambda);
    masSource[min].incrementationProcessedClaim();
    mainPerfomer.pushClaim(getClaim(masSource[min]));
    mainPerfomer.GenerateTimeRelease(masSource[min].getNextClaimTime());
    masSource[min].generateNextClaim();
    i := i+1;
    changeColor(i);
    Time := 0;
    while (true) do
    begin
      if (mainQueue.isEmpty()) then
      begin
        min := getMin();
        mainQueue.push(getClaim(masSource[min]));
        masSource[min].generateNextClaim();
      end;
      while ((masSource[1].getNextClaimTime < mainPerfomer.getTimeRelease()) or (masSource[2].getNextClaimTime < mainPerfomer.getTimeRelease())
              or (masSource[3].getNextClaimTime < mainPerfomer.getTimeRelease())) do
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
          draw(masSource[flag].getCurrentClaimNumber(),masSource[flag].getFailureCount());
          //sleep(5);
          masSource[sourceNumber].incrementationProcessedClaim();
          mainPerfomer.pushClaim(getClaim(mainQueue.get()));
          mainPerfomer.GenerateTimeRelease(mainQueue.get().getNextClaimTime());  
          mainQueue.pop();
        end;
      end;
    if (masSource[1].getCurrentClaimNumber() > Kmin) and (masSource[2].getCurrentClaimNumber() > Kmin) and (masSource[3].getCurrentClaimNumber() > Kmin)  then //Kmin задать пользователем
    begin
      lambda := lambda + 0.1;
      break;
    end;
    end; //end of main cycle
    while not (mainQueue.isEmpty()) do
    begin
      sourceNumber := mainQueue.get().getSourceNumber();
      mainQueue.pop();
      masSource[sourceNumber].incrementationFailure();
    end;
    //sleep(500);
    setClaims(mainRepository,masSource,i);
    for j :=1 to sourceCount do
      mainrepository.setCount(j,i,mainPerfomer.getMiddleCount(j) + mainQueue.getMiddleCount(j));
    writeln(f,'отказы | обработанные | всего | вероятность отказа | среднее время ожидания');
    writeln(f,'#1 ',masSource[1].getFailureCount,' ',masSource[1].getProcessedClaimCount(),' ',masSource[1].getCurrentClaimNumber(),' ',
                   masSource[1].getFailureCount()/masSource[1].getCurrentClaimNumber(), ' ',mainPerfomer.getMiddleCount(1) + mainQueue.getMiddleCount(1));
    writeln(f,'#2 ',masSource[2].getFailureCount,' ',masSource[2].getProcessedClaimCount(),' ',masSource[2].getCurrentClaimNumber(),' ',
                   masSource[2].getFailureCount()/masSource[2].getCurrentClaimNumber(),' ',mainPerfomer.getMiddleCount(2) + mainQueue.getMiddleCount(2));
    writeln(f,'#3 ',masSource[3].getFailureCount,' ',masSource[3].getProcessedClaimCount(),' ',masSource[3].getCurrentClaimNumber(),' ',
                   masSource[3].getFailureCount()/masSource[3].getCurrentClaimNumber(),' ',mainPerfomer.getMiddleCount(3) + mainQueue.getMiddleCount(3));
    mainPerfomer.nulling();
    mainQueue.nulling();
  end;
  
  close(inp);
  close(f);
  
   main(mainRepository);
  
end.