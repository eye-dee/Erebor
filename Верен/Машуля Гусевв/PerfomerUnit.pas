Unit PerfomerUnit;

uses sourceUnit;

const
    sourceCount = 4;

type 
  perfomer = class
  private
    lambda : real;
    curClaim : claim;
    timeRelease : real;
    flag : boolean;
    sumTime : array [1..sourceCount] of real; //время обработки одной заявки
    dimensionCount : array [1..sourceCount] of integer; //количество обработанных заявок
    main : array [1..sourceCount] of claim;
  public
    constructor create(l : real);
    begin
      lambda := l;
      flag := false;
      curClaim := nil;
      timeRelease := 0;
    end;
    
    function getTimeRelease() : real;
    begin
      getTimeRelease := timeRelease;
    end;
    
    procedure pushClaim(temp : claim);
    begin
      curClaim := temp;
      flag := true;
    end;
    
    procedure GenerateTimeRelease(Time : real);
    var
     // maxPriority : integer := 1;
      temp : real;
      i : integer;
    begin
      temp := lambda*random();
      i := curClaim.getSourceNumber();
      sumTime[i] := sumTime[i] + curClaim.getNextClaimTime() - curClaim.getPrevClaimTime();
      dimensionCount[i] := dimensionCount[i] + 1;
      TimeRelease := Time + temp;
    end;
    
    function isBusy() : boolean;
    begin
      isBusy := flag;
    end;
    function release() : integer;
    begin
      flag := false;
      if (curClaim <> nil) then
        release := curClaim.getSourceNumber();
      curClaim := nil;
    end;
    
  procedure nulling();
  var
    i : integer;
  begin
    for i:= 1 to sourceCount do
    begin
      sumTime[i] := 0;
      dimensionCount[i] := 0;
    end;
  end;
  function getMiddleCount(i : integer) : real;
  begin
    getMiddleCount := sumTime[i]/dimensionCount[i];
  end;
end;
BEGIN
END.