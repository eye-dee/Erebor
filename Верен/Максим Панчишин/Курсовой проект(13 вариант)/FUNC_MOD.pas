Unit FUNC_MOD;
const 
  maxCount = 5;
  sourceCount = 3;
  
(*ÈÑÒÎ×ÍÈÊ*) 
type   
  lamMas = array [1..sourceCount] of real;
  source = class
  protected
    lambda : real;
    sourceNumber : integer;
    currentClaimNumber : integer;
    failureCount : integer;
    processedClaimCount : integer;
    nextClaimTime : real; //âðåìÿ ñëåäóþùåãî çàïðîñà
    prevClaimTime : real;
  public
    constructor create(n : integer;l : real);
    begin
      sourceNumber := n;
      currentClaimNumber := 0;
      failureCount := 0;
      processedClaimCount := 0;
      lambda := l;
      nextClaimTime := -1/lambda*ln(random()*random());
      prevClaimTime := 0;
    end;
    procedure generateNextClaim();
    begin
      currentClaimNumber := currentClaimNumber + 1;
      prevClaimTime := nextClaimTime;
      nextClaimTime := nextClaimTime - 1/lambda*ln(random()*random());
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

(*ÇÀßÂÊÀ*)
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
  
(*ÎÁÐÀÁÎÒ×ÈÊ*)  
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

function getClaim(value : source) : claim;
var
  temp : claim := new claim(value);
begin
    getClaim := temp;
end;

BEGIN
END.