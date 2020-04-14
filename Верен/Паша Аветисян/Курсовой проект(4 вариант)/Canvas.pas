unit Canvas;

interface

uses GraphABC,ABCObjects,Data;

const
  sourceCount = 3;
  
///////////////////////////////////////headers
procedure main(data : repository);
procedure InitGraph();
procedure draw(num,fail : real);
procedure DataInputing(var k : integer; var f : integer);
procedure changeColor(iter : integer);
procedure drawAxesSystem();
///////////////////////////////////////

type
  menu = class
    private
      state : integer;
      flag : integer;
    public
      constructor create();
      begin
        state := 0;
        flag := 1;
      end;
      procedure drawLevel();
      var
        text : TextABC;
      begin
        case state of
          1 : begin
  //setBrushColor(clBlack);
  //setPenColor(clBlack);
    changeColor(random(34));
                fillRectangle(20,20,100,100);
                fillRectangle(20,150,100,230);
                text := new TextABC(25,25,15,'Settings',clBlack);
                text := new TextABC(25,155,15,'Go...', clBlack);
              end;
          2 : begin
  //setBrushColor(clBlack);
  //setPenColor(clBlack);
  changeColor(random(34));
                Line(100,60,120,60);
                Line(100,60,120,190);
                fillRectangle(120,20,200,100);
                fillRectangle(120,150,200,230);
                text := new TextABC(125,25,15,'Kmin',clBlack);
                text := new TextABC(125,155,8,'Chose source',clBlack);
              end;
          3 : begin
  //setBrushColor(clBlack);
  //setPenColor(clBlack);
  changeColor(random(34));
                Line(200,190,250,180);
                Line(200,190,250,280);
                Line(200,190,250,380);
                Line(200,190,250,480);
                fillRectangle(250,170,330,210);
                fillRectangle(250,270,330,310);
                fillRectangle(250,370,330,410);
                text := new TextABC(260,180,15,'First',clBlack);
                text := new TextABC(260,280,15,'Second',clBlack);
                text := new TextABC(260,380,15,'Third',clBlack);
              end;
          4 : begin
  //setBrushColor(clBlack);
  //setPenColor(clBlack);
  changeColor(random(34));
                fillRectangle(220,20,300,100);
                fillRectangle(320,20,400,100);
                fillRectangle(420,20,500,100);
                fillRectangle(520,20,600,100);
                text := new TextABC(225,30,10,'50',clBlack);
                text := new TextABC(325,30,10,'1000',clBlack);
                text := new TextABC(425,30,10,'2000',clBlack);
                text := new TextABC(525,30,10,'3000',clBlack);
               end;
        end;
      end;
      procedure ToNextLevel(st : integer);
      begin
        //if (st > state) then
          state := st;
      end;
      function getState() : integer;
      begin
        getState := state;
      end;
      procedure ReadingK(var K : integer;x,y : integer);
      begin
        if (x > 220) and (x < 300) then
          k := 50
        else if (x > 320) and (x < 400) then
          k := 1000
        else if (x > 420) and (x < 500) then
          k := 2000
        else if (x > 520) and (x < 600) then
          k := 3000;
        ClearWindow();
        state := 1;
        drawLevel();
        state := 2;
        DrawLevel();
      end;
      procedure setNumber(f1 : integer);
      begin
        flag := f1;
        ClearWindow();
        state := 1;
        drawLevel();
        state := 2;
        DrawLevel();
      end;
      function getFlag() : integer;
      begin
        getFlag := flag;
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
  //setBrushColor(clBlack);
  //setPenColor(clBlack);
  changeColor(random(34));
          drawRectangle(10,10,280,30);
      
          choice := new TextABC(10,10,10,'Зависимость отказов от источников',clRed);
          
      
          drawRectangle(10,110,280,130);
          choice := new  TextABC(10,110,10,'Время пребывания',clRed);
          choice.TransparentBackground := true;
      
          choice := new TextABC(10,160,10,'Таблица результатов',clRed);
          drawRectangle(10,160,280,180);
        end;
      2 : 
        begin
          drawRectangle(10,60,100,80);
          drawRectangle(110,60,200,80);
          drawRectangle(210,60,300,80);
          
          choice := new TextABC(15,65,12,'source1',clRed);
          choice := new TextABC(115,65,12,'source2',clRed);
          choice := new TextABC(215,65,12,'source3',clRed);
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
  //setBrushColor(clBlack);
  //setPenColor(clBlack);
  changeColor(random(34));
  
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
        Sleep(20);
      end;
      for i:= 1 to 9 do
      begin
        Line(35,450-i*round(460/11),45,450-i*round(460/11));
        text := new TextABC(15,445-i*round(460/11),10,'0.'+intToStr(i),clBlack);
        Sleep(20);
      end;
    end;
  2 :
    begin
      temp := trunc(max) + 1;
      for i := 1 to temp do
      begin
        Line(35,480-i*round(450/temp),45,480-i*round(450/temp));
        text := new TextABC(15,480-i*round(460/temp),10,intToStr(i),clBlack);
        Sleep(20);
      end;
      for i:= 1 to 11 do
      begin
        Line(60+(i-1)*round(630/11),475,60+(i-1)*round(630/11),465);
        text := new TextABC(50+(i-1)*round(630/11),480,10,intToStr(4+i) + '/10',clBlack);
        Sleep(20);
      end;
    end;
  end;
end;


procedure FailureOfSource(j : integer);  //зависимость отказов источника j
var
  i : integer;
  max,temp : integer;
  x,y : real;
  text : textABC;
begin
  max := mainData.getClaim(j,1,1);
  for i := 2 to 11 do
  begin
    temp := mainData.getClaim(j,i,1);
    if (temp > max) then
      max := temp;
  end;
  DrawSystem(1,0);
  //setBrushColor(clBlack);
  //setPenColor(clBlack);
  changeColor(random(34));
  y := mainData.getClaim(j,1,1)/mainData.getClaim(j,1,3);
  moveTo(60,490-round(480*y));
  fillCircle(60,490-round(480*y),5);
  text := new TextABC(60,490-round(480*y),12,'0.'+intTostr(round(y*1000)),clBlack);
  Sleep(20);
  for i:=2 to 11 do
  begin
  //setBrushColor(clBlack);
  //setPenColor(clBlack);
  changeColor(random(34));
    y := mainData.getClaim(j,i,1)/mainData.getClaim(j,i,3);
    fillCircle(60+(i-1)*round(640/11),490-round(480*y),5);
    text := new TextABC(60+(i-1)*round(640/11),490-round(480*y),12,'0.'+intTostr(round(y*1000)),clBlack);
    LineTo(60+(i-1)*round(640/11),490-round(480*y));
    Sleep(20);
  end;
  drawArrow(645,5);
end;

procedure MiddleCount();
var
  max,temp : real;
  i,j :integer;
begin
  DrawSystem(2,max);
  for j := 1 to sourceCount do
  begin
    changeColor(j);
    max := mainData.getterCount(j,1);
    for i := 2 to 11 do
    begin
      temp := mainData.getterCount(j,i);
      if (temp > max) then
        max := temp;
    end;
    moveTo(40,470);
    for i:=1 to 11 do
    begin
      temp := mainData.getterCount(j,i);
      fillCircle(60+(i-1)*round(640/11),520-round(480*mainData.getterCount(j,i)/max),5);
      LineTo(60+(i-1)*round(640/11),520-round(480*mainData.getterCount(j,i)/max));
    end;
  end;
    setBrushColor(clBlack);
    setPenColor(clBlack);
    drawArrow(645,5);
end;

procedure drawTable();
var
  i,p : integer;
  text : TextABC;
  temp : real;
  int,frac : integer;
begin
  //setBrushColor(clBlack);
  //setPenColor(clBlack);
  changeColor(random(34));
  window.Clear(clPink);
  for i := 1 to 8 do
  begin
      line(30+118*i,0,30+118*i,512)
  end;
  line(0,30,390,30);
  for i := 1 to 11 do
  begin
    line(0,30+40*i,690,30+40*i);
  end;
  
  line(50,0,50,512);
  
  text := new TextABC(10,10,12,'Lam',clBlack);
  text := new TextABC(60,10,10,'Источник1',clBlack);
  text := new TextABC(188,10,10,'Источник2',clBlack);
  text := new TextABC(316,10,10,'Источник3',clBlack);
  
  text := new TextABC(642,20,10,'преб ист1',clBlack);
  text := new TextABC(542,20,10,'преб ист2',clBlack);
  text := new TextABC(442,20,10,'преб ист3',clBlack);
  
  text := new TextABC(60,40,12,'Вероятность           отказа',clBlack);
  for i := 1 to 11 do
  begin
    text := new TextABC(10,35+40*i,12,intToStr(round((2 + (i-1)*0.1)*10) div 10) + '.' + intToStr(round((0.5 + (i-1)*0.1)*10) mod 10));
    text := new TextABC(55,35+40*i,12,'0.'+intTostr(round(mainData.getClaim(1,i,1)/mainData.getClaim(1,i,3)*1000)),clBlack);
    text := new TextABC(193,35+40*i,12,'0.' + intTostr(round(mainData.getClaim(2,i,1)/mainData.getClaim(2,i,3)*1000)),clBlack);
    text := new TextABC(311,35+40*i,12,'0.' + intTostr(round(mainData.getClaim(3,i,1)/mainData.getClaim(3,i,3)*1000)),clBlack);
    
    for p:= 1 to sourceCount do
    begin
      temp := mainData.getterCount(p,i);
      int := round(temp);
      frac := round((temp-int)*1000);
      if (frac < 0) then
      begin
        int := int - 1;
        frac := 1000+frac;
      end;
      text := new TextABC(330 + 100*p,35+40*i,12,intToStr(int) + '.' + intToStr(frac),clBlack);
    end;  
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
          else if (x > 210) and (x < 300) then
            FailureOfSource(3)
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
end;

///////////////////////////////graphics Initialization
procedure InitGraph();
begin
  ClearWindow();
  //setBrushColor(clBlack);
  //setPenColor(clBlack);
  changeColor(random(34));
  initWindow(10,10,690,512);
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

///////////////////////////////drawing menu
procedure menuDraw(x,y,mb : integer);
begin
  if (mb = 1) then
  begin
    if ((x > 20) and (x < 100) and ((y < 100) and (y > 20)) and (inputer.getState() = 1))then
    begin
      inputer.ToNextLevel(2);
      inputer.drawLevel();
    end else if ((x > 20) and (x <100) and ( y > 150) and (y <230)) then
      endOfInput := true
    else if ((x > 120) and (x < 200) and (y > 20) and (y < 100) and (inputer.getState() = 2))then
    begin
      inputer.ToNextLevel(4);
      inputer.drawLevel();
    end else if ((x > 120) and (x < 200) and (y > 150) and (y < 230) and (inputer.getState() = 2)) then
    begin
      inputer.ToNextLevel(3);
      inputer.drawLevel();
    end else if ((inputer.getState() = 3) and (x > 250) and (x<330) and (y > 170) and (y<210)) then
    begin
      inputer.setNumber(1);
    end else if ((inputer.getState() = 3) and (x > 250) and (x<330) and (y > 270) and (y<310)) then
    begin
      inputer.setNumber(2);
    end else if ((inputer.getState() = 3) and (x > 250) and (x<330) and (y > 370) and (y<410)) then
    begin
      inputer.setNumber(3);
    end else if ((y > 20) and ( y < 100)) and (( (x > 220) and  (x < 300) ) or ((x > 320) and  (x < 400)) or ((x > 420) and  (x < 500)) or ((x > 520) and  (x < 600))) then 
    begin
      inputer.readingK(Kmin,x,y);
    end;
  end;
end;
///////////////////////////////

///////////////////////////////Inputing some data
procedure DataInputing(var k : integer; var f : integer);
begin
  Kmin := 6000;
  endOfInput := false;
  inputer.ToNextLevel(1);
  inputer.drawLevel();
  onMouseDown := menuDraw;
  while (not(endOfInput)) do
  begin
    
  end;
  k := Kmin;
  f := inputer.getFlag();
  ClearWindow();
  sleep(100);
  onMouseDown := nil;
end;
///////////////////////////////

///////////////////////////////Coordinate system for on-line drawing
procedure drawAxesSystem();
var
  text : textABC;
  i : integer;
begin
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