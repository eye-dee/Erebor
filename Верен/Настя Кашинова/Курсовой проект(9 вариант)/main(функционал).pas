uses
  FUNC_MOD,Data;

const
  input = 'input.txt';
  output = 'output.txt';
  sourceCount = 3;

type
  matrix = array [1..sourceCount] of source;
 
var  
  lambda : lamMas;
  masSource : matrix;
  mainQueue: queue := new queue();
  mainPerfomer: perfomer;
  f: text;
  sourceNumber : integer;
  tau : real;
  mainRepository : repository := new repository();
  i,j : integer;
  menuState : integer;
  Kmin : integer := 1000;
  flag :  integer := 1;
  min : integer; //источник с минимальным временем нового запроса

function getMin() : integer;
var
  p : integer;
  minTime : integer := 1;
begin
  for p:= 2 to sourceCount do
  begin
    if (masSource[p].getNextClaimTime() < masSource[minTime].getNextClaimTime()) then
      minTime := p;
  end;
  getMin := minTime;
end;

procedure setClaims(var r : repository;var m : matrix;j : integer);
var 
  p : integer;
begin
  for p := 1 to sourceCount do
  begin
    r.setClaim(p,j,m[p].getFailureCount(),m[p].getProcessedClaimCount(),m[p].getCurrentClaimNumber());
  end;
end;

begin   
  assign(f,output);
  rewrite(f);
    tau := 1.0;
    lambda[1] := 2.0;
    lambda[2] := 1.0;
    lambda[3] := 5.0;
    i := 0;
    for i:=1 to 11 do
    begin 
      randomize;
      mainPerfomer := new perfomer(tau);
      for j := 1 to sourceCount do
      begin
        masSource[j] := new source(j,lambda[j]);
      end;
      min := getMin();
      masSource[min].incrementationProcessedClaim();
      mainPerfomer.pushClaim(getClaim(masSource[min]));
      mainPerfomer.GenerateTimeRelease(masSource[min].getNextClaimTime());
      masSource[min].generateNextClaim();
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
            mainPerfomer.pushClaim(getClaim(mainQueue.get()));
            mainPerfomer.GenerateTimeRelease(mainQueue.get().getNextClaimTime());
            mainQueue.pop();
          end;
        end;
      if (masSource[1].getCurrentClaimNumber() > Kmin) and (masSource[2].getCurrentClaimNumber() > Kmin) and (masSource[3].getCurrentClaimNumber() > Kmin)  then //Kmin задать пользователем
      begin
        tau := tau + 0.4;
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
                     masSource[j].getFailureCount()/masSource[j].getCurrentClaimNumber(),' ',mainQueue.getMiddleCount(j));
        mainrepository.setCount(j,i,mainQueue.getMiddleCount(j));
        mainrepository.setCount(j,i,mainQueue.getMiddleCount(j) + mainPerfomer.getTimePerfoming(j));
      end;
      
      //writeln(f,'буфер',mainQueue.getMiddleCount());
      
      setClaims(mainRepository,masSource,i);

      mainQueue.nulling();
    end;
     
  
  close(f);  
end.