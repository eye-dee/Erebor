Unit PerfomerUnit;

uses sourceUnit;

type 
  perfomer = class
  private
    lambda : real;  //для обработчика Эрланга второго порядка
    curClaim : claim; //текущая заявка
    timeRelease : real; //время освобождения
    flag : boolean;  //флаг занятости обработчика
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
    begin
      //TimeRelease := Time + (round(lambda/2) + random(lambda));
      TimeRelease := Time - 1/lambda*ln(random()*random());
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