uses
  QueueUnit, SourceUnit, PerfomerUnit,Data,Canvas,graphABC;

const
  input = 'input.txt';
  output = 'output.txt';

type
  matrix = array [1..4] of source;
 
var  
  masSource : matrix;
  mainQueue: queue := new queue();
  mainPerfomer: perfomer;
  Time: integer;
  f: text;
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
  for i:= 2 to 4 do
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
  for i := 1 to 4 do
  begin
    r.setClaim(i,j,m[i].getFailureCount(),m[i].getProcessedClaimCount(),m[i].getCurrentClaimNumber());
  end;
end;

begin
  assign(f,output);
  rewrite(f);
  lambda := 2;
  i := 0;
  InitGraph();
  DataInputing(Kmin,flag);
  drawAxesSystem(); 
  while (lambda < 3.005) do
  begin 
    mainPerfomer := new perfomer(tau);
    masSource[1] := new source(1,lambda);
    masSource[2] := new source(2,2);
    masSource[3] := new source(3,1);
    masSource[4] := new source(4,1);
    min := getMin();
    mainPerfomer := new perfomer(lambda);
    masSource[min].incrementationProcessedClaim();
    mainPerfomer.GenerateTimeRelease(masSource[min].getNextClaimTime());
    mainPerfomer.pushClaim(getClaim(masSource[min]));
    masSource[min].generateNextClaim();
    i := i+1;
    changeColor(i);
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
      while ((masSource[1].getNextClaimTime < mainPerfomer.getTimeRelease()) or (masSource[2].getNextClaimTime < mainPerfomer.getTimeRelease())
              or (masSource[3].getNextClaimTime < mainPerfomer.getTimeRelease()) or (masSource[4].getNextClaimTime < mainPerfomer.getTimeRelease())) do
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
          mainPerfomer.GenerateTimeRelease(mainQueue.get().getNextClaimTime());
          mainPerfomer.pushClaim(getClaim(mainQueue.get()));
          mainQueue.Calculate();
          mainQueue.pop();
        end;
      end;
    writeln(f,masSource[1].getCurrentClaimNumber(),' ',masSource[2].getCurrentClaimNumber(),' ',masSource[3].getCurrentClaimNumber(),' ',masSource[4].getCurrentClaimNumber(),' ');
    if (masSource[1].getCurrentClaimNumber() > Kmin) and (masSource[2].getCurrentClaimNumber() > Kmin) and (masSource[3].getCurrentClaimNumber() > Kmin) and (masSource[4].getCurrentClaimNumber() > Kmin)  then //Kmin задать пользователем
    begin
      lambda := lambda + 0.1;
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
    mainrepository.setCount(i,mainQueue.getMiddleCount());
    mainQueue.nulling();
  end;
  
  close(f);
  main(mainRepository);
  
end.