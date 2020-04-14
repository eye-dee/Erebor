unit Canvas;

interface

uses GraphABC,ABCObjects,Data,FUNC_MOD;

const
  sourceCount = 2;

///////////////////////////////////////headers
procedure InitGraph(var mD : repository);
procedure draw(num,fail : real);
function DataInputing(var k : integer;var l : lamMas; var t : real; var f : integer) : integer;
procedure changeColor(iter : integer);
procedure drawAxesSystem();
procedure FailureOfSource(j : integer); 
procedure MiddleCount();
procedure drawTable(tau : real);
///////////////////////////////////////

var
  isEnd : boolean;

type
  menu = class
    private
      g : integer;
      i,j,p: integer;
      k : array [1..4] of integer;
      state : integer;
      name : array [1..12] of string;
      Graph : boolean;
      Reading : integer;
      Kmin : integer;
      lambda : lamMas;
      tau : real;
    public
      constructor create();
      var
        a : integer;
      begin
        name[1] := 'parametrs';
        name[2] := 'modelling';
        name[3] := 'results';
        name[4] := 'help';
        name[5] := 'exit';
        name[6] := 'Kmin';
        name[7] := 'lam1';
        name[8] := 'lam2';
        name[9] := 'tau';
        name[10] := 'table';
        name[11] := 'graphics';
        name[12] := 'middleTime';
        i := 1;
        j := 1;
        p := 1;
        g:= 1;
        k[1] := 1;k[2] := 1;k[3] := 1;k[4] := 1;
        tau := 0.1;
        reading := 0;
        for a := 1 to sourceCount do
        begin
          lambda[a] := 0.0;
        end;
      end;
      function getLambda(i : integer) : real;
      begin
        if (i > sourceCount) then
          writeln('i bigger then sourceCount in getLambd');
        getLambda := lambda[i];
      end;
      function getKmin() : integer;
      begin
        getKmin := Kmin;
      end;
      function getTau() : real;
      begin
        getTau := tau;
      end;
      procedure drawResults();
      var 
        t : TextABC;
        a : integer;
      begin
        for a := 1 to 3 do
        begin
          setBrushColor(clGray);
          setPenColor(clBlack);
          if (a+1 = i) then
            setBrushColor(clRed);
          fillRectangle(320,20 + 40*a,420,60 + 40*a);
          if (a = 2) then
            t := new TextABC(330,30 + 40*a,10,name[9+a] + ' '+ IntToStr(g))
          else
            t := new TextABC(330,30 + 40*a,10,name[9+a]);
        end;
      end;
      procedure drawParametrs();
      var 
        t : TextABC;
        a : integer;
      begin
        for a := 1 to 4 do
        begin
          setBrushColor(clGray);
          setPenColor(clBlack);
          if (a+1 = i) then
            setBrushColor(clRed);
          fillRectangle(120,20 + 40*a,220,60 + 40*a);
          t := new TextABC(130,30 + 40*a,10,name[5+a]);
        end;
      end;
      procedure printReadingKmin();
      var
        t : textABC;
        a : integer;
      begin
        setBrushColor(clGray);
        setPenColor(clBlack);
        t := new TextABC(100,100,20,'Kmin');
        for a:= 1 to 4 do
        begin
          setBrushColor(clGray);
          setPenColor(clBlack);
          if (p = a) then
            setBrushColor(clRed);
          fillRectangle(20 + a*50,300,70 + a*50,340);
          t := new TextABC(30 + a*50,310,10,IntToStr(k[a]));
        end;
      end;
      procedure printReadingLam1();
      var
        t : textABC;
        a : integer;
      begin
        setBrushColor(clGray);
        setPenColor(clBlack);
        t := new TextABC(100,100,20,'Lam1');
        for a:= 1 to 4 do
        begin
          setBrushColor(clGray);
          setPenColor(clBlack);
          if (p = a) then
              setBrushColor(clRed);
          fillRectangle(20 + a*50,300,70 + a*50,340);
          if (a = 2) then
            t := new TextABC(30 + a*50,310,10,'.')
          else
          begin
            t := new TextABC(30 + a*50,310,10,IntToStr(k[a]));
          end;
        end;
      end;
      procedure printReadingLam2();
      var
        t : textABC;
        a : integer;
      begin
        setBrushColor(clGray);
        setPenColor(clBlack);
        t := new TextABC(100,100,20,'Lam2');
        for a:= 1 to 4 do
        begin
          setBrushColor(clGray);
          setPenColor(clBlack);
          if (p = a) then
              setBrushColor(clRed);
          fillRectangle(20 + a*50,300,70 + a*50,340);
          if (a = 2) then
            t := new TextABC(30 + a*50,310,10,'.')
          else
          begin
            t := new TextABC(30 + a*50,310,10,IntToStr(k[a]));
          end;
        end;
      end;
      procedure printReadingTau();
       var
        t : textABC;
        a : integer;
      begin
        setBrushColor(clGray);
        setPenColor(clBlack);
        t := new TextABC(100,100,20,'Tau');
        for a:= 1 to 4 do
        begin
          setBrushColor(clGray);
          setPenColor(clBlack);
          if (p = a) then
              setBrushColor(clRed);
          fillRectangle(20 + a*50,300,70 + a*50,340);
          if (a = 2) then
            t := new TextABC(30 + a*50,310,10,'.')
          else
          begin
            t := new TextABC(30 + a*50,310,10,IntToStr(k[a]));
          end;
        end;
      end;
      procedure print();
      var
        t : TextABC;
        a : integer;
      begin
        Window.Clear();
        case reading of 
          1 : begin printReadingKmin(); exit; end;
          2 : begin printReadinglam1(); exit; end;
          3 : begin printReadinglam2(); exit; end;
          4 : begin printReadingTau(); exit; end;
        end;
        Graph := false;
        for a := 1 to 5 do
        begin
          setBrushColor(clGray);
          setPenColor(clBlack);
          if (a = j) and (i = 1) then
            setBrushColor(clRed);
          fillRectangle(20 + a*100,20, 120 + 100*a, 60);
          t := new TextABC(30 + a*100,30,10,name[a]);
        end;
        if (state = 1) then
          drawParametrs();
        if (state = 2) then
          drawResults();
      end;
      procedure setLambda(i : integer;var l:lamMas; value : real); 
      begin
        l[i] := value;
      end;
      procedure moveUp();
      begin
        if (k[p] < 9) then
          k[p] := k[p] +1;
        if (Graph) or (Reading > 0) then
          exit;
        if (i = 1) then
          exit;
        if (j <> 1) and (j <> 3) then
          exit;
        i := i - 1;
        if (i = 1) then
          state := 0;
      end;
      procedure moveDown();
      begin
        if (k[p] > 0) then
          k[p] := k[p] - 1;
        if (Graph) or (Reading > 0) then
          exit;
        if (i = 4) and (j = 3) then
          exit;
        if (i = 6) then
          exit;
        if (j <> 1) and (j <> 3) then
          exit;
        i := i + 1;
        if (j = 1) then
          state := 1;
        if (j = 3) then
          state := 2;
      end;
      procedure moveLeft();
      begin
        if (g > 1) then
          g := g - 1;
        if (p > 1) then
          p := p -1;
        if (Graph) or (Reading > 0) then
          exit;
        if (j = 1) then
          exit;
        if (i > 1) then
          exit;
        j := j - 1;
      end;
      procedure moveRight();
      begin
        if (g < 2) then
          g := g + 1;
        if (p < 4) then
          p := p + 1;
        if (Graph) or (Reading > 0) then
          exit;
        if (j = 5) then
          exit;
        if (i > 1) then
          exit;
        j := j + 1;
      end;
      function action() : integer;  
      var
        t : textABC;
        ch : char;
        s : string;
      begin
        action := 0;
        if (i = 1) and (j = 1) then
          state := 1;
        if (i = 1) and (j = 2) then
          action := 2 
        else if (i = 1) and (j = 3) then
          state := 2
        else if (i = 1) and (j = 5) then
          action := 5;
          
        if (i = 3) and (j = 3) then
        begin
          FailureOfSource(g);
          Graph := true;
        end;
        if (i = 2) and (j = 3) then
        begin
          drawTable(tau);
          Graph := true;
        end;
        if (i = 4) and (j = 3) then
        begin
          MiddleCount();
          Graph := true;
        end;
        if (j = 1) then
        begin
          case i of 
            2 : begin reading := 1; end;
            3 : begin reading := 2; end;
            4 : begin reading := 3; end;
            5 : begin reading := 4; end;
          end;
        end;
      end;
      function isGraph() : boolean;
      begin
          isGraph := Graph;
      end;
      procedure endReading();
      begin
        if (reading > 0) then
        begin
          case reading of
            1 : begin
                  Kmin := k[1]*1000 + k[2]*100 + k[3]*10 + k[4];
                end;
            2 : begin
                  lambda[1] := k[1] + k[2]/10.0 + k[3]/100.0 + k[4]/1000.0;
                end;
            3 : begin
                  lambda[2] := k[1] + k[2]/10.0 + k[3]/100.0 + k[4]/1000.0;
                end;
            4 : begin
                  tau := k[1] + k[2]/10.0 + k[3]/100.0 + k[4]/1000.0;
                end;
          end;
        end;
        reading := 0;
      end;
  end;
 
VAR
  mainData : repository;
  state : integer;
  inputer : menu := new menu();
  endOfInput : boolean;
  menuState : integer;
  Kmin :integer;
  
implementation
procedure drawArrow(x,y : integer);
var
  arr : array of point := new Point[7];
begin
  setBrushColor(clBlack);
  arr[0].X := x+8; arr[0].Y := y+0;
  arr[1].X := x+0; arr[1].Y := y+8;
  arr[2].X := x+8; arr[2].Y := y+16;
  arr[3].X := x+8; arr[3].Y := y+12;
  arr[4].X := x+20; arr[4].Y := y+12;
  arr[5].X := x+20; arr[5].Y := y+4;
  arr[6].X := x+8; arr[6].Y := y+4;
  fillClosedCurve(arr);
end;

procedure drawSystem(v : integer; max : real);
var
  i : integer;
  text : TextABC;
  temp,h : real;
begin
  Window.Clear(clPink);
  setPenColor(clMaroon);
  
  //Ox
  Line(40,490,685,490);
  Line(685,490,675,495);
  Line(685,490,675,485);
  
  
  //Oy
  Line(40,490,40,10);
  Line(40,10,35,25);
  Line(40,10,45,25);
  text := new TextABC(640,490,10,'tau',clBlack);
  
  case v of
  1 :
    begin
      text := new TextABC(20,10,10,'P',clBlack);
      for i:= 1 to 11 do
      begin
        Line(65+(i-1)*round(630/11),485,65+(i-1)*round(630/11),495);
        text := new TextABC(60+(i-1)*round(630/11),500,10,intToStr(4+i) + '/10',clBlack);
      end;
      for i:= 1 to 9 do
      begin
        Line(35,512-i*round(462/9),45,512-i*round(462/9));
        text := new TextABC(15,500-i*round(462/9),10,'0.'+intToStr(i),clBlack);
      end;
    end;
  2 :
    begin
      temp := trunc(max) + 1;
      temp := max/11;
      h := temp;
      while (temp < max) do
      //for i := 1 to temp do
      begin
        i := i + 1;
        Line(35,512-i*round(512/11),45,512-i*round(512/11));
        text := new TextABC(5,502-i*round(512/11),10,intToStr(round(temp - h)) + ',' + intTostr(round(100*(temp-h))),clBlack);
        temp := temp + h;
      end;
      for i:= 1 to 11 do
      begin
        //Line(60+(i-1)*round(630/11),475,60+(i-1)*round(630/11),465);
        text := new TextABC(50+(i-1)*round(660/11),495,10,intToStr(4+i) + '/10',clBlack);
      end;
    end;
  end;
end;

procedure FailureOfSource(j : integer);  //зависимость отказов источника j
var
  i : integer;
  max,temp : integer;
begin
  max := mainData.getClaim(j,1,1);
  for i := 2 to 11 do
  begin
    temp := mainData.getClaim(j,i,1);
    if (temp > max) then
      max := temp;
  end;
  DrawSystem(1,0);
  setBrushColor(clDarkOrchid);
  setPenColor(clDarkOrchid);
  moveTo(60,482-round(470*mainData.getClaim(j,1,1)/max));
  for i:=1 to 11 do
  begin
    fillCircle(60+(i-1)*round(640/11),482-round(470*mainData.getClaim(j,i,1)/max),5);
    LineTo(60+(i-1)*round(640/11),482-round(470*mainData.getClaim(j,i,1)/max));
  end;
  drawArrow(645,5);
end;

procedure MiddleCount();
var
  max,temp : real;
  i :integer;
begin
  max := mainData.getterCount(3,1);
  for i := 2 to 11 do
  begin
    temp := mainData.getterCount(3,i);
    if (temp > max) then
      max := temp;
  end;
  DrawSystem(2,max);
  moveTo(40,470);
  for i:= 1 to 11 do
      begin
        Line(60+(i-1)*round(670/11),495,60+(i-1)*round(670/11),485);
        //text := new TextABC(50+(i-1)*round(630/11),480,10,intToStr(4+i) + '/10',clBlack);
      end;
  for i:=1 to 11 do
  begin
    fillCircle(60+(i-1)*round(670/11),515-round(502*mainData.getterCount(3,i)/max),5);
    LineTo(60+(i-1)*round(670/11),515-round(502*mainData.getterCount(3,i)/max));
  end;
  drawArrow(645,5);
end;

procedure drawTable(tau : real);
var
  i,j : integer;
  text : TextABC;
  temp : real;
  int,frac : integer;
begin
  Window.Clear();
  setBrushColor(clBlack);
  setPenColor(clBlack);
  window.Clear(clPink);
  for i := 1 to 6 do
  begin
      line(138*i,0,138*i,512)
  end;
  line(0,30,588,30);
  for i := 1 to 11 do
  begin
    line(0,30+40*i,690,30+40*i);
  end;
  text := new TextABC(162,10,12,'Источник1',clBlack);
  text := new TextABC(300,10,12,'Источник2',clBlack);
  text := new TextABC(25,10,12,'Tau');
  
  text := new TextABC(590,20,12,'Буфер',clBlack);
  
  text := new TextABC(160,40,12,'Вероятность отказа',clBlack);
  //text := new TextABC(304,40,12,'Вероятность отказа',clBlack);
  for i := 1 to 11 do
  begin
    text := new TextABC(25,35+40*i,12,intToStr(round(round((tau + (i-1)*0.1)*10) div 10)) + '.' + intToStr(round(round((tau + (i-1)*0.1)*100) mod 100)));
    text := new TextABC(175,35+40*i,12,'0.'+intTostr(round(mainData.getClaim(1,i,1)/mainData.getClaim(1,i,3)*1000)),clBlack);
    text := new TextABC(313,35+40*i,12,'0.' + intTostr(round(mainData.getClaim(2,i,1)/mainData.getClaim(2,i,3)*1000)),clBlack);
    for j:= 1 to 2 do
    begin
      temp := mainData.getterCount(j,i);
      int := round(temp);
      frac := round((temp-int)*1000);
      if (frac < 0) then
      begin
        int := int - 1;
        frac := 1000+frac;
      end;
      if (frac < 100) then
        text := new TextABC(313 + j*150,35+40*i,12,intToStr(int) + '.0' + intToStr(frac),clBlack)
      else
        text := new TextABC(313 + j*150,35+40*i,12,intToStr(int) + '.' + intToStr(frac),clBlack)
    end;
  end;
  drawArrow(645,5);
end;

///////////////////////////////graphics Initialization
procedure InitGraph(var mD : repository);
begin
  mainData := mD;
  ClearWindow();
  setBrushColor(clBlack);
  initWindow(10,10,690,512);
  Window
end;
///////////////////////////////

///////////////////////////////////on-line drawing
procedure draw(num,fail : real);
begin
  if (num <> 0) then
    fillCircle(40+round(num*690/kmin),470-round(fail*480/num),1);
end;
///////////////////////////////////

///////////////////////////////playing with colors
procedure changeColor(iter : integer);
begin
  case iter of
    1 : setBrushColor(clFirebrick);
    2 : setBrushColor(clForestGreen);
    3 : setBrushColor(clGray);
    4 : setBrushColor(clDarkSalmon);
    5 : setBrushColor(clBrown);
    6 : setBrushColor(clGreenYellow);
    7 : setBrushColor(clNavy);
    8 : setBrushColor(clOrange);
    9 : setBrushColor(clPurple);
    10 : setBrushColor(clSpringGreen);
    11 : setBrushColor(clRed); 
  end;
end;
///////////////////////////////

///////////////////////////////
procedure keyPress(ch : char);
begin
  case ch of
    'a' : inputer.moveLeft();
    's' : inputer.moveDown();
    'd' : inputer.moveRight();
    'w' : inputer.moveUp();
    #13 : menuState := inputer.action();
    #8 :  begin inputer.print(); inputer.endReading(); end;
  end;
  
  if (not(inputer.isGraph())) then
    inputer.print();
end;
///////////////////////////////

///////////////////////////////Inputing some data
function DataInputing(var k : integer;var l : lamMas; var t : real; var f : integer) : integer;
var
  p : integer;
begin
  menuState := 0;
  Kmin := k;
  inputer.print();
  onKeyPress := keyPress;
  while true do
  begin
    if (menuState <> 0) then
      break;
  end;
  if (inputer.getKmin() > 0.001) then
    k := inputer.getKmin();
  if (inputer.getTau() > 0.001) then
    t := inputer.getTau();
  for p := 1 to SourceCount do
  begin
    writeln(inputer.getLambda(p));
    if (inputer.getLambda(p) > 0.001) then
      l[p] := inputer.getLambda(p);
  end;
  DataInputing := menuState;  
  Kmin := k;
end;
///////////////////////////////

///////////////////////////////Coordinate system for on-line drawing
procedure drawAxesSystem();
var
  text : textABC;
  i : integer;
begin
  Window.Clear();
  
  // Ox
  Line(40,470,660,470);
  Line(660,470,635,475);
  Line(660,470,635,465);
  text := new TextABC(610,480,10,'Kol(1)',clBlack);
  
  // Oy
  Line(40,470,40,10);
  Line(40,10,45,20);
  Line(40,10,35,20);
  text := new TextABC(15,10,10,'P',clBlack);
  
  for i := 1 to 9 do
  begin
    line(round(640/10*i),475,round(640/10*i),465);
    text := new TextABC(round(640/10*i)-10,476,10,intToStr(round(kmin/10*i)),clBlack);
  end;
  
  for i := 1 to 9 do
  begin
    line(35,48*i,45,48*i);
    text := new TextABC(15,475-48*i,10,'0.'+intToStr(i),clBlack);
  end;
end;
///////////////////////////////

BEGIN
END.