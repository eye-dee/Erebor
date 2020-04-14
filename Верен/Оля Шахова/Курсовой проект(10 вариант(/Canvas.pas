unit Canvas;

interface

uses GraphABC,ABCObjects,Data,SourceUnit;

const
  sourceCount = 3;

///////////////////////////////////////headers 
procedure main(data : repository);
procedure InitGraph(var mD : repository);
procedure draw(num,fail : real);
function DataInputing(var k : integer;var l : lamMas; var t : real; var f : integer) : integer;
procedure changeColor(iter : integer);
procedure drawAxesSystem();
procedure FailureOfSource(j : integer); 
procedure drawTable();
procedure drawSystem(v : integer; max : real);
///////////////////////////////////////

var
  isEnd : boolean;

type
  menu = class
    private
      g : integer;
      i,j,p: integer;
      k : array [1..5,1..4] of integer;
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
        name[9] := 'lam3';
        name[10] := 'tau';
        name[11] := 'table';
        name[12] := 'graphics';
        g:= 1;
        i := 1;
        j := 1;
        p := 1;
        k[1,1] := 6;k[1,2] := 0;k[1,3] := 0;k[1,4] := 0;
        k[2,1] := 2;k[2,2] := 0;k[2,3] := 0;k[2,4] := 0;
        k[3,1] := 1;k[3,2] := 0;k[3,3] := 0;k[3,4] := 0;
        k[4,1] := 5;k[4,2] := 0;k[4,3] := 0;k[4,4] := 0;
        k[5,1] := 1;k[5,2] := 0;k[5,3] := 0;k[5,4] := 0;
        kmin := 6000;
        tau := 1.0;
        reading := 0;
        for a := 1 to sourceCount do
        begin
          lambda[a] := k[a+1,1] + k[a+1,2]/10.0 + k[a+1,3]/100.0 + k[a+1,4]/1000.0;
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
        for a := 1 to 2 do
        begin
          setBrushColor(clGray);
          setPenColor(clBlack);
          if (a+1 = i) then
            setBrushColor(clRed);
          fillRectangle(320,20 + 40*a,420,60 + 40*a);
          if (a = 2) then
            t := new TextABC(330,30 + 40*a,10,name[10+a] + ' ' +intToStr(g))
          else
            t := new TextABC(330,30 + 40*a,10,name[10+a]);
        end;
      end;
      procedure drawParametrs();
      var 
        t : TextABC;
        a : integer;
      begin
        for a := 1 to 5 do
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
          t := new TextABC(30 + a*50,310,10,IntToStr(k[reading,a]));
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
            t := new TextABC(30 + a*50,310,10,IntToStr(k[reading,a]));
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
            t := new TextABC(30 + a*50,310,10,IntToStr(k[reading,a]));
          end;
        end;
      end;
      procedure printReadingLam3();
       var
        t : textABC;
        a : integer;
      begin
        setBrushColor(clGray);
        setPenColor(clBlack);
        t := new TextABC(100,100,20,'Lam3');
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
            t := new TextABC(30 + a*50,310,10,IntToStr(k[reading,a]));
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
            t := new TextABC(30 + a*50,310,10,IntToStr(k[reading,a]));
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
          4 : begin printReadinglam3(); exit; end;
          5 : begin printReadingTau(); exit; end;
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
        if (reading > 0) then
          if (k[reading,p] < 9) then
            k[reading,p] := k[reading,p] +1;
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
        if (reading > 0) then
          if (k[reading,p] > 0) then
            k[reading,p] := k[reading,p] - 1;
        if (Graph) or (Reading > 0) then
          exit;
        if (i = 3) and (j = 3) then
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
        if (g < 3) then
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
        s : string; l : integer;
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
          DrawSystem(1,0);
          changeColor(random(33));
          FailureOfSource(g);
          Graph := true;
        end;
        if (i = 2) and (j = 3) then
        begin
          drawTable();
          Graph := true;
        end;
        if (j = 1) then
        begin
          case i of 
            2 : begin reading := 1; end;
            3 : begin reading := 2; end;
            4 : begin reading := 3; end;
            5 : begin reading := 4; end;
            6 : begin reading := 5; end;
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
                  Kmin := k[reading,1]*1000 + k[reading,2]*100 + k[reading,3]*10 + k[reading,4];
                end;
            2 : begin
                  lambda[1] := k[reading,1] + k[reading,2]/10.0 + k[reading,3]/100.0 + k[reading,4]/1000.0;
                end;
            3 : begin
                  lambda[2] := k[reading,1] + k[reading,2]/10.0 + k[reading,3]/100.0 + k[reading,4]/1000.0;
                end;
            4 : begin
                  lambda[3] := k[reading,1] + k[reading,2]/10.0 + k[reading,3]/100.0 + k[reading,4]/1000.0;
                end;
            5 : begin
                  tau := k[reading,1] + k[reading,2]/10.0 + k[reading,3]/100.0 + k[reading,4]/1000.0;
                end;
          end;
        end;
        reading := 0;
      end;
  end;

resultMenu = class
  private 
    state : integer;
  public
    constructor create();
    begin
      state := 1;
    end;
    procedure toLevel(s : integer);
    begin
      state := s;
    end;
    function getLevel() : integer;
    begin
      getLevel := state;
    end;
    procedure draw();
    var
      choice : TextABC;
    begin
      case state of
      1 :
        begin 
          Window.Clear(clIndigo);
          setPenColor(clRed); 
          drawRectangle(10,10,280,30);
      
          choice := new TextABC(10,10,10,'Зависимость отказов от первого источников',clRed);
          
      
          drawRectangle(10,110,280,130);
          choice := new  TextABC(10,110,10,'Зависимость средненего количество заявок в памяти',clRed);
          choice.TransparentBackground := true;
      
          choice := new TextABC(10,160,10,'Таблица результатов',clRed);
          drawRectangle(10,160,280,180);
        end;
      2 : 
        begin
          drawRectangle(10,60,100,80);
          drawRectangle(110,60,200,80);
          drawRectangle(210,60,300,80);
          drawRectangle(310,60,400,80);
          
          choice := new TextABC(15,65,12,'source1',clRed);
          choice := new TextABC(115,65,12,'source2',clRed);
          choice := new TextABC(215,65,12,'source3',clRed);
          choice := new TextABC(315,65,12,'source4',clRed);
        end;
      end;
    end;
end;

VAR
  mainData : repository;
  state : integer;
  inputer : menu := new menu();
  drawer : resultMenu := new  resultMenu();
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
  temp : integer;
begin
  Window.Clear(clPink);
  setPenColor(clMaroon);
  
  //Ox
  Line(40,470,665,470);
  Line(665,470,655,475);
  Line(665,470,655,465);
  
  
  //Oy
  Line(40,470,40,10);
  Line(40,10,35,25);
  Line(40,10,45,25);
  text := new TextABC(640,450,10,'lambda',clBlack);
  
  case v of
  1 :
    begin
      text := new TextABC(20,10,10,'P',clBlack);
      for i:= 1 to 11 do
      begin
        Line(60+(i-1)*round(630/11),475,60+(i-1)*round(630/11),465);
        text := new TextABC(50+(i-1)*round(630/11),480,10,intToStr(4+i) + '/10',clBlack);
      end;
      for i:= 1 to 9 do
      begin
        Line(35,450-i*round(460/11),45,450-i*round(460/11));
        text := new TextABC(15,445-i*round(460/11),10,'0.'+intToStr(i),clBlack);
      end;
    end;
  2 :
    begin
      temp := trunc(max) + 1;
      for i := 1 to temp do
      begin
        Line(35,480-i*round(450/temp),45,480-i*round(450/temp));
        text := new TextABC(15,480-i*round(460/temp),10,intToStr(i),clBlack);
      end;
      for i:= 1 to 11 do
      begin
        Line(60+(i-1)*round(630/11),475,60+(i-1)*round(630/11),465);
        text := new TextABC(50+(i-1)*round(630/11),480,10,intToStr(4+i) + '/10',clBlack);
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
  setBrushColor(clDarkOrchid);
  setPenColor(clDarkOrchid);
  moveTo(60+round(640/11),490-round(480*mainData.getClaim(j,i,1)/max));
  for i:=2 to 11 do
  begin
    fillCircle(60+(i-1)*round(640/11),490-round(480*mainData.getClaim(j,i,1)/max),5);
    LineTo(60+(i-1)*round(640/11),490-round(480*mainData.getClaim(j,i,1)/max));
  end;
  drawArrow(645,5);
end;

procedure MiddleCount();
var
  max,temp : real;
  i :integer;
begin
  max := mainData.getterCount(1);
  for i := 2 to 11 do
  begin
    temp := mainData.getterCount(i);
    if (temp > max) then
      max := temp;
  end;
  DrawSystem(2,max);
  moveTo(40,470);
  for i:=1 to 11 do
  begin
    fillCircle(60+(i-1)*round(640/11),520-round(480*mainData.getterCount(i)/max),5);
    LineTo(60+(i-1)*round(640/11),520-round(480*mainData.getterCount(i)/max));
  end;
  drawArrow(645,5);
end;

procedure drawTable();
var
  i : integer;
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
  text := new TextABC(38,10,12,'Источник1',clBlack);
  text := new TextABC(176,10,12,'Источник2',clBlack);
  text := new TextABC(314,10,12,'Источник3',clBlack);
  
  //text := new TextABC(590,20,12,'Буфер',clBlack);
  
  text := new TextABC(10,40,12,'Вероятность отказа',clBlack);
  text := new TextABC(304,40,12,'Вероятность отказа',clBlack);
  for i := 1 to 11 do
  begin
    text := new TextABC(25,35+40*i,12, '0.' + intTostr(round(mainData.getClaim(1,i,1)/mainData.getClaim(1,i,3)*100000)),clBlack);
    text := new TextABC(163,35+40*i,12, '0.' + intTostr(round(mainData.getClaim(2,i,1)/mainData.getClaim(2,i,3)*100000)),clBlack);
    text := new TextABC(301,35+40*i,12,'0.' + intTostr(round(mainData.getClaim(3,i,1)/mainData.getClaim(3,i,3)*100000)),clBlack);
    
    temp := mainData.getterCount(i);
    int := round(temp);
    frac := round((temp-int)*1000);
    if (frac < 0) then
    begin
      int := int - 1;
      frac := 1000+frac;
    end;
   // text := new TextABC(613,35+40*i,12,intToStr(int) + '.' + intToStr(frac),clBlack);
  end;
  drawArrow(645,5);
end;

procedure mouseDown(x,y,mb : integer);
begin
  if (mb = 1) then
  begin
    case state of 
      1 :
      begin
        if (x > 10) and (x < 280) and (y > 10) and (y < 30) then
        begin
          drawer.toLevel(2);
          drawer.draw();
        end else if (((x > 110) and (x < 200)) or ((x > 10) and (x < 100)) or ((x > 210) and (x < 300)) or ((x > 310) and (x < 400))) and (drawer.getLevel() = 2) and (y > 50) and (y < 110) then
        begin
          state := 2;
          if (x > 10) and (x < 100) then
            FailureOfSource(1)
          else if (x > 110) and (x < 200) then
            FailureOfSource(2)
          else if (x > 310) and (x < 400) then
            FailureOfSource(3)
          else if (x > 410) and (x < 500) then
            FailureOfSource(4)
        end else if (x > 10) and (x < 280) and (y > 110) and (y < 130) then
        begin
          state := 2;
          MiddleCount();
        end else if (x > 10) and (x < 280) and (y > 160) and (y < 180) then
        begin
          state := 2;
          drawTable();
        end;
      end;
      2 :
      begin
        if (x > 645) and (x < 665) and (y > 5) and (y <21) then
        begin
          state := 1;
          ClearWindow();
          drawer.toLevel(1);
          drawer.draw();
        end;
      end;
    end;
  end;
end;

procedure main(data : repository);
begin
  state := 1;
  mainData := data;
  drawer.draw();
  onMouseDown := mouseDown;

  while true do
  begin
    
  end;
  
end;

///////////////////////////////graphics Initialization
procedure InitGraph(var mD : repository);
begin
  mainData := mD;
  ClearWindow();
  setBrushColor(clBlack);
  initWindow(10,10,690,512);
  Window.Clear(clYellow);
end;
///////////////////////////////

///////////////////////////////////on-line drawing
procedure draw(num,fail : real);
begin
  if (num <> 0) then
    //fillCircle(40+round(num*640/1010),470-round(fail*480/num),1);
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
    12 : setBrushColor(clChocolate);
    13 : setBrushColor(clCornsilk);
    14 : setBrushColor(clDarkBlue);
    15 : setBrushColor(clDarkMagenta);
    16 : setBrushColor(clDarkSeaGreen);
    17 : setBrushColor(clLavenderBlush);
    18 : setBrushColor(clLightPink);
    19 : setBrushColor(clLightYellow);
    20 : setBrushColor(clLinen);
    21 : setBrushColor(clAzure);
    22 : setBrushColor(clBlack); 
    23 : setBrushColor(clFirebrick);
    24 : setBrushColor(clCadetBlue);
    25 : setBrushColor(clCrimson);
    26 : setBrushColor(clDarkSalmon);
    27 : setBrushColor(clDarkGreen);
    28 : setBrushColor(clDarkRed);
    29 : setBrushColor(clDarkSlateBlue);
    30 : setBrushColor(clGainsboro);
    31 : setBrushColor(clIndianRed);
    32 : setBrushColor(clLightGreen);
    33 : setBrushColor(clMediumOrchid); 
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
    //writeln(inputer.getLambda(p));
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