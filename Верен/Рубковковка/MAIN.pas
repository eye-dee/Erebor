program main;
uses graph,crt,func_mod,CMO;
type
  tarr1=array[1..6] of string;
  tarr2=array[1..5] of tarr1;
procedure printing(x,y:integer; a:tarr2);
var
  i,j:integer;
begin
  SetTextStyle(0,horizdir,1);
  SetFillStyle(solidfill, 7);
  SetColor(15);
  for i:=1 to 5 do
  begin
    rectangle(-30+i*100, 50, 70+i*100, 100);
    bar(-29+i*100, 51, 69+i*100, 99);
    OutTextXY(75+(i-1)*100, 70, a[i][1]);
  end;
  if y>1 then
    begin
      case x of
      1: begin
        for i:=2 to 6 do
        begin
          rectangle(-30+x*100, 50+(i-1)*50, 70+x*100, 100+(i-1)*50);
          bar(-29+x*100, 51+(i-1)*50, 69+x*100, 99+(i-1)*50);
          OutTextXY(75+(x-1)*100, 70+(i-1)*50, a[x][i]);
        end;
      end;
      3: begin
        for i:=2 to 3 do
        begin
          rectangle(-30+x*100, 50+(i-1)*50, 70+x*100, 100+(i-1)*50);
          bar(-29+x*100, 51+(i-1)*50, 69+x*100, 99+(i-1)*50);
          OutTextXY(75+(x-1)*100, 70+(i-1)*50, a[x][i]);
        end;
      end;
    end;
  end;
  SetFillStyle(SolidFill, 8);
  rectangle(-30+x*100, y*50, 70+x*100, 50+y*50);
  bar(-29+x*100, 51+(y-1)*50, 69+x*100, 99+(y-1)*50);
  OutTextXY(75+(x-1)*100, 70+(y-1)*50, a[x][y]);
end;
var
  i,j,par,GraphDriver,GraphMode:integer;
  arrow:char;
  arr: Tarr2;
begin
  ist.setkmin(1000);
  ist.setist1lam(2);
  ist.setIst2lam(1);
  ist.setIst3lam(5);
  pribor.setlam(1);
     arr[1][1]:='parametrs';
     arr[1][2]:='kmin';
     arr[1][3]:='ist1_lam';
     arr[1][4]:='ist2_lam';
     arr[1][5]:='ist3_lam';
     arr[1][6]:='pribor_lam';
     arr[2][1]:='modeling';
     arr[3][1]:='results';
     arr[3][2]:='tables';
     arr[3][3]:='graphics';
     arr[4][1]:='help';
     arr[5][1]:='exit';
  clrscr;
  detectgraph(GraphDriver,GraphMode);
  initgraph(GraphDriver,GraphMode,'C:\tp7\bin');
  cleardevice;
  SetColor(15);
  SetFillStyle(SolidFill,7);
  i:=1;
  j:=1;
  repeat
    cleardevice;
    printing(i,j, arr);
    arrow:=readkey;
    case arrow of
      #72: j:=j-1; {up}
      #80: j:=j+1; {down}
      #75: begin
           if (j>1) and (i>1) then
             j:=1;
             i:=i-1; {left}
           end;
      #77: begin
           if (j>1) and (i<5) then j:=1;
             i:=i+1; {right}
           end;
      #13: begin
           if (i=1) and (j>1) then
             begin
               RestoreCRTmode;
               if j=2 then
               begin
                 write('set kmin: ');
                 readln(par);
                 ist.setKMin(par);
               end;
               if j=3 then
               begin
                 write('Set lambda istochnik #1: ');
                 readln(par);
                 ist.setIst1Lam(par);
               end;
               if j=4 then
               begin
                 write('Set lambda istochnik #2: ');
                 readln(par);
                 ist.setIst2Lam(par);
               end;
               if j=5 then
               begin
                 write('Set lambda istochnik #3: ');
                 readln(par);
                 ist.setIst3Lam(par);
               end;
               if j=6 then
               begin
                 write('Set lambda pribor: ');
                 readln(par);
                 pribor.setLam(par);
               end;
                 Setgraphmode(GraphMode);
             end;
             if (i=2) and (j=1) then
             begin
               SetFillStyle(SolidFill, 1);
               RestoreCRTmode;
               CMOStart(ist, buffer, pribor, 1);
               Setgraphmode(GraphMode);
             end;
             if (i=3) and (j>1) then
             begin
               if j=3 then
               begin
                 cleardevice;
                 CMOStart(ist, buffer, pribor, 2);
                 readln;
               end;
               if j=2 then
               begin
                 cleardevice;
                 CMOStart(ist, buffer, pribor, 3);
                 readln;
               end;
             end;
             if ((i=1) or (i=2) or (i=3)) and (j=1) then
               j:=2;
               if i=4 then
               begin
                 cleardevice;
                 SetFillStyle(SolidFill, 7);
                 rectangle(100, 100, 500, 190);
                 bar(101, 101 ,499, 189);
                 OutTextXY(110, 130, 'Press Parameters to change Parametrs');
                 OutTextXY(110, 150, 'Press Result to see Tables or Graphiks');
                 OutTextXY(110, 170, 'Press Exit to exit');
               readln;
             end;
             if i=5 then
               break;
        end;
      end;
      if j<1 then
        j:=1;
      if (i=1) and (j>6) then
        j:=6;
      if (i=2) and (j>1) then
        j:=1;
      if (i=3) and (j>3) then
        j:=3;
      if (i=4) and (j>1) then
        j:=1;
      if (i=5) and (j>1) then
        j:=1;
      if i<1 then
        i:=1;
      if i>5 then
        i:=5;
  printing(i,j,arr);
  until arrow=#14;
  closegraph;
end.
