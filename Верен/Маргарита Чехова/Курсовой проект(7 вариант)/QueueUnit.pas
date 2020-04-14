unit QueueUnit;

uses sourceUnit,PerfomerUnit;

const maxCount = 5;

type
  queue = class
  private
    main : array [1..maxCount] of claim;
    count : integer;
    sumTime : array [1..sourceCount] of real; //����� ����� ���������� ������ �� ������� ���������
    sumCount : array [1..sourceCount] of integer; //��������� ���������� ������ ���������� � ������ ��� ������� ���������
  public
    constructor create();
    var
      i : integer;
    begin
      count := 0;
      for i := 1 to maxCount do
        main[i] := nil;
    end;
    constructor create(value : claim);
    var
      i : integer;
    begin
      count := 1;
      main[1] := value;
      for i:=2 to maxCount do
        main[i] := nil;
    end;
    procedure push(value : claim);
    begin
      if (maxCount = count) then
        exit;
      count := count + 1;
      main[count] := value;
    end;
    function get() : claim;//�������������� ��� � �������� ��������� ����������� �� �������
    var
      i : integer;
    begin
      get := main[count];
    end;
    procedure pop();
    var
      i,n : integer;
    begin
      n := main[count].getSourceNumber();
      sumTime[n] := sumTime[n] + main[count].getNextClaimTime() - main[count].getPrevClaimTime();
      sumCount[n] := sumCount[n] + 1;
      
      main[count] := nil;
      count := count - 1;
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
    
    
    function getMiddleCount(i : integer) : real;
    begin
      getMiddleCount := sumTime[i]/sumCount[i];
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
  end;
BEGIN
END.
    