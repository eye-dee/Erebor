Unit sourceUnit;

type   
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
      prevClaimTime := 0;
      nextClaimTime := -1/lambda*ln(random());
    end;
    procedure generateNextClaim();
    begin
      currentClaimNumber := currentClaimNumber + 1;
      prevClaimTime := nextClaimTime;
      nextClaimTime := nextClaimTime + lambda*random();
    end;
    function getNextClaimTime() : real;
    begin
      getNextClaimTime := nextClaimTime;
    end;
    function getPrevClaimTime() : real;
    begin
      getPrevClaimTime := prevClaimTime;
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

function getClaim(value : source) : claim;
var
  temp : claim := new claim(value);
begin
    getClaim := temp;
end; 

BEGIN
END.
  