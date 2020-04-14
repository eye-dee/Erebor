unit Data;

uses
  QueueUnit, SourceUnit, PerfomerUnit;
  
type
repository = class
private
  firstSourceClaim : array [1..3,1..11] of integer;  //масссив результатов для первого источника
  secondSourceClaim : array [1..3,1..11] of integer; //масссив результатов для второго источника
  middleCountArray : array [1..11] of real;  //массив резултатов среднего времени нахождения заявки в памяти
public
  constructor create();
  var
    i : integer;
  begin
    for i:=1 to 11 do
    begin
      firstSourceClaim[1,i] := 0;
      firstSourceClaim[2,i] := 0;
      firstSourceClaim[3,i] := 0;
      secondSourceClaim[1,i] := 0;
      secondSourceClaim[2,i] := 0;
      secondSourceClaim[3,i] := 0;
      middleCountArray[i] := 0;
    end;
  end;
  procedure setClaim(n,i,fail,processed,count : integer);
  begin
    if (n > 2) or (i > 11) or (i < 1) or (n < 1) then
    begin
      writeln('STUPID');
      exit;
    end;
    case n of
      1 : begin
            firstSourceClaim[1,i] := fail;
            firstSourceClaim[2,i] := processed;
            firstSourceClaim[3,i] := count;
          end;
      2 : begin
            secondSourceClaim[1,i] := fail;
            secondSourceClaim[2,i] := processed;
            secondSourceClaim[3,i] := count;
          end;
    end;
  end;
  function getClaim(n,i,j :integer) : integer;
  begin
    if (n > 2) or (i > 11) or (i < 1) or (n < 1) or (j < 1) or (j > 3) then
    begin
      writeln('STUPID');
      exit;
    end;
    case n of
      1: begin
          getClaim := firstSourceClaim[j,i];
         end;
      2: begin
          getClaim := secondSourceClaim[j,i]; 
         end;
    end;
  end;
  procedure setCount(i : integer;value : real);
  begin
    middleCountArray[i] := value;
  end;
  function getterCount(i : integer) : real;
  begin
    getterCount := middleCountArray[i];
  end;
end;

BEGIN
END.