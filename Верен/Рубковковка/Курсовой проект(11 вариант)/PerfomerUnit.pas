Unit PerfomerUnit;

uses sourceUnit;

type 
  perfomer = class
  private
    tau : real;
    curClaim : claim;
    timeRelease : real;
    flag : boolean;
  public
    constructor create(t : real);
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
    procedure pushClaim(temp : claim);
    begin
      curClaim := temp;
      flag := true;
    end;
    procedure GenerateTimeRelease(Time : real);
    begin
      TimeRelease := Time + tau*random();
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