unit func_mod;
interface
type
  arrR=array[1..3] of real;
  arrI=array[1..3] of integer;

  tist=object
    kmin,lambda1,lambda2,lambda3: real;
    nmin : integer;
    kol,kobr,kotk:arrI;
    tpost,tog,tpreb,potk:arrR;
    tog4,tpreb4:real;
    procedure init;
    procedure setKMin(p:integer);
    procedure setIst1lam(p:integer);
    procedure setIst2lam(p:integer);
    procedure setIst3lam(p:integer);
    procedure zGen(n:integer);
    procedure genNmin;
    function getTpostNmin:real;
    function getNmin:integer;
    function getPOtk(n:integer):real;
    function getTOG4:real;
    function getTPreb4:real;
    procedure kolUP(n:integer);
    procedure kObrUP(n:integer);
    procedure kOtkUP(n:integer);
    procedure tOGUP(n:integer;t:real;t1:real);
    function continueQ:boolean;
    procedure lamUP;
    procedure result(var f : text;s:integer);
  end;
  tbuffer=object
    bufT:array[1..2] of real;
    bufN:array[1..2] of integer;
    naObrN,indBuf:integer;
    naObrT:real;
    procedure init;
    procedure priem(n:integer;t:real);
    function zamena(n:integer;t:real):integer;
    function getIndBuf:integer;
    function getNaObrT:real;
    function getNaObrN:integer;
    procedure naObr;
  end;
  tpribor=object
    tosv,tobsl,tho:real;
    lambda:real;
    procedure init;
    procedure setlam(p:real);
    function gettosv:real;
    function gettobsl:real;
    function gettho:real;
    procedure modiftosv(t:real);
    procedure lamUP;
    function getlambda:real;
  end;

implementation
{istochnik}
procedure tist.init;
var
  i:integer;
begin
  nmin:=3;
  for i:=1 to 3 do
  begin
    tpost[i]:=0;
    kol[i]:=0;
    kobr[i]:=0;
    kotk[i]:=0;
    tog[i]:=0;
    tpreb[i]:=0;
    potk[i]:=0;
  end;
end;
procedure tist.setkmin(p:integer);
begin
  kmin:=p;
end;
procedure tist.setist1lam(p:integer);
begin
  lambda1:=p;
end;
procedure tist.setIst2lam(p:integer);
begin
  lambda2:=p;
end;
procedure tist.setIst3lam(p:integer);
begin
  lambda3:=p;
end;
procedure tist.zGen(n:integer);
begin
  case n of
  1:tpost[1]:=tpost[1]-1/lambda1*ln(random);
  2:tpost[2]:=tpost[2]-1/lambda2*ln(random);
  3:tpost[3]:=tpost[3]-1/lambda3*ln(random);
end;
end;
function tist.getTPostNmin:real;
begin
  getTPostNMin:=tpost[nmin];
end;
function tist.getpotk(n:integer):real;
begin
  getpotk:=potk[n];
end;
function tist.gettog4:real;
begin
  gettog4:=tog4;
end;
function tist.getTPreb4:real;
begin
  getTPreb4:=tpreb4;
end;

procedure tist.lamUp;
begin
  lambda1 := lambda1 + 0.4;
end;

procedure tist.genNmin;
begin
  if (tpost[1] <= tpost[2]) then
  begin
    if (tpost[1] <= tpost[3]) then nmin:=1
    else nmin:=3;
  end
  else begin
    if (tpost[2] <= tpost[3]) then nmin:=2
    else nmin:=3;
  end;
end;
function tist.getnmin:integer;
begin
  getnmin:=nmin;
end;
procedure tist.kolup(n:integer);
begin
  kol[n]:=kol[n]+1;
end;
procedure tist.kobrUP(n:integer);
begin
  kobr[n]:=kobr[n]+1;
end;
procedure tist.kotkUP(n:integer);
begin
  kotk[n]:=kotk[n]+1;
end;
procedure tist.togUP(n:integer; t:real; t1:real);
begin
  tog[n]:=tog[n]+t;
  tpreb[n]:=tpreb[n]+t+t1;
end;
function tist.continueQ:boolean;
begin
  if ((kol[1] < kmin) or (kol[2] < kmin) or (kol[3] < kmin)) then ContinueQ:=TRUE
    else ContinueQ:=False;
  end;
procedure tist.result(var f :text; s:integer);
var
  i:integer;
begin
  for i:=1 to 3 do potk[i]:=kotk[i]/kol[i];
    tog4:=(tog[1]+tog[2]+tog[3])/(kobr[1]+kobr[2]+kobr[3]);
    tpreb4:=(tpreb[1]+tpreb[2]+tpreb[3])/(kobr[1]+kobr[2]+kobr[3]);
    if s=1 then
    begin
      writeln(f,'kmin=', kmin);
      for i:=1 to 3 do write(f,' kol[',i,']=', kol[i]:7, '; ');
        writeln(f,' kol=', kol[1]+kol[2]+kol[3]:7);
      for i:=1 to 3 do write(f,'kObr[',i,']=', kObr[i]:7, '; ');
        writeln(f,'kObr=', kObr[1]+kObr[2]+kObr[3]:7);
      for i:=1 to 3 do write(f,'kOtk[',i,']=', kOtk[i]:7, '; ');
        writeln(f,'kOtk=', kOtk[1]+kOtk[2]+kOtk[3]:7);
      for i:=1 to 3 do write(f,' tOG[',i,']=', (tOG[i]/kObr[i]):7:3, '; ');
        writeln(f,' tOG=', tog4:7:3);
      for i:=1 to 3 do write(f,'tPreb[',i,']=', (tPreb[i]/kObr[i]):6:3, '; ');
        writeln(f,'tPreb=', tpreb4:6:3);
    end;
end;
{buffer}
procedure tbuffer.init;
var
  i:integer;
begin
  indbuf:=0;
  naobrN:=0;
  naobrT:=0;
  for i:=1 to 2 do
  begin
    bufT[i]:=0;
    bufN[i]:=0;
  end;
end;
procedure tbuffer.priem(n:integer;t:real);
begin
  bufT[indbuf+1]:=t;
  bufN[indbuf+1]:=n;
  indbuf:=indbuf+1;
end;
function tbuffer.zamena(n:integer;t:real):integer;
var
  min,i:integer;
begin
  min:=1;
  for i:=2 to 2 do
  begin
    if bufT[i] < bufT[min] then
      min:=i;
  end;
  zamena:=bufN[min];
  bufT[min]:=t;
  bufN[min]:=n;
end;
function tbuffer.getindbuf:integer;
begin
  getindbuf:=indbuf;
end;
function tbuffer.getnaobrT:real;
begin
  getnaobrT:=naobrT;
end;
function tbuffer.getnaobrN:integer;
begin
  getnaobrN:=naobrN;
end;
procedure tbuffer.naObr;
var
  max,i:integer;
begin
  max:=1;
  for i:=2 to indbuf do
  begin
    if bufT[i] > bufT[max] then
      max:=i;
  end;
  naobrT:=bufT[max];
  naobrN:=bufN[max];
  for i:=max to indbuf-1 do
  begin
    bufT[i]:=bufT[i+1];
    bufN[i]:=bufN[i+1];
  end;
    indbuf:=indbuf-1;
    for i:=indbuf+1 to 2 do
    begin
      bufT[i]:=0;
      bufN[i]:=0;
    end;
end;
{pribor}
procedure tpribor.init;
begin
  tho:=0;
  tosv:=0;
  tobsl:=0;
end;
procedure tpribor.setlam(p:real);
begin
  lambda:=p;
end;
function tpribor.gettosv:real;
begin
  gettosv:=tosv;
end;
function tpribor.gettobsl:real;
begin
  getTObsl:=tobsl;
end;
function tpribor.gettho:real;
begin
  gettho:=tho;
end;
procedure tpribor.modiftosv(t:real);
begin
  tobsl:=-1/lambda*ln(random);
  if tosv < t then
  begin
    tho:=t;
    tosv:=tho+tobsl;
  end
  else begin
    tho:=tosv;
    tosv:=tho+tobsl;
  end;
end;
procedure tpribor.lamUP;
begin
  tho:=0;
  tosv:=0;
  lambda:=lambda+0.4;
end;
function tpribor.getlambda:real;
begin
  getlambda:=lambda;
end;
{main}
begin
end.