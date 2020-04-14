unit Canvas;

interface

uses GraphABC,ABCObjects,Data,FUNC_MOD;

const
  sourceCount = 3;
  
/////////////////////////////////////
procedure drawArrow(x,y : integer);
procedure InitGraph();
procedure drawTable(var mainData : repository; l : real);
procedure draw(num,fail : real; kmin : integer);
procedure drawAxesSystem(kmin : integer);
procedure changeColor(iter : integer);
procedure FailureOfSource(var MainData : repository;j : integer);  //зависимость отказов источника jSS
procedure drawSystem(v : integer; max : real);
/////////////////////////////////////

type
  MenuClass = class
    private
      state : integer;
      Kmin : integer;
      lam : lamMas;
      tau : real;
      reading : boolean;
      flagReading : integer;
      name : array [1..5] of string;
      modelling : boolean;
      drawFlag : integer;
    public
      constructor create();
      begin
        Kmin := 1000;
        state := 1;
        lam[1] := 2.0;
        lam[2] := 1.0;
        lam[3] := 1.0;
        tau := 1.0;
        reading := false;
        drawFlag := 1;
        flagReading := -1;
        name[1] := 'Kmin';
        name[2] := 'Lam1';
        name[3] := 'Lam2';
        name[4] := 'Lam3';
        name[5] := 'Tau';
        modelling := false;
      end;
      procedure draw();
      var
        text : TextABC;
        temp : real;
        frac : real;
      begin
        setBrushColor(clWhite);
        setPenColor(clBlack);
        if(reading) then
        begin
          Window.clear(clYellow);
          
          drawArrow(400,50);
          
          setBrushColor(clWhite);
                   
          case flagReading of
            1 : begin
                  temp := Kmin;
                end;
            2 : begin
                  temp := lam[1];
                end;
            3 : begin
                  temp := lam[2];
                end;
            4 : begin
                  temp := lam[3];
                end;
            5 : begin
                  temp := tau;
                end;
          end;
          
          fillRectangle(100,100,200,200);
          Rectangle(100,100,200,200);
          if (flagReading >1) then
            text := new TextABC(105,105,10,intToStr(floor(temp)) + '.' + intToStr(round((temp - floor(temp))*10)))
          else
            text := new TextABC(105,105,10,intToStr(floor(temp)));
          text := new TextABC(60,60,15,name[flagReading]);
          
          fillRectangle(220,120,240,140);
          Rectangle(220,120,240,140);
          Line(225,135,230,125);
          Line(230,125,235,135);
          
          fillRectangle(220,150,240,170);         
          Rectangle(220,150,240,170);
          Line(225,155,230,165);
          Line(230,165,235,155);
          
          if (flagReading > 1) then
          begin
            fillRectangle(250,120,270,140);
            Rectangle(250,120,270,140);
            Line(255,135,260,125);
            Line(260,125,265,135);
            
            fillRectangle(250,150,270,170);         
            Rectangle(250,150,270,170);
            Line(255,155,260,165);
            Line(260,165,265,155);               
          end;
        end else
        begin
          if (state = 1) then
          begin
            Window.clear(clYellow);
            
            fillRectangle(0,100,160,200);
            Rectangle(0,100,160,200);
            text := new TextABC(20,120,12,'Выбрать номер',clBlack);
            text := new TextABC(20,140,12,'источника',clBlack);
            fillRectangle(160,100,320,200);
            Rectangle(160,100,320,200);
            text := new TextABC(180,120,14,'Моделировать',clBlack);
            fillRectangle(320,100,480,200);
            Rectangle(320,100,480,200);
            text := new TextABC(340,120,12,'Настройки',clBlack);
            
            if (drawFlag = 1) then
              setBrushColor(clRed);
            fillRectangle(20,220,140,240);
            Rectangle(20,220,140,240);
            text := new TextABC(30,225,10,'Источник 1',clBlack);
            setBrushColor(clWhite);
            if (drawFlag = 2) then
              setBrushColor(clRed);
            fillRectangle(20,260,140,280);
            Rectangle(20,260,140,280);
            text := new TextABC(30,265,10,'Источник 2',clBlack);
            setBrushColor(clWhite);
            if (drawFlag = 3) then
              setBrushColor(clRed);
            fillRectangle(20,300,140,320);
            Rectangle(20,300,140,320);
            text := new TextABC(30,305,10,'Источник 3',clBlack);
            setBrushColor(clWhite);
    
            fillRectangle(340,220,460,240);
            Rectangle(340,220,460,240);
            text := new TextABC(350,225,10,'Kmin',clBlack);
            fillRectangle(340,260,460,280);
            Rectangle(340,260,460,280);
            text := new TextABC(350,265,10,'Lam1',clBlack);
            fillRectangle(340,300,460,320);
            Rectangle(340,300,460,320);
            text := new TextABC(350,305,10,'Lam2',clBlack);
            fillRectangle(340,340,460,360);
            Rectangle(340,340,460,360);
            text := new TextABC(350,345,10,'Lam3',clBlack);
            fillRectangle(340,380,460,400);
            Rectangle(340,380,460,400);
            text := new TextABC(350,385,10,'Tau',clBlack);
          end else 
          begin
            Window.clear(clYellow);
          
            fillRectangle(0,100,160,200);
            Rectangle(0,100,160,200);
            text := new TextABC(20,120,12,'График зависимости',clBlack);
            text := new TextABC(20,140,12,'вероятности отказов',clBlack);
            fillRectangle(160,100,320,200);
            Rectangle(160,100,320,200);
            text := new TextABC(180,120,14,'Таблица',clBlack);
            fillRectangle(320,100,480,200);
            Rectangle(320,100,480,200);
            text := new TextABC(340,120,12,'Параметры',clBlack);
            
            fillRectangle(20,220,140,240);
            Rectangle(20,220,140,240);
            text := new TextABC(30,225,10,'Источник 1',clBlack);
            fillRectangle(20,260,140,280);
            Rectangle(20,260,140,280);
            text := new TextABC(30,265,10,'Источник 2',clBlack);
            fillRectangle(20,300,140,320);
            Rectangle(20,300,140,320);
            text := new TextABC(30,305,10,'Источник 3',clBlack);
 
          end;
        end;
      end;
      procedure incKmin();
      begin
        Kmin := Kmin + 10;
      end;
      procedure incLam(i : integer);
      begin
        if (i < 4) then
          lam[i] := lam[i] + 1.0
        else
          tau := tau + 1.0;
      end;
      procedure incFracLam(i : integer);
      begin
        if (i < 4) then
          lam[i] := lam[i] + 0.1
        else
          tau := tau + 0.1;
      end;
      procedure decKmin();
      begin
        Kmin := Kmin - 10;
      end;
      procedure decLam(i : integer);
      begin
        if (i < 4) then
          lam[i] := lam[i] - 1.0
        else
          tau := tau - 1.0;
      end;
      procedure decFracLam(i : integer);
      begin
        if (i < 4) then
          lam[i] := lam[i] - 0.1
        else
          tau := tau - 0.1;
      end;
      procedure setReading(i : integer);
      begin
        flagReading := i;
        reading := true;
      end;
      procedure endReading();
      begin
        flagReading := -1;
        reading := false;
      end;
      procedure StartModelling();
      begin
        modelling := true;  
      end;
      function isModelling() : boolean;
      begin
        isModelling := modelling;
      end;
      function isReading() : boolean;
      begin
        isReading := reading;
      end;
      procedure incCur();
      begin
        if (flagReading = 1) then
          incKmin()
        else
          incLam(flagReading - 1);
      end;
      procedure decCur();
      begin
        if (flagReading = 1) then
          decKmin()
        else
          decLam(flagReading - 1);        
      end;
      procedure incCurFrac();
      begin
        if (flagReading > 1) then
          incFracLam(flagReading - 1);
      end;
      procedure decCurFrac();
      begin
        if (flagReading > 1) then
          decFracLam(flagReading - 1);       
      end;
      procedure setDrawFlag(i : integer);
      begin
        if (i > 0) and (i < 4) then
          drawFlag := i;
      end;
      function getState() : integer;
      begin
        getState := state;
      end;
      function getDrawFlag() :integer;
      begin
        getDrawFlag := drawFlag;
      end;
      function getKmin() : integer;
      begin
        getKmin := Kmin;
      end;
      function getLams(i : integer) : real;
      begin
        if( i < 4) then
          getLams := lam[i]
        else
          getLams := tau;
      end;
      procedure toNextState();
      begin
        state := state + 1;
      end;
      procedure toPrevState();
      begin
        state := state - 1;
      end;
  end;
  
procedure settings(var temp : MenuClass);

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

///////////////////////////////////on-line drawing
procedure draw(num,fail : real; kmin : integer);
begin
  if (num <> 0) then
    fillCircle(40+round(num*690/kmin),470-round(fail*480/num),1);
end;
///////////////////////////////////

///////////////////////////////Coordinate system for on-line drawing
procedure drawAxesSystem(kmin: integer);
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

procedure FailureOfSource(var MainData : repository;j : integer);  //зависимость отказов источника j
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

procedure drawTable(var mainData : repository;l : real);
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
  for i := 1 to 4 do
  begin
      line(30+118*i,0,30+118*i,512)
  end;
  line(0,30,390,30);
  for i := 1 to 11 do
  begin
    line(0,30+40*i,500,30+40*i);
  end;
  
  line(50,0,50,512);
  
  text := new TextABC(10,10,12,'Lam',clBlack);
  text := new TextABC(60,10,10,'Источник1',clBlack);
  text := new TextABC(188,10,10,'Источник2',clBlack);
  text := new TextABC(316,10,10,'Источник3',clBlack);
  
  text := new TextABC(450,20,15,'koef',clBlack);
  
  text := new TextABC(60,40,12,'Вероятность           отказа',clBlack);
  for i := 1 to 11 do
  begin
    text := new TextABC(10,35+40*i,12,intToStr(round((l + (i-1)*0.2)*10) div 10) + '.' + intToStr(round(((i-1)*0.2)*10) mod 10));
    text := new TextABC(55,35+40*i,12,'0.'+intTostr(round(mainData.getClaim(1,i,1)/mainData.getClaim(1,i,3)*1000)),clBlack);
    text := new TextABC(193,35+40*i,12,'0.' + intTostr(round(mainData.getClaim(2,i,1)/mainData.getClaim(2,i,3)*1000)),clBlack);
    text := new TextABC(311,35+40*i,12,'0.' + intTostr(round(mainData.getClaim(3,i,1)/mainData.getClaim(3,i,3)*1000)),clBlack);
    
      temp := mainData.getterCount(i);
      int := round(temp);
      frac := round((temp-int)*1000);
      if (frac < 0) then
      begin
        int := int - 1;
        frac := 1000+frac;
      end;
      text := new TextABC(430,35+40*i,12,intToStr(int) + '.' + intToStr(frac),clBlack);
  end;
  drawArrow(645,5);
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

procedure settings(var temp : MenuClass);
var
  name : array [1..5] of string;
  value : array [1..5] of real;
  i :integer;
  text : textABC;
begin
  setBrushColor(clWhite);
  setPenColor(clBlack);
  
  Window.Clear(clYellow);
  
  name[1] := 'Kmin';
  name[2] := 'Lam1';
  name[3] := 'Lam2';
  name[4] := 'Lam3';
  name[5] := 'Tau';
  
  value[1] := temp.getKmin();
  for i:= 2 to 5 do
  begin
    value[i] := temp.getLams(i-1);
  end;
  
  for i := 1 to 5 do
  begin
    text := new TextABC(20,20 + 40*i,10,name[i]);
    fillRectangle (60,20 + 40*i,120,40 + 40*i);
    Rectangle (60,20 + 40*i,120,40 + 40*i);
    text := new TextABC(65,25 + 40*i,10,intTostr(floor(value[i])) + '.' + intToStr(round((value[i] - floor(value[i]))*10)));
  end;
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

BEGIN
END.