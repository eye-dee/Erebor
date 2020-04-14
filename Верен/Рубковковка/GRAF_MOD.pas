unit GRAF_MOD;

INTERFACE
uses crt, graph;
type
    arrR=array[1..3] of real;
    arrR1=array[1..3,1..11] of real;
    ar=array[1..11] of real;

procedure grafdraw(n:integer; la,tog1,tpreb1:ar; p:arrR1);
procedure graftabl(n:integer; la,tog1,tpreb1:ar; p:arrR1);

IMPLEMENTATION
procedure grafdraw(n:integer; la,tog1,tpreb1:ar; p:arrR1);
          var
             i:integer;
             s:string;
             max:real;
          begin
             if n=1 then begin
                setcolor(15);
                OutTextXY(50, 20, 'Probability #1, #2, #3');
                setcolor(4); line(145,30,160,30);
                setcolor(2); line(175,30,193,30);
                setcolor(3); line(205,30,223,30);

                setcolor(15);
                setTextStyle(0,VertDir,1);
                line(20, 10, 20, 420);
                line(20, 420, 240, 420);
                for i:=1 to 4 do begin
                    line(15, 420-100*i,25, 420-100*i);
                    Str(i/4:1:2,s);
                    OutTextXY(10, 410-100*i,s);
                end;

                for i:=1 to 11 do begin
                    line(20+i*20, 415,20+i*20, 425);
                    if i>1 then la[i]:=la[1]+0.4*(i-1);
                    Str(la[i]:3:1,s);
                    OuttextXY(25+i*20, 430,s);
                end;
             end;

             if (n>1) and (n<=11) then begin
                setcolor(4);
                line(n*20,420-round(p[1][n-1]*400),20+n*20,420-round(p[1][n]*400));
                setcolor(2);
                line(n*20,420-round(p[2][n-1]*400),20+n*20,420-round(p[2][n]*400));
                setcolor(3);
                line(n*20,420-round(p[3][n-1]*400),20+n*20,420-round(p[3][n]*400));
             end;

             if n=11 then begin
                setcolor(15);
                setTextStyle(0,HorizDir,1);
                OutTextXY(500,20,'TOG and TPreb');
                setcolor(2); line(500,30,523,30);
                setcolor(3); line(565,30,604,30);

                setcolor(15);
                setTextStyle(0,VertDir,1);
                line(340, 10, 340, 420);
                line(340, 420, 560, 420);
                max:=tpreb1[1];
                for i:=1 to 11 do begin
                    if tpreb1[i]>max then max:=tpreb1[i];

                    line(340+i*20, 415,340+i*20, 425);
                    Str(la[i]:3:1,s);
                    OuttextXY(345+i*20, 430,s);
                end;

                setTextStyle(0,HorizDir,1);
                for i:=1 to 10 do begin
                    setcolor(15);
                    line(335, 420-40*i,345, 420-40*i);
                    Str(i*max/10:1:2,s);
                    OutTextXY(290, 420-40*i,s);

                    setcolor(2);
                    line(340+20*i, 420-round(tog1[i]/max*400), 360+20*i, 420-round(tog1[i+1]/max*400));
                    setcolor(3);
                    line(340+20*i, 420-round(tpreb1[i]/max*400), 360+20*i, 420-round(tpreb1[i+1]/max*400));
                end;
             end;
          end;

procedure graftabl(n:integer; la,tog1,tpreb1:ar; p:arrR1);
          var
             i:integer;
             s:string;
          begin
               setcolor(15);
               line(0,40*n-5,410,40*n-5);

               line(80,0,80,479);
               OutTextXY(20, 10,'Lambda');
               if n>1 then la[n]:=la[1]+0.4*(n-1);
               Str(la[n]:3:1,s);
               OutTextXY(25, 10+40*n,s);

               line(150,0,150,479);
               OutTextXY(90, 10,'Prob #1');
               Str(p[1][n]:3:3,s);
               OutTextXY(95, 10+40*n,s);

               line(220,0,220,479);
               OutTextXY(160, 10,'Prob #2');
               Str(p[2][n]:3:3,s);
               OutTextXY(165, 10+40*n,s);

               line(295,0,295,479);
               OutTextXY(230, 10,'Prob #3');
               Str(p[3][n]:3:3,s);
               OutTextXY(235, 10+40*n,s);

               line(350,0,350,479);
               OutTextXY(310, 10,'TOG');
               Str(tog1[n]:3:3,s);
               OutTextXY(305, 10+40*n,s);

               line(410,0,410,479);
               OutTextXY(360, 10,'TPreb');
               Str(tpreb1[n]:3:3,s);
               OutTextXY(365, 10+40*n,s);

          end;

Begin

end.