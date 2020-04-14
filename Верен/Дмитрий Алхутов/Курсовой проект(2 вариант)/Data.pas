unit Data;

uses
  QueueUnit, SourceUnit, PerfomerUnit;

const
    sourceCount = 2;
type
repository = class
private
  masSourceClaim : array [1..sourceCount,1..3,1..11] of integer;

  middleTimeCountArray : array [1..2,1..11] of real;
public
  constructor create();
  var
    i,j : integer;
  begin
  for j := 1 to sourceCount do
    for i:=1 to 11 do
    begin
      masSourceClaim[j,1,i] := 0;
      masSourceClaim[j,2,i] := 0;
      masSourceClaim[j,2,i] := 0;
      
      
      middleTimeCountArray[1,i] := 0;
      middleTimeCountArray[2,i] := 0;
    end;
  end;
  procedure setClaim(n,i,fail,processed,count : integer);
  begin
    if (n > sourceCount) or (i > 11) or (i < 1) or (n < 1) then
    begin
      writeln('STUPID');
      exit;
    end;
    masSourceClaim[n,1,i] := fail;
    masSourceClaim[n,2,i] := processed;
    masSourceClaim[n,3,i] := count;
  end;
  function getClaim(n,i,j :integer) : integer;
  begin
    if (n > sourceCount) or (i > 11) or (i < 1) or (n < 1) or (j < 1) or (j > 3) then
    begin
      writeln('STUPID');
      exit;
    end;
    getClaim := masSourceClaim[n,j,i];
  end;
  procedure setCount(i,j : integer;value : real);
  begin
    middleTimeCountArray[i,j] := value;
  end;
  function getterCount(i,j : integer) : real;
  begin
    getterCount := middleTimeCountArray[i,j];
  end;
end;

BEGIN
END.