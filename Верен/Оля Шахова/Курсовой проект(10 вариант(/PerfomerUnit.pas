Unit PerfomerUnit;

uses sourceUnit;

type 
 perfomer = class
  private
    tau : real;
    curClaim : claim;
    timeCount : real;
    timeRelease : real;
    flag : boolean;
  public
    constructor create(t : real);
    var
      i : integer;
    begin
      tau := t;
      flag := false;
      curClaim := nil;
      timeRelease := 0;
    end;
    function getTimeRelease() : real;
    begin
      getTimeRelease := timeRelease;
    end;
    function getSourceNumber() :integer;
    begin
      getSourceNumber := curClaim.getSourceNumber();
    end;
    procedure pushClaim(temp : claim);
    begin
      curClaim := temp;
      flag := true;
    end;
    procedure GenerateTimeRelease(Time : real; flag : boolean);
    var
      number : integer;
    begin
      if (flag) then
        timeCount := timeCount + Time - TimeRelease;
      TimeRelease := Time - 1/tau*ln(random());
      number := curClaim.getSourceNumber();
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
    function getKoef() : real;
    begin
      getKoef := (timeRelease - timeCount)/timeRelease;
    end;
  end;

BEGIN
END.