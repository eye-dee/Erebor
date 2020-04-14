uses
  SourceUnit, PerfomerUnit,Data;

const
  input = 'input.txt';
  output = 'output.txt';
  sourceCount = 3;

type
  matrix = array [1..sourceCount] of source;
 
var  
  masSource : matrix;
  mainPerfomer: perfomer;
  Time: integer;
  inp,f: text;
  sourceNumber : integer;
  lambda : lamMas;
  tau : real;
  bool : boolean := false;
  mainRepository : repository := new repository();
  i,j,p : integer;
  Kmin : integer := 6000;
  flag :  integer := 1;
  min : integer; //источник с минимальным временем нового запроса

function getMin() : integer;
var
  i : integer;
  minTime : integer := 1;
begin
  for i:= 2 to sourceCount do
  begin
    if (masSource[i].getNextClaimTime() < masSource[minTime].getNextClaimTime()) then
    begin
      minTime := i;
    end;
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

  lambda[1] := 2.0;
  lambda[2] := 1.0;
  lambda[3] := 5.0;
  
  tau := 5.0;

  assign(f,output);
  rewrite(f);
    writeln(f,'REALIZATION GO');
    writeln(f,'отказы | обработанные | всего | вероятность отказа');
    assign(inp,input);
    reset(inp);
    
   for i:=1 to 11 do
    begin 
      randomize;
      mainPerfomer := new perfomer(tau);
      for j := 1 to sourceCount do
      begin
        masSource[j] := new source(j,lambda[j]);
      end;
      min := getMin();
      mainPerfomer.pushClaim(getClaim(masSource[min]));
      mainPerfomer.GenerateTimeRelease(masSource[min].getNextClaimTime(),true);
      masSource[min].generateNextClaim();
      writeln(f,'отказы | обработанные | всего | вероятность отказа | среднее время ожидания');
      while (true) do
      begin
        min := getMin();
        if (mainPerfomer.getTimeRelease() > masSource[min].getNextClaimTime()) then
        begin
          sourceNumber := mainPerfomer.getSourceNumber();
          if (min < mainPerfomer.getSourceNumber()) then
          begin
            masSource[sourceNumber].incrementationFailure();
            mainPerfomer.pushClaim(getClaim(masSource[min]));
            mainPerfomer.GenerateTimeRelease(masSource[min].getNextClaimTime(),false);
            masSource[min].generateNextClaim();
          end else
          begin
            masSource[min].incrementationFailure();
            masSource[min].generateNextClaim();
          end;
        end else
        begin
          sourceNumber := mainPerfomer.getSourceNumber();
          masSource[sourceNumber].incrementationProcessedClaim();
          mainPerfomer.pushClaim(getClaim(masSource[min]));
          mainPerfomer.GenerateTimeRelease(masSource[min].getNextClaimTime(),true);
          masSource[min].generateNextClaim();
        end;
        if (masSource[1].getCurrentClaimNumber() > Kmin) and 
        (masSource[2].getCurrentClaimNumber() > Kmin) and 
        (masSource[3].getCurrentClaimNumber() > Kmin)  then //Kmin задать пользователем
        begin
          tau := tau + 0.1;
          break;
        end;
      end; //end of main cycle
      for j:=1 to sourceCount do
      begin
        writeln(f,'#',j,' ',masSource[j].getFailureCount,' ',masSource[j].getProcessedClaimCount(),' ',masSource[j].getCurrentClaimNumber(),' ',
                     masSource[j].getFailureCount()/masSource[j].getCurrentClaimNumber());
      
        
      end;
         writeln(f, mainPerfomer.getKoef());
         mainrepository.setCount(i,mainPerfomer.getKoef);
      //writeln(f,'буфер',mainQueue.getMiddleCount());
      
      setClaims(mainRepository,masSource,i);
    end;
  close(inp);
  close(f);
  
end.