Unit FUNC_MOD;
const 
  maxCount = 4;
  sourceCount = 2;
  
(*ИСТОЧНИК*) 
type   
  lamMas = array [1..sourceCount] of real;
  source = class
  protected
    lambda : real;
    sourceNumber : integer;
    currentClaimNumber : integer;
    failureCount : integer;
    processedClaimCount : integer;
    prevClaimTime : real; //время предыдущего запроса
    nextClaimTime : real; //время следующего запроса
  public
    constructor create(n : integer;l : real);
    begin
      sourceNumber := n;
      currentClaimNumber := 0;
      failureCount := 0;
      processedClaimCount := 0;
      lambda := l;
      prevClaimTime := 0;
      case sourceNumber of 
        1 : nextClaimTime := -1/lambda*ln(random()*random());
        2 : nextClaimTime := -1/lambda*ln(random());
      end;
    end;
    procedure generateNextClaim();
    begin
      currentClaimNumber := currentClaimNumber + 1;
      prevClaimTime := nextClaimTime;
      case sourceNumber of 
        1 : nextClaimTime := nextClaimTime -1/lambda*ln(random()*random());
        2 : nextClaimTime := nextClaimTime -1/lambda*ln(random());
      end;
    end;
    function getPrevClaimTime() : real;
    begin
      getPrevClaimTime := prevClaimTime;
    end;
    function getNextClaimTime() : real;
    begin
      getNextClaimTime := nextClaimTime;
    end;
    function getCurrentClaimNumber() :integer;
    begin
      getCurrentClaimNumber := currentClaimNumber;
    end;
    function getSourceNumber() : integer;
    begin
      getSourceNumber := sourceNumber;
    end;
    procedure incrementationFailure();
    begin
      failureCount := failureCount + 1;
    end;
    procedure incrementationProcessedClaim();
    begin
      processedClaimCount := processedClaimCount + 1;
    end;
    function getFailureCount() : integer;
    begin
      getFailureCount := failureCount;
    end;
    function getProcessedClaimCount() : integer;
    begin
      getProcessedClaimCount := processedClaimCount;
    end;
 end;

(*ЗАЯВКА*)
claim = class(source)
  public
    constructor create(value : source);
    begin
      sourceNumber := value.getSourceNumber();
      currentClaimNumber := value.getCurrentClaimNumber();
      nextclaimTime := value.getNextClaimTime();
    end;
    procedure setNextClaimTime(value : real);
    begin
      nextClaimTime := value;
    end;
  end; 
  
(*ОБРАБОТЧИК*)  
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
      TimeRelease := Time + tau;
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

(*БУФИР*) 
  queue = class
  private
    main : array [1..maxCount] of claim;
    count : integer;
    middleCount : array [1..sourceCount] of real;//среднее время в памяти для каждого источника
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
      sumTime[n] := main[MaxPriority].getNextClaimTime() - main[MaxPriority].getPrevClaimTime();
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
      getMiddleCount := sumTime[i]/sumCount[i];
    end;
    procedure nulling();
    var
      i : integer;
    begin
      for i:= 1 to SourceCount do
      begin
        sumCount[i] := 0;
        sumTime[i] := 0.0;
      end;
    end;
  end;
  
function getClaim(value : source) : claim;
var
  temp : claim := new claim(value);
begin
    getClaim := temp;
end;

BEGIN
END.