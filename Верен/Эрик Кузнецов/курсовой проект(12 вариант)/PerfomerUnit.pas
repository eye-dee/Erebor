Unit PerfomerUnit;

uses sourceUnit;

const
    sourceCount = 3;

type 
  perfomer = class
  private
    lambda : real;
    curClaim : claim;
    timeRelease : real;
    flag : boolean;
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
      temp : real;
    begin
      temp := -1/lambda*ln(random()*random());
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
end;
BEGIN
END.