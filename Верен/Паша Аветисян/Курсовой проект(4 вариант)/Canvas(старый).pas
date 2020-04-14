unit Canvas;

interface

uses GraphABC,ABCObjects,Data;

type
  menu = class
    private
      state : integer;
      isFirst : boolean;
      isSecond : boolean;
      flag : integer;
    public
      constructor create();
      begin
        state := 0;
        isFirst := false;
        isSecond := false;
        flag := 1;
      end;
      procedure drawLevel();
      var
        text : TextABC;
      begin
        case state of
          1 : begin
                setBrushColor(clBlue);
                setPenColor(clBlue);
                fillRectangle(20,20,100,100);
                fillRectangle(20,150,100,230);
                text := new TextABC(25,25,15,'Settings',clBlack);
                text := new TextABC(25,155,15,'Go...', clBlack);
              end;
          2 : begin
                setBrushColor(clBlue);
                setPenColor(clBlue);
                Line(100,60,120,60);
                Line(100,60,120,190);
                fillRectangle(120,20,200,100);
                fillRectangle(120,150,200,230);
                text := new TextABC(125,25,15,'Kmin',clBlack);
                text := new TextABC(125,155,8,'Chose source',clBlack);
                //text := new TextABC(125,160,8,'true - oneLineSet',clBlack);
                //text := new TextABC(125,165,8,'false -everyLineSet',clBlack);
              end;
          3 : begin
                setBrushColor(clGreen);
                setPenColor(clGreen);
                Line(200,190,250,180);
                Line(200,190,250,280);
                Line(200,190,250,380);
                Line(200,190,250,480);
                fillRectangle(250,170,330,210);
                fillRectangle(250,270,330,310);
                fillRectangle(250,370,330,410);
                fillRectangle(250,470,330,510);
                text := new TextABC(260,180,15,'First',clBlack);
                text := new TextABC(260,280,15,'Second',clBlack);
                text := new TextABC(260,380,15,'Third',clBlack);
                text := new TextABC(260,480,15,'Forth',clBlack);
              end;
          4 : begin
                setBrushColor(clBlue);
                setPenColor(clBlue);
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

///////////////////////////////////////headers 
procedure main(data : repository);
procedure InitGraph();
procedure draw(num,fail : real);
procedure DataInputing(var k : integer; var f : integer);
procedure changeColor(iter : integer);
procedure drawAxesSystem();
///////////////////////////////////////

VAR
  mainData : repository;
  state : integer;
  inputer : menu := new menu();
  endOfInput : boolean;
  Kmin :integer;
  Smin : string;
  FlagMin : boolean;
  
implementation
procedure drawMenu();
var
  choice1,choice2 : TextABC;
  choice3 : TextABC := new TextABC(10,-10,50,'choice1',clRed);
begin
  Window.Clear(clIndigo);
  setPenColor(clRed);
  drawRectangle(10,10,280,30);
  choice1 := TextABC.Create(10,10,10,'«ависимость отказов от первого источника',clRed);
  drawRectangle(10,60,280,80);
  choice2 := TextABC.Create(10,60,10,'«ависимость отказов от второго источника',clRed);
  drawRectangle(10,110,280,130);
  choice3 := TextABC.Create(10,110,10,'«ависимость средненего количество за€вок в пам€ти',clRed);
  choice3.TransparentBackground := true;
end;

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

{procedure keyDown(key : integer);
begin
  writeln('OOOOOOOOOO');
  if (key >= ord('0')) and (key <= ord('9')) then
    Smin := Smin + chr(key);
  if (key = 13) then
    flagMin := True;
end;

procedure Reading();
var
  ch : char;
begin
  {CLearWindow();
  flagMin := false;
  onKeyDown := KeyDown;
  while (not(flagMin)) do
  begin
    flagMin := false;
  end;
  Kmin := strToInt(Smin);
  while (ch <> #13) do
  begin
    ch := ReadKey();
    if (ch in ['0'..'9']) then
      Smin := Smin + ch;
  end;
end;}

procedure drawSystem();
var
  i : integer;
  text : TextABC;
begin
  Window.Clear(clPink);
  setPenColor(clMaroon);
  
  //Ox
  Line(40,470,665,470);
  Line(665,470,655,475);
  Line(665,470,655,465);
  text := new TextABC(640,450,10,'lambda',clBlack);
  
  //Oy
  Line(40,470,40,10);
  Line(40,10,35,25);
  Line(40,10,45,25);
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

procedure FailureOfFirstSource();
var
  i : integer;
  max,temp : integer;
begin
  max := mainData.getClaim(1,1,1);
  for i := 2 to 11 do
  begin
    temp := mainData.getClaim(1,i,1);
    if (temp > max) then
      max := temp;
  end;
  DrawSystem();
  setBrushColor(clDarkOrchid);
  setPenColor(clDarkOrchid);
  moveTo(40,470);
  for i:=1 to 11 do
  begin
    fillCircle(60+(i-1)*round(640/11),490-round(480*mainData.getClaim(1,i,1)/max),5);
    LineTo(60+(i-1)*round(640/11),490-round(480*mainData.getClaim(1,i,1)/max));
  end;
  drawArrow(645,5);
end;

procedure FailureOfSecondSource();
var
  i : integer;
  max,temp : integer;
begin
  max := mainData.getClaim(2,1,1);
  for i := 2 to 11 do
  begin
    temp := mainData.getClaim(2,i,1);
    if (temp > max) then
      max := temp;
  end;
  DrawSystem();
  setBrushColor(clDarkOrchid);
  setPenColor(clDarkOrchid);
  moveTo(40,470);
  for i:=1 to 11 do
  begin
    fillCircle(60+(i-1)*round(640/11),490-round(480*mainData.getClaim(2,i,1)/max),5);
    LineTo(60+(i-1)*round(640/11),490-round(480*mainData.getClaim(2,i,1)/max));
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
  DrawSystem();
  moveTo(40,470);
  for i:=1 to 11 do
  begin
    fillCircle(60+(i-1)*round(640/11),490-round(480*mainData.getterCount(i)/max),5);
    LineTo(60+(i-1)*round(640/11),490-round(480*mainData.getterCount(i)/max));
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
          state := 2;
          FailureOfFirstSource();
        end;
        if (x > 10) and (x < 280) and (y > 60) and (y < 80) then
        begin
          state := 2;
          FailureOfSecondSource();
        end;
        if (x > 10) and (x < 280) and (y > 110) and (y < 130) then
        begin
          state := 2;
          MiddleCount();
        end;
      end;
      2 :
      begin
        if (x > 645) and (x < 665) and (y > 5) and (y <21) then
        begin
          state := 1;
          drawMenu();
        end;
      end;
    end;
  end;
end;

procedure main(data : repository);
begin
  state := 1;
  mainData := data;
  drawMenu();
  onMouseDown := mouseDown;
end;

///////////////////////////////graphics Initialization
procedure InitGraph();
begin
  ClearWindow();
  setBrushColor(clBlack);
  setPenColor(clBlack);
  initWindow(10,10,690,512);
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
     { //read(Kmin);
      Kmin := 1000;
      {Reading();}
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
    end else if ((inputer.getState() = 3) and (x > 250) and (x<330) and (y > 470) and (y<510)) then
    begin
      inputer.setNumber(4);
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
  Kmin := 1000;
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