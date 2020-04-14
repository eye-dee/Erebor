unit Canvas;

interface
uses GraphABC,ABCObjects,Data;


///////////////////////////////////////headers 
procedure main(data : repository);
procedure InitGraph();
procedure draw(num,fail : real);
procedure DataInputing(var k : integer; var f : boolean);
procedure changeColor(iter : integer);
procedure drawAxesSystem();
procedure ClearScreen();
procedure drawMenuBack();
procedure drawPara(x1,y1,x2,y2 : integer);
procedure DrawChoosing(x0,y0 : real);
procedure drawZvezd(x,y : integer);
///////////////////////////////////////

type
  menu = class
    private
      state : integer; //pole opredelyauchee sostoyanie
      flag : boolean;  //pole opredelyauchee rezhim risovaniya
    public  
      constructor create();
      begin
        state := 0;
        flag := false;
      end;
      procedure drawLevel();
      var
        text : TextABC;
      begin
        case state of
          1 : begin
                setBrushColor(clGreen);
                setPenColor(clGreen);
                //fillRectangle(220,120,350,200);
                //fillRectangle(220,250,300,330);
                fillCircle(265,135,60);
                fillCircle(465,435,60);
                text := new TextABC(225,125,15,'Настройки',clRed);
                text := new TextABC(425,425,15,'Запуск', clRed);
              end;
          2 : begin
                setBrushColor(clBrown);
                setPenColor(clBrown);
                Line(350,160,370,160);
                Line(350,160,370,290);
                fillcircle(420,140,60);
                fillcircle(420,270,60);
                text := new TextABC(375,125,11,'К минимальное',clBlack);
                text := new TextABC(375,255,8,'Режим рисования',clBlack);
                text := new TextABC(375,275,8,'каждая линия',clBlack);
                text := new TextABC(375,295,8,'или по одной',clBlack);
              end;
          3 : begin
                setBrushColor(clBrown);
                setPenColor(clBrown);
                Line(450,290,500,290);
                Line(450,290,500,350);
                fillcircle(520,280,40);
                fillcircle(520,360,40);
                text := new TextABC(510,280,15,'True',clBlack);
                text := new TextABC(510,340,15,'False',clBlack);
              end;
           4 : begin
                setBrushColor(clBrown);
                setPenColor(clBrown);
                fillcircle(240,20,30);
                fillcircle(340,20,30);
                fillcircle(440,20,30);
                fillcircle(540,20,30);
                text := new TextABC(225,30,10,'50',clBlack);
                text := new TextABC(325,30,10,'1000',clBlack);
                text := new TextABC(425,30,10,'2000',clBlack);
                text := new TextABC(525,30,10,'3000',clBlack);
               end;
        end;
      end;
      procedure ToNextLevel(st : integer);
      begin
          state := st;
      end;
      function getState() : integer;
      begin
        getState := state;
      end;
      procedure setFlag(fl : boolean);
      begin
        flag := fl;
        clearScreen();
        state := 1;
        drawLevel();
        state := 2;
        DrawLevel();
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
        clearScreen();
        state := 1;
        drawLevel();
        state := 2;
        DrawLevel();
      end;
      function getFlag() : boolean;
      begin
        getFlag := flag;
      end;
end;

VAR
  mainData : repository;
  state : integer;
  inputer : menu := new menu();
  endOfInput : boolean;
  Kmin :integer;
  
implementation
procedure drawZvezd(x,y : integer);
begin
  moveTo(x,y);
  LineTo(x+2,y+5);
  lineTo(x+4,y);
  lineTo(x-1,y+2);
  lineTo(x+6,y+2);
  lineTo(x,y);
end;

procedure drawPara(x1,y1,x2,y2 : integer);
begin
  drawRectangle(x1,y1,x2,y2);
  Line(x1,y2,x1+10,y2+10);
  Line(x1+10,y2+10,x2+10,y2+10);
  Line(x2,y2,x2+10,y2+10);  
  Line(x2,y1,x2+10,y1+10);
  Line(x2+10,y1+10,x2+10,y2+10);
end;

procedure drawMenu();
var
  choice : TextABC;
begin
  drawMenuBack();
  setPenColor(clRed);
  drawPara(10,10,280,30);
  
  choice := new TextABC(10,10,10,'Зависимость отказов от первого источника',clRed);
  drawPara(10,60,280,80);
  
  choice := new TextABC(10,60,10,'Зависимость отказов от второго источника',clRed);
  drawPara(10,110,280,130);
  
  choice := new  TextABC(10,110,10,'Зависимость средненего количество заявок в памяти',clRed);
  choice.TransparentBackground := true;
  
  choice := new TextABC(10,160,10,'Таблица результатов',clRed);
  drawPara(10,160,280,180);
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

procedure drawMenuBack();
var
  p : pictureABC := new PictureABC(0,0,'back3.jpg');
begin

end;

procedure drawChoosing(x0,y0 : real);
var
  x1,x2: integer;
  y : integer;
  p : integer;
begin
  x1:= round(x0);
  x2 := x1;
  while (x1 < round(x0) + 100) do
  begin
    for p := 1 to 100 do
    begin
      changeColor(random(15));
      y := round(0.01*(x1-x0)*(x1-x0-5) + y0 + 100 + random(50));
      fillCircle(x1 + random(5),y-100, 1);
      y := round(0.01*(x2-x0)*(x2-x0+5) + y0 + 100 + random(50));
      fillCircle(x2 - random(5),y-100, 1); 
    end;
    x1 := x1 + 5;
    x2 := x2 - 5;
    Sleep(5);
  end;
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
  text := new TextABC(640,450,10,'Лямбда',clBlack);
  
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
  DrawSystem(1,0);
  setBrushColor(clDarkOrchid);
  setPenColor(clDarkOrchid);
  //moveTo(40,470);
  for i:=1 to 11 do
  begin
    drawZvezd(60+(i-1)*round(640/11),490-round(480*mainData.getClaim(1,i,1)/max));
    //LineTo(60+(i-1)*round(640/11),490-round(480*mainData.getClaim(1,i,1)/max));
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
  DrawSystem(1,0);
  setBrushColor(clDarkOrchid);
  setPenColor(clDarkOrchid);
  //moveTo(40,470);
  for i:=1 to 11 do
  begin
    drawZvezd(60+(i-1)*round(640/11),490-round(480*mainData.getClaim(2,i,1)/max));
    //LineTo(60+(i-1)*round(640/11),490-round(480*mainData.getClaim(2,i,1)/max));
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
  //moveTo(40,470);
  for i:=1 to 11 do
  begin
    drawZvezd(60+(i-1)*round(640/11),520-round(480*mainData.getterCount(i)/max));
    //LineTo(60+(i-1)*round(640/11),520-round(480*mainData.getterCount(i)/max));
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
  setBrushColor(clBlack);
  setPenColor(clBlack);
  window.Clear(clPink);
  for i := 1 to 6 do
  begin
    if (i mod 3 = 0) then
      line(98*i,0,98*i,512)
  end;
  line(50,30,588,30);
  for i := 1 to 11 do
  begin
      line(0,30+40*i,690,30+40*i);
  end;
  
  Line(50,0,50,512);

  text := new TextABC(110,10,12,'Источник1',clBlack);
  text := new TextABC(10,10,12,'Lam',clBlack);
  text := new TextABC(404,10,12,'Источник2',clBlack);
  text := new TextABC(615,20,12,'Буфер',clBlack);
  text := new TextABC(50,40,10,'Вероятность отказа',clBlack);
  text := new TextABC(304,40,10,'Вероятность отказа',clBlack);
  for i := 1 to 11 do
  begin
    text := new TextABC(10,35+40*i,12,intToStr(round((2 + (i-1)*0.1)*10) div 10) + '.' + intToStr(round((0.5 + (i-1)*0.1)*10) mod 10));
  
    text := new TextABC(60,35+40*i,12,'0.'+intTostr(round(mainData.getClaim(1,i,1)/mainData.getClaim(1,i,3)*1000)),clBlack);
    
    text := new TextABC(319,35+40*i,12,'0.' + intTostr(round(mainData.getClaim(2,i,1)/mainData.getClaim(2,i,3)*1000)),clBlack);
    temp := mainData.getterCount(i);
    int := round(temp);
    frac := round((temp-int)*1000);
    if (frac < 0) then
    begin
      int := int - 1;
      frac := 1000+frac;
    end;
    text := new TextABC(613,35+40*i,12,intToStr(int) + '.' + intToStr(frac),clBlack);
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
          DrawChoosing(x,y);
          state := 2;
          FailureOfFirstSource();
        end else if (x > 10) and (x < 280) and (y > 60) and (y < 80) then
        begin
          DrawChoosing(x,y);
          state := 2;
          FailureOfSecondSource();
        end else if (x > 10) and (x < 280) and (y > 110) and (y < 130) then
        begin
          DrawChoosing(x,y);
          state := 2;
          MiddleCount();
        end else if (x > 10) and (x < 280) and (y > 160) and (y < 180) then
        begin
          DrawChoosing(x,y);
          state := 2;
          drawTable();
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

////////////////////////////clear
procedure clearScreen();
var
  p : pictureABC := new PictureABC(0,0,'back.jpg');
begin
  
end;
///////////////////////////

///////////////////////////////graphics Initialization
procedure InitGraph();
begin
  ClearScreen();
  setBrushColor(clBlack);
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
    if ((x > 220) and (x < 350) and ((y < 200) and (y > 120)) and (inputer.getState() = 1))then
    begin
      inputer.ToNextLevel(2);
      inputer.drawLevel();
    end else if ((x > 430) and (x < 480) and ( y > 410) and (y < 480)) then
      endOfInput := true
    else if ((x > 370) and (x < 450) and (y > 120) and (y < 200) and (inputer.getState() = 2))then
    begin
      //read(Kmin);
      inputer.ToNextLevel(4);
      inputer.drawLevel();
    end else if ((x > 370) and (x < 450) and (y > 250) and (y < 330) and (inputer.getState() = 2)) then
    begin
      inputer.ToNextLevel(3);
      inputer.drawLevel();
    end else if ((inputer.getState() = 3) and (x > 500) and (x<570) and (y > 330) and (y<380)) then
    begin
      drawChoosing(x,y);
      inputer.setFlag(false);
    end else if ((inputer.getState() = 3) and (x > 500) and (x<570) and (y > 270) and (y<320)) then
    begin
      drawChoosing(x,y);
      inputer.setFlag(true); 
    end else if ((y > 20) and ( y < 100)) and (( (x > 220) and  (x < 300) ) or ((x > 320) and  (x < 400)) or ((x > 420) and  (x < 500)) or ((x > 520) and  (x < 600))) then 
    begin
      drawChoosing(x,y);
      inputer.readingK(Kmin,x,y);
    end;
  end;
end;
///////////////////////////////

///////////////////////////////Inputing some data
procedure DataInputing(var k : integer; var f : boolean);
begin
  clearScreen();
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
  p : pictureABC := new PictureABC(0,0,'back2.jpg');
  text : textABC;
  i : integer;
begin

  // Ox
  text := new TextABC(610,480,10,'Кол(1)',clBlack);
  
  // Oy
  text := new TextABC(15,10,10,'P',clBlack);
  
  for i := 1 to 9 do
  begin
    line(round(640/10*i),465,round(640/10*i),465);
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