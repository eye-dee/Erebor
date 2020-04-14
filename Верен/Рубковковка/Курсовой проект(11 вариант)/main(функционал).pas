uses
  FUNC_MOD,Data;

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
  f: text;
  sourceNumber : integer;
  lambda : real;
  tau : integer;
  mainRepository : repository := new repository();
  i,j : integer;
  Kmin : integer := 1000;
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
  tau := 2;
  lambda := 1.0;
  i := 0; 
  while (lambda < 5.005) do
  begin 
    randomize;
    mainPerfomer := new perfomer(tau);
    masSource[1] := new source(1,lambda);
    masSource[2] := new source(2,1);
    masSource[3] := new source(3,5);
    min := getMin();
    mainPerfomer := new perfomer(lambda);
    masSource[min].incrementationProcessedClaim();
    mainPerfomer.GenerateTimeRelease(masSource[min].getNextClaimTime());
    mainPerfomer.pushClaim(getClaim(masSource[min]));
    masSource[min].generateNextClaim();
    i := i+1;
    writeln(f,'отказы | обработанные | всего | вероятность отказа | среднее время ожидания');
    while (true) do
    begin
      if (mainQueue.isEmpty()) then
      begin
        min := getMin();
        mainQueue.push(getClaim(masSource[min]));
        masSource[min].generateNextClaim();
      end;
      while ((masSource[1].getNextClaimTime < mainPerfomer.getTimeRelease()) or (masSource[2].getNextClaimTime < mainPerfomer.getTimeRelease())
              or (masSource[3].getNextClaimTime < mainPerfomer.getTimeRelease()))do
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
          masSource[sourceNumber].incrementationProcessedClaim();
          mainPerfomer.GenerateTimeRelease(mainQueue.get().getNextClaimTime());
          mainPerfomer.pushClaim(getClaim(mainQueue.get()));
          mainQueue.Calculate();
          mainQueue.pop();
        end;
      end;
    if (masSource[1].getCurrentClaimNumber() > Kmin) and (masSource[2].getCurrentClaimNumber() > Kmin) and (masSource[3].getCurrentClaimNumber() > Kmin)  then //Kmin задать пользователем
    begin
      lambda := lambda + 0.4;
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
    for j:=1 to sourceCount do
    begin
      writeln(f,'#',j,' ',masSource[j].getFailureCount,' ',masSource[j].getProcessedClaimCount(),' ',masSource[j].getCurrentClaimNumber(),' ',
                   masSource[j].getFailureCount()/masSource[j].getCurrentClaimNumber());
    end;
    
    writeln(f,'буфер',mainQueue.getMiddleCount());
    
    setClaims(mainRepository,masSource,i);
    mainrepository.setCount(i,mainQueue.getMiddleCount());
    mainQueue.nulling();
  end;
  
  close(f);
  
end.