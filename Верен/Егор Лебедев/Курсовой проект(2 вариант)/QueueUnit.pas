unit QueueUnit;

uses sourceUnit,PerfomerUnit;

const maxCount = 3;

type
  queue = class
  private
    main : array [1..maxCount] of claim;
    times : array [1..maxCount] of real;
    counts : array[1..maxCount] of integer;
    count : integer;
    middleCount : real;//среднее количество заявок в памяти
    sumCount : integer; //суммарное количество заявок побывавших в буфере
    dimensionCount : integer; //количество измерений
  public
    constructor create();
    begin
      count := 0;
      main[1] := nil;
      main[2] := nil;
      main[3] := nil;
      times[1] := 0;
      times[2] := 0;
      times[3] := 0;
      counts[1] := 0;
      counts[2] := 0;
      counts[3] := 0;
    end;
    constructor create(value : claim);
    begin
      count := 1;
      main[1] := value;
      main[2] := nil;
      main[3] := nil;
      times[1] := 0;
      times[2] := 0;
      times[3] := 0;
      counts[1] := 0;
      counts[2] := 0;
      counts[3] := 0;
    end;
    procedure push(value : claim);
    begin
      if (maxCount = count) then
        exit;
      count := count + 1;
      main[count] := value;
    end;
    function get() : claim;//предполагается что в основной программе проверяется на пустоту
    var
      maxPriority : integer := 1;
      i : integer;
    begin
      for i:= 1 to count do
      begin
        if (main[i].getSourceNumber() > main[maxPriority].getSourceNumber()) then
          maxPriority := i;
        get := main[maxPriority];
      end;
      times[maxPriority] := times[maxPriority] + main[maxPriority].getNextClaimTime() - main[maxPriority].getPrevClaimTime();
      counts[maxPriority] := counts[maxPriority] + 1;
    end;
    procedure pop();
    var
      maxPriority : integer := 1;
      i : integer;
    begin
      for i:= 1 to count do
      begin
        if (main[i].getSourceNumber() > main[maxPriority].getSourceNumber()) then
          maxPriority := i;
      end;
      for i:=maxPriority to maxCount-1 do
      begin
        main[i] := main[i+1];
      end;
      main[maxCount] := nil;
      count := count - 1;
    end;
    function isEmpty() : boolean;
    begin
      if (count = 0) then
        isEmpty := true
      else
        isEmpty := false;
    end;
    function isBusy() : boolean;
    begin
      isBusy := false;
      if (count = maxCount) then
        isBusy := true;
    end;
    function getCount() : integer;
    begin
      getCount := count;
    end;
    procedure correcting(temp : perfomer);
    var
      i :integer;
    begin
      for i := 1 to count do
      begin
        if (temp.getTimeRelease() > main[i].getNextClaimTime) then
          main[i].setNextClaimTime(temp.getTimeRelease());
      end;
    end;
   {procedure Calculate();
    begin
      sumCount := sumCount + count;
      dimensionCount := dimensionCount + 1;
    end;}
    function getMiddleCount(i : integer) : real;
    begin
      getMiddleCount := times[i]/counts[i];
    end;
    function getSumCount() : integer;
    begin
      getSumCount := sumCount;
    end;
    procedure nulling();
    begin
      sumCount := 0;
      dimensionCount := 0;
    end;
  end;
BEGIN
END.
    