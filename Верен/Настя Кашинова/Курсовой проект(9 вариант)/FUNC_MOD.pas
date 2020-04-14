Unit FUNC_MOD;
const 
  maxCount = 5;
  sourceCount = 3;
  
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
    nextClaimTime : real; //время следующего запроса
    prevClaimTime : real;
  public
    constructor create(n : integer;l : real);
    begin
      sourceNumber := n;
      currentClaimNumber := 0;
      failureCount := 0;
      processedClaimCount := 0;
      lambda := l;
      nextClaimTime := -1/lambda*ln(random());
      prevClaimTime := 0;
    end;
    procedure generateNextClaim();
    begin
      currentClaimNumber := currentClaimNumber + 1;
      prevClaimTime := nextClaimTime;
      nextClaimTime := nextClaimTime - 1/lambda*ln(random());
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
    function getPrevClaimTime() : real;
    begin
      getPrevClaimTime := prevClaimTime;
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
      prevClaimTime := value.getPrevClaimTime();
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
    timeMas : array [1..sourceCount] of real;
    countMas : array [1..sourceCount] of integer;
    timeRelease : real;
    flag : boolean;
  public
    constructor create(t : real);
    var
      i : integer;
    begin
      for i:= 1 to sourceCount do
      begin
        timeMas[i] := 0;
        countMas[i] := 0;
      end;
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
    var
      number : integer;
    begin
      TimeRelease := Time - 1/tau*ln(random());
      number := curClaim.getSourceNumber();
      timeMas[number] := timeMas[number] + TimeRelease - Time;
      countMas[number] := countMas[number] + 1;
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
    function getTimePerfoming(i : integer) : real;
    begin
      getTimePerfoming := timeMas[i]/countMas[i];
    end;
  end;

(*БУФИР*) 
  queue = class
  private
    main : array [1..maxCount] of claim;
    count : integer;
    timeMas : array [1..sourceCount] of real;
    countMas : array [1..sourceCount] of integer;
  public
    constructor create();
    var
      i : integer;
    begin
      count := 0;
      for i:= 1 to sourceCount do
      begin
        timeMas[i] := 0;
        countMas[i] := 0;
      end;
      for i := 1 to maxCount do
      begin
        main[i] := nil;
      end;
    end;
    constructor create(value : claim);
    var
      i : integer;
    begin
      count := 1;
      main[1] := value;
      for i := 2 to maxCount do
      begin
        main[i] := nil;
      end;
    end;
    function push(value : claim) : integer;
    var
      i : integer;
    begin
      if (count = 0) then
      begin
        count := count + 1;
        main[count] := value;
        push := -1;
      end else
        begin
        push := main[1].getSourceNumber();
        for i := 1 to count - 1 do
        begin
          main[i] := main[i-1];
        end;
        main[count] := value;
      end;
    end;
    function get() : claim;//предполагается что в основной программе проверяется на пустоту
    var
      i : integer;
    begin
      get := main[count];
    end;
    procedure pop();
    var
      i : integer;
      temp : claim;
      number : integer;
    begin
      temp := main[count];
      main[count] := nil;
      count := count - 1;
      number := temp.getSourceNumber();
      timeMas[number] := timeMas[number] + temp.getNextClaimTime() - temp.getPrevClaimTime();
      countMas[number] := countMas[number] + 1;
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
    procedure Calculate();
    begin
      //sumCount := sumCount + count;
      //dimensionCount := dimensionCount + 1;
    end;
    function getMiddleCount(i : integer) : real;
    begin
      getMiddleCount := timeMas[i]/countMas[i];
    end;
    procedure nulling();
    var
      i : integer;
    begin
      for i:= 1 to sourceCount do
      begin
        timeMas[i] := 0;
        countMas[i] := 0;
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