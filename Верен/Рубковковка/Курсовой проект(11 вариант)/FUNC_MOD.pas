Unit FUNC_MOD;
const 
  maxCount = 2;
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
  public
    constructor create(n : integer;l : real);
    begin
      sourceNumber := n;
      currentClaimNumber := 0;
      failureCount := 0;
      processedClaimCount := 0;
      lambda := l;
      nextClaimTime := -1/lambda*ln(random());
    end;
    procedure generateNextClaim();
    begin
      currentClaimNumber := currentClaimNumber + 1;
      nextClaimTime := nextClaimTime -1/lambda*ln(random());;
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

(*БУФИР*) 
  queue = class
  private
    main : array [1..maxCount] of claim;
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
    end;
    constructor create(value : claim);
    begin
      count := 1;
      main[1] := value;
      main[2] := nil;
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
      i : integer;
    begin
      get := main[count];
    end;
    procedure pop();
    var
      i : integer;
    begin
      main[count] := nil;
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
    procedure Calculate();
    begin
      sumCount := sumCount + count;
      dimensionCount := dimensionCount + 1;
    end;
    function getMiddleCount() : real;
    begin
      getMiddleCount := sumCount/dimensionCount;
    end;
    procedure nulling();
    begin
      sumCount := 0;
      dimensionCount := 0;
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