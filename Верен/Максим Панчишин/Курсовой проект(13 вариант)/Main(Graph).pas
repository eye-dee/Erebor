uses
  FUNC_MOD,Data,Canvas,graphABC;

const
  input = 'input.txt';
  output = 'output.txt';
  sourceCount = 3;

type
  matrix = array [1..sourceCount] of source;
 
var  
  lambda : lamMas;
  masSource : matrix;
  mainPerfomer: perfomer;
  f: text;
  sourceNumber : integer;
  tau : real := 1.0;
  mainRepository : repository := new repository();
  i,j : integer;
  menuState : integer;
  Kmin : integer := 10000;
  flag :  integer := 1;
  min : integer; //источник с минимальным временем нового запроса
  menu : MenuClass := new MenuClass();

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

procedure mouseDown(x,y,mb : integer);
begin
  if (mb = 1) then
  begin
    if (menu.isReading()) then
    begin
      if (x > 220) and (x < 240) and (y > 120) and (y < 140) then
        menu.incCur()
      else if (x > 220) and (x < 240) and (y > 150) and (y < 170) then
        menu.decCur()
      else if (x > 250) and (x < 270) and (y > 120) and (y < 140) then
        menu.incCurFrac()
      else if (x > 250) and (x < 270) and (y > 150) and (y < 170) then
        menu.decCurFrac()
      else if (x > 400) and (x < 420) and (y > 50) and (y < 70) then
        menu.endReading();
    end else
    begin
      if (menu.getState() = 1) then
      begin
        if (x > 160) and (x < 320) and (y > 100) and (y < 200) then
        begin
          menu.StartModelling();
          window.Clear();
          exit();
        end else if (x > 20) and (x < 140) and (y > 220) and (y < 240) then
          menu.setDrawFlag(1)
        else if (x > 20) and (x < 140) and (y > 260) and (y < 280) then
          menu.setDrawFlag(2)
        else if (x > 20) and (x < 140) and (y > 300) and (y < 320) then
          menu.setDrawFlag(3)
        else if (x > 340) and (x < 460) and (y > 220) and (y < 240) then
        begin
          menu.setReading(1);    
        end else if (x > 340) and (x < 460) and ( y > 260) and (y < 280) then
        begin
          menu.setReading(2); 
        end else if (x > 340) and (x < 460) and (y > 300) and (y < 320) then
        begin
          menu.setReading(3);  
        end else if (x > 340) and (x < 460) and (y > 340) and (y < 360) then
        begin
          menu.setReading(4);  
        end else if (x > 340) and (x < 460) and (y > 380) and (y < 400) then
        begin
          menu.setReading(5);  
        end;
      end;
    end;
  end;    
  menu.draw();
end;

procedure mouseDown2(x,y,mb : integer);
begin
  menu.draw();
  if (mb = 1) then
  begin
    if (x > 20) and (x < 140) and (y > 220) and (y < 240) then
      FailureOfSource(mainRepository,1)
    else if (x > 20) and (x < 140) and (y > 260) and (y < 280) then
      FailureOfSource(mainRepository,2)
    else if (x > 20) and (x < 140) and (y > 300) and (y < 320) then
      FailureOfSource(mainRepository,3)
    else if (x > 160) and (x < 320) and (y > 100) and (y < 200) then
      DrawTable(mainRepository,lambda[2] - 2.0)
    else if (x > 320) and (x < 480) and (y > 100) and ( y < 200) then
      Settings(menu);
  end;
end;

procedure nullProcedure(x,y,mb : integer);
begin
  
end;

begin
//*******************************************/Ввод
  InitGraph();
  onMouseDown := mouseDown;
  menu.draw();
  
  while true do
  begin
    
    if (menu.isModelling) then
      break;
  end;

//*******************************************/

  onMouseDown := nullProcedure;
  flag := menu.getDrawFlag();
  Kmin := menu.getKmin();

  assign(f,output);
  rewrite(f);
    lambda[1] := menu.getLams(1);
    lambda[2] := menu.getLams(2);
    lambda[3] := menu.getLams(3);
    i := 0;
    drawAxesSystem(kmin);
    setBrushColor(clGreen);
    for i:=1 to 11 do
    begin 
      randomize;
      mainPerfomer := new perfomer(menu.getLams(4));
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
        draw(masSource[flag].getCurrentClaimNumber(),masSource[flag].getFailureCount(),kmin);
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
          lambda[2] := lambda[2] + 0.2;
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
     
  
  close(f);
  
  Window.Clear();
  
  menu.toNextState();
  menu.draw();
  
  onMouseDown := mouseDown2;
  
  while true do
  begin
    
  end;
  
  Window.Close();
end.