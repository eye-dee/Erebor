unit QueueUnit;

uses sourceUnit,PerfomerUnit;

const maxCount = 4;

type
  queue = class
  private
    main : array [1..maxCount] of claim;
    count : integer;
    //middleCount : array [1..sourceCount] of real;//среднее время в памяти для каждого источника
    sumTime : array [1..sourceCount] of real; //общее время пребывания заявок от каждого источника
    sumCount : array [1..sourceCount] of integer; //суммарное количество заявок побывавших в буфере для каждого источника
  public
  
    constructor create();
    begin
      count := 0;
      main[1] := nil;
      main[2] := nil;
      main[3] := nil;
      main[4] := nil;
    end;
    
    constructor create(value : claim);
    begin
      count := 1;
      main[1] := value;
      main[2] := nil;
      main[3] := nil;
      main[4] := nil;
    end;
    
    procedure push(value : claim);
    begin
      if (maxCount = count) then
        exit;
      count := count + 1;
      main[count] := value;
    end;
    
    function get() : claim;//проверяется на пустоту
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
    end;
    
    procedure pop();
    var
      maxPriority : integer := 1;
      i,n : integer;
    begin
      for i:= 1 to count do
      begin
        if (main[i].getSourceNumber() > main[maxPriority].getSourceNumber()) then
          maxPriority := i;
      end;
      n := main[MaxPriority].getSourceNumber();
      sumTime[n] := sumTime[n] + main[MaxPriority].getNextClaimTime() - main[MaxPriority].getPrevClaimTime();
      sumCount[n] := sumCount[n] + 1;
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
    
    procedure nulling();
    var
      i : integer;
    begin
      for i:= 1 to sourceCount do
      begin
        sumTime[i] := 0;
        sumCount[i] := 0;
      end;
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
    
    function getMiddleCount(i : integer) : real;
    begin
      getMiddleCount := sumTime[i]/sumCount[i];
    end;
end;
  
BEGIN
END.
    