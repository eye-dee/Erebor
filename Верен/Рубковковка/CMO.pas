unit CMO;
interface
uses func_mod,crt,graf_mod;
procedure cmostart(ist:Tist; buffer:Tbuffer; pribor:Tpribor; standart:integer);
var
   ist:tist;
   buffer:tbuffer;
   pribor:tpribor;
implementation
procedure cmostart(Ist:Tist; buffer:Tbuffer; pribor:Tpribor; standart:integer);
var
  nrlz:integer;
  tdop:real;
  po:arrR1;
  tog1,tpreb1,la:ar;
  f : text;
begin
  pribor.init;
  assign(f,'output.txt');
  rewrite(f);
  {Realization cycle}
  for nrlz:=1 to 11 do
  begin
    if standart=1 then
    begin
      clrscr;
      writeln('Realization #', nrlz, ' has started.');
    end;
    	randomize;
      ist.init;
      buffer.init;
      ist.zGen(1);
      ist.zGen(2);
      ist.zGen(3);
      {Inrealization cycle}
      while ist.ContinueQ do
      begin
        ist.genNMin;
        {From Buffer}
        while ((buffer.getIndBuf > 0) and (pribor.getTosv < ist.getTPostNMin)) do
        begin
          buffer.naObr;
          pribor.modifTOsv(buffer.getnaObrT);
          ist.kObrUP(buffer.getNaObrN);
          tdop:=pribor.getTHO-buffer.getnaObrT;
          ist.tOGUP(buffer.getNaObrN, tdop, pribor.getTObsl);
        end;
        {Pribor is empty}
        if (pribor.getTOsv <= ist.getTPostNMin) then
        begin
          pribor.modifTOsv(ist.getTPostNMin);
          ist.kObrUP(ist.getNMin);
          ist.tOGUP(ist.getNMin, 0, pribor.getTObsl);
        end
        {Pribor is in work}
        else begin
          if buffer.getindbuf=2 then
          begin
            ist.kotkUP(buffer.zamena(ist.getNMin, ist.getTPostNMin));
          end
            else begin
              buffer.priem(ist.getNMin, ist.getTPostNMin);
            end;
        end;
        ist.kolUP(ist.getNMin);
        ist.zGen(ist.getNMin);}
      end;
      if standart=1 then
      begin
        writeln;
        writeln('Realization #', nrlz, ' has been ended.');
      end;
        ist.result(f,standart);
        if standart>1 then
        begin
          po[1][nRlz]:=ist.getPOtk(1);
          po[2][nRlz]:=ist.getPOtk(2);
          po[3][nRlz]:=ist.getPOtk(3);
          tog1[nRlz]:=ist.getTOG4;
          tpreb1[nRlz]:=ist.getTPreb4;
          la[nRlz]:=pribor.getlambda;
            if standart=2 then grafdraw(nRlz, la, tog1, tpreb1, po);
            if standart=3 then graftabl(nRlz, la, tog1, tpreb1, po);
        end;
        ist.lamup;
        if standart=1 then readln;
      end;
      if standart=1 then
      begin
        writeln('Press Enter to exit');
        readln;
      end;
      close(f);
    end;
begin
end.