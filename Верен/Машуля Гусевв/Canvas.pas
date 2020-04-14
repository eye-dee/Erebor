unit Canvas;

interface

uses
  GraphABC, ABCObjects, Data;

type
  menu = class
  private 
    state: integer;
    flag: integer;
  public 
    constructor create();
    begin
      state := 0;
      flag := 1;
    end;
    
    procedure drawLevel();
    var
      text: TextABC;
    begin
      case state of
        1:
          begin
            setBrushColor(clRed);
            setPenColor(clRed);
            fillRectangle(10, 20, 110, 60);
            fillEllipse(10, 120, 100, 210);
            FloodFill(26, 26, clSilver);
            text := new TextABC(25, 30, 15, 'Settings', clBlack);
            text := new TextABC(25, 155, 15, '  Play', clBlack);
          end;
        
        2:
          begin
            setBrushColor(clSilver);
            setPenColor(clSilver);
            Line(110, 60, 120, 60);
            Line(110, 60, 120, 190);
            fillRectangle(120, 20, 200, 60);
            fillRectangle(120, 150, 200, 190);
            text := new TextABC(125, 25, 15, 'K', clBlack);
            text := new TextABC(140, 33, 10, 'min', clBlack);
            text := new TextABC(125, 155, 15, 'Sourse', clBlack);
          end;
        3:
          begin
            setBrushColor(clSilver);
            setPenColor(clSilver);
            Line(200, 190, 250, 180);
            Line(200, 190, 250, 280);
            Line(200, 190, 250, 380);
            Line(200, 190, 250, 480);
            fillRectangle(250, 170, 340, 210);
            fillRectangle(250, 270, 340, 310);
            fillRectangle(250, 370, 340, 410);
            fillRectangle(250, 470, 340, 510);
            text := new TextABC(260, 180, 15, 'First', clBlack);
            text := new TextABC(260, 280, 15, 'Second', clBlack);
            text := new TextABC(260, 380, 15, 'Third', clBlack);
            text := new TextABC(260, 480, 15, 'Forth', clBlack);
          end;
        4:
          begin
            setBrushColor(clSilver);
            setPenColor(clSilver);
            fillRectangle(220, 20, 300, 60);
            fillRectangle(320, 20, 400, 60);
            fillRectangle(420, 20, 500, 60);
            fillRectangle(520, 20, 600, 60);
            text := new TextABC(225, 30, 10, '50', clBlack);
            text := new TextABC(325, 30, 10, '1000', clBlack);
            text := new TextABC(425, 30, 10, '2000', clBlack);
            text := new TextABC(525, 30, 10, '3000', clBlack);
          end;
      end;
    end;
    
    procedure ToNextLevel(st: integer);
    begin
        //if (st > state) then
      state := st;
    end;
    
    function getState() : integer;
    begin
      getState := state;
    end;
    
    procedure ReadingK(var K: integer; x, y: integer);
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
    
    procedure setNumber(f1: integer);
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
    state: integer;
  public 
    constructor create();
    begin
      state := 1;
    end;
    
    procedure toLevel(s: integer);
    begin
      state := s;
    end;
    
    function getLevel() : integer;
    begin
      getLevel := state;
    end;
    
    procedure draw();
    var
      choice: TextABC;
    begin
      case state of
        1:
          begin
            Window.Clear(clBeige);
            setPenColor(clRed); 
            drawRectangle(10, 10, 680, 30);  
            drawRectangle(10, 10, 80, 30); 
            FloodFill(11, 11, clRed);
            setPenColor(clBlack); 
            drawEllipse(35, 15, 45, 25);
            FloodFill(40, 20, clBlack);
            setPenColor(clRed); 
            choice := new TextABC(290, 10, 10, ' Зависимость отказов', clBlack);
            
            drawRectangle(10, 110, 680, 130);
            drawRectangle(10, 110, 80, 130);
            FloodFill(11, 111, clRed);
            setPenColor(clBlack); 
            drawEllipse(35, 115, 45, 125);
            FloodFill(40, 120, clBlack);
            setPenColor(clRed);
            choice := new TextABC(240, 110, 10, ' Среднее время пребывания в системе', clBlack);
            
            choice.TransparentBackground := true;
            choice := new TextABC(290, 160, 10, ' Таблица результатов', clBlack);
            drawRectangle(10, 160, 680, 180);
            drawRectangle(10, 160, 80, 180);
            FloodFill(11, 161, clRed);
             setPenColor(clBlack); 
            drawEllipse(35, 165, 45, 175);
            FloodFill(40, 170, clBlack);
            
            
          end;
        2: 
          begin
            drawRectangle(10, 60, 100, 90);
            drawRectangle(110, 60, 200, 90);
            drawRectangle(210, 60, 300, 90);
            drawRectangle(310, 60, 400, 90);
            
            choice := new TextABC(15, 65, 12, 'источник 1', clRed);
            choice := new TextABC(115, 65, 12, 'источник 2', clRed);
            choice := new TextABC(215, 65, 12, 'источник 3', clRed);
            choice := new TextABC(315, 65, 12, 'источник 4', clRed);
          end;
      end;
    end;
  end;

//heads
procedure main(data: repository);
procedure InitGraph();
procedure draw(num, fail: real);
procedure DataInputing(var k: integer; var f: integer);
procedure changeColor(iter: integer);
procedure drawAxesSystem();


var
  mainData: repository;
  state: integer;
  inputer: menu := new menu();
  drawer: resultMenu := new resultMenu();
  endOfInput: boolean;
  Kmin: integer;

implementation

procedure drawArrow(x, y: integer);
var
  arr: array of point := new Point[7];
begin
  setBrushColor(clBlack);
  arr[0].X := x + 8;arr[0].Y := y + 0;
  arr[1].X := x + 0;arr[1].Y := y + 8;
  arr[2].X := x + 8;arr[2].Y := y + 16;
  arr[3].X := x + 8;arr[3].Y := y + 12;
  arr[4].X := x + 20;arr[4].Y := y + 12;
  arr[5].X := x + 20;arr[5].Y := y + 4;
  arr[6].X := x + 8;arr[6].Y := y + 4;
  fillClosedCurve(arr);
end;

procedure drawSystem(v: integer; max: real);
var
  i: integer;
  text: TextABC;
  temp: integer;
begin
  Window.Clear(clBeige);
  setPenColor(clBrown);
  
  //абсциса
  Line(40, 470, 665, 470);
  Line(665, 470, 655, 475);
  Line(665, 470, 655, 465);
  
  
  //ордината
  Line(40, 470, 40, 10);
  Line(40, 10, 35, 25);
  Line(40, 10, 45, 25);
  text := new TextABC(640, 450, 10, 'lambda', clBlack);
  
  case v of
    1:
      begin
        text := new TextABC(20, 10, 10, 'P', clBlack);
        for i := 1 to 11 do
        begin
          Line(60 + (i - 1) * round(630 / 11), 475, 60 + (i - 1) * round(630 / 11), 465);
          text := new TextABC(50 + (i - 1) * round(630 / 11), 480, 10, intToStr(4 + i) + '/10', clBlack);
        end;
        for i := 1 to 9 do
        begin
          Line(35, 450 - i * round(460 / 11), 45, 450 - i * round(460 / 11));
          text := new TextABC(15, 445 - i * round(460 / 11), 10, '0.' + intToStr(i), clBlack);
        end;
      end;
    2:
      begin
        temp := trunc(max) + 1;
        for i := 1 to temp do
        begin
          Line(35, 480 - i * round(450 / temp), 45, 480 - i * round(450 / temp));
          text := new TextABC(15, 480 - i * round(460 / temp), 10, intToStr(i), clBlack);
        end;
        for i := 1 to 11 do
        begin
          Line(60 + (i - 1) * round(630 / 11), 475, 60 + (i - 1) * round(630 / 11), 465);
          text := new TextABC(50 + (i - 1) * round(630 / 11), 480, 10, intToStr(4 + i) + '/10', clBlack);
        end;
      end;
  end;
end;


procedure FailureOfSource(j: integer);//зависимость отказов источника j
var
  i: integer;
  max, temp: integer;
begin
  max := mainData.getClaim(j, 1, 1);
  for i := 2 to 11 do
  begin
    temp := mainData.getClaim(j, i, 1);
    if (temp > max) then
      max := temp;
  end;
  max := round((mainData.getClaim(j, i, 1) / mainData.getClaim(j, i, 3))*1000);
  DrawSystem(1, 0);
  setBrushColor(clDarkOrchid);
  setPenColor(clDarkOrchid);
  moveTo(60 + round(640 / 11), 490 - round(480 * mainData.getClaim(j, i, 1) / max));
  for i := 2 to 11 do
  begin
    max := round((mainData.getClaim(j, i, 1) / mainData.getClaim(j, i, 3))*1000);
    // fillCircle(60+(i-1)*round(640/11),490-round(480*mainData.getClaim(j,i,1)/max),5);
    fillCircle(60 + (i - 1) * round(640 / 11), (11 - (round(max div 100))) * 42 - round(round(max mod 100) * 4.7 / 10), 5);
    //LineTo(60 + (i - 1) * round(640 / 11), 490 - round(480 * mainData.getClaim(j, i, 1) / max));
  end;
  drawArrow(645, 5);
end;

procedure MiddleCount();
var
  max, temp: real;
  i: integer;
begin
  max := mainData.getterCount(1, 1);
  for i := 2 to 11 do
  begin
    temp := mainData.getterCount(1, i);
    if (temp > max) then
      max := temp;
  end;
  DrawSystem(2, max);
  moveTo(40, 470);
  for i := 1 to 11 do
  begin
    fillCircle(60 + (i - 1) * round(640 / 11), 520 - round(400 * mainData.getterCount(1, i) / max), 5); //!
    LineTo(60 + (i - 1) * round(640 / 11), 520 - round(400 * mainData.getterCount(1, i) / max));
  end;
  drawArrow(645, 5);
end;

procedure drawTable();
var
  i, k, j: integer;
  text: TextABC;
  temp: real;
  int, frac: integer;
begin
  k := 0;
  window.SetSize(1100, 600); 
  setBrushColor(clBlack);
  setPenColor(clBlack);
  window.Clear(clBeige);
  
  for i := 1 to 8 do
  begin
    line(138 * i, 0, 138 * i, 512)
  end;
  line(0, 30, 1100, 30);
  for i := 1 to 12 do
  begin
    line(0, 30 + 40 * i, 1100, 30 + 40 * i);
  end;
  text := new TextABC(38, 10, 12, 'Источник1', clBlack);
  text := new TextABC(176, 10, 12, 'Источник2', clBlack);
  text := new TextABC(314, 10, 12, 'Источник3', clBlack);
  text := new TextABC(452, 10, 12, 'Источник4', clBlack);
  
  text := new TextABC(570, 40, 12, 'Ср.время 1', clBlack);
  text := new TextABC(708, 40, 12, 'Ср.время 2', clBlack);
  text := new TextABC(846, 40, 12, 'Ср.время 3', clBlack);
  text := new TextABC(984, 40, 12, 'Ср.время 4', clBlack);
  
  text := new TextABC(8, 40, 10, 'Вероятность отказа', clBlack);
  text := new TextABC(139, 40, 10, 'Вероятность отказа', clBlack);
  text := new TextABC(286, 40, 10, 'Вероятность отказа', clBlack);
  text := new TextABC(417, 40, 10, 'Вероятность отказа', clBlack);
  
  
  for i := 1 to 11 do
  begin
    text := new TextABC(25, 35 + 40 * i, 12, '0.' + intTostr(round(mainData.getClaim(1, i, 1) / mainData.getClaim(1, i, 3) * 1000)), clBlack);
    text := new TextABC(163, 35 + 40 * i, 12, '0.' + intTostr(round(mainData.getClaim(2, i, 1) / mainData.getClaim(2, i, 3) * 1000)), clBlack);
    text := new TextABC(301, 35 + 40 * i, 12, '0.' + intTostr(round(mainData.getClaim(3, i, 1) / mainData.getClaim(3, i, 3) * 1000)), clBlack);
    text := new TextABC(439, 35 + 40 * i, 12, '0.' + intTostr(round(mainData.getClaim(4, i, 1) / mainData.getClaim(4, i, 3) * 1000)), clBlack);
    
    k := 0;
    for j := 1 to 4 do
    begin
      temp := mainData.getterCount(j, i);
      int := round(temp);
      frac := round((temp - int) * 1000);
      if (frac < 0) then
      begin
        int := int - 1;
        frac := 1000 + frac;
      end;
      text := new TextABC(613 + k, 35 + 40 * i, 12, intToStr(int) + '.' + intToStr(frac), clBlack);
      k := k + 138;
    end;
  end;
  
  drawArrow(645, 5);
end;

procedure mouseDown(x, y, mb: integer);
begin
  if (mb = 1) then
  begin
    case state of 
      1:
        begin
          if (x > 10) and (x < 280) and (y > 10) and (y < 30) and (drawer.getLevel() = 1) then
          begin
            drawer.toLevel(2);
            drawer.draw();
          end else if (((x > 110) and (x < 200)) or ((x > 10) and (x < 100)) or ((x > 210) and (x < 300)) or ((x > 310) and (x < 400))) and (drawer.getLevel() = 2) and (y > 50) and (y < 110) then
          begin
            state := 1;
            if (x > 10) and (x < 100) then
            begin
              FailureOfSource(1);
              state := 2;
            end
            else if (x > 110) and (x < 200) then
            begin
              FailureOfSource(2);
              state := 2;
            end
            else if (x > 210) and (x < 300) then
            begin
              FailureOfSource(3);
              state := 2;
            end
            else if (x > 310) and (x < 400) then
            begin
              FailureOfSource(4);
              state := 2;
            end;
          end else if (x > 10) and (x < 280) and (y > 110) and (y < 130) and (drawer.getLevel() = 1) then
          begin
            state := 2;
            MiddleCount();
          end else if (x > 10) and (x < 280) and (y > 160) and (y < 180) and (drawer.getLevel() = 1) then
          begin
            state := 2;
        
            drawTable();
          end;
        end;
      2:
        begin
          if (x > 645) and (x < 665) and (y > 5) and (y < 21) then
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

procedure main(data: repository);
begin
  state := 1;
  mainData := data;
  drawer.draw();
  onMouseDown := mouseDown;
end;

//graphics initialization
procedure InitGraph();
begin
  ClearWindow();
  setBrushColor(clBlack);
  initWindow(10, 10, 690, 512);
end;

//рисовалка онлайн
procedure draw(num, fail: real);
begin
  if (num <> 0) then
    fillCircle(40 + round(num * 690 / kmin), 470 - round(fail * 480 / num), 1);
end;

//вариации на тему color
procedure changeColor(iter: integer);
begin
  case iter of
    1: setBrushColor(clFirebrick);
    2: setBrushColor(clForestGreen);
    3: setBrushColor(clGray);
    4: setBrushColor(clDarkSalmon);
    5: setBrushColor(clBrown);
    6: setBrushColor(clGreenYellow);
    7: setBrushColor(clNavy);
    8: setBrushColor(clOrange);
    9: setBrushColor(clPurple);
    10: setBrushColor(clSpringGreen);
    11: setBrushColor(clRed); 
  end;
end;


//drawing menu
procedure menuDraw(x, y, mb: integer);
begin
  if (mb = 1) then
  begin
    if ((x > 20) and (x < 100) and ((y < 100) and (y > 20)) and (inputer.getState() = 1)) then
    begin
      inputer.ToNextLevel(2);
      inputer.drawLevel();
    end else if ((x > 20) and (x < 100) and (y > 150) and (y < 230)) then
      endOfInput := true
    else if ((x > 120) and (x < 200) and (y > 20) and (y < 100) and (inputer.getState() = 2)) then
    begin
      inputer.ToNextLevel(4);
      inputer.drawLevel();
    end else if ((x > 120) and (x < 200) and (y > 150) and (y < 230) and (inputer.getState() = 2)) then
    begin
      inputer.ToNextLevel(3);
      inputer.drawLevel();
    end else if ((inputer.getState() = 3) and (x > 250) and (x < 330) and (y > 170) and (y < 210)) then
    begin
      inputer.setNumber(1);
    end else if ((inputer.getState() = 3) and (x > 250) and (x < 330) and (y > 270) and (y < 310)) then
    begin
      inputer.setNumber(2);
    end else if ((inputer.getState() = 3) and (x > 250) and (x < 330) and (y > 370) and (y < 410)) then
    begin
      inputer.setNumber(3);
    end else if ((inputer.getState() = 3) and (x > 250) and (x < 330) and (y > 470) and (y < 510)) then
    begin
      inputer.setNumber(4);
    end else if ((y > 20) and (y < 100)) and (((x > 220) and (x < 300) ) or ((x > 320) and (x < 400)) or ((x > 420) and (x < 500)) or ((x > 520) and (x < 600))) then 
    begin
      inputer.readingK(Kmin, x, y);
    end;
  end;
end;


//ввод данных
procedure DataInputing(var k: integer; var f: integer);
begin
  Kmin := 1000;
  endOfInput := false;
  inputer.ToNextLevel(1);
  inputer.drawLevel();
  onMouseDown := menuDraw;
  while (not (endOfInput)) do
  begin
    
  end;
  k := Kmin;
  f := inputer.getFlag();
  ClearWindow();
  sleep(100);
  onMouseDown := nil;
end;

//оси,реальное время
procedure drawAxesSystem();
var
  text: textABC;
  i: integer;
begin
  // абсциса
  Line(40, 470, 660, 470);
  Line(660, 470, 635, 475);
  Line(660, 470, 635, 465);
  text := new TextABC(610, 480, 10, 'Kol(1)', clBlack);
  
  // ордината
  Line(40, 470, 40, 10);
  Line(40, 10, 45, 20);
  Line(40, 10, 35, 20);
  text := new TextABC(15, 10, 10, 'P', clBlack);
  
  for i := 1 to 9 do
  begin
    line(round(640 / 10 * i), 475, round(640 / 10 * i), 465);
    text := new TextABC(round(640 / 10 * i) - 10, 476, 10, intToStr(round(kmin / 10 * i)), clBlack);
  end;
  
  for i := 1 to 9 do
  begin
    line(35, 48 * i, 45, 48 * i);
    text := new TextABC(15, 475 - 48 * i, 10, '0.' + intToStr(i), clBlack);
  end;
end;

begin
END. 