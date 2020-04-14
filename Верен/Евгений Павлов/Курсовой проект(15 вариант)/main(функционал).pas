uses
  FUNC_MOD,Data;

const
  input = 'input.txt';
  output = 'output.txt';
  sourceCount = 2; //���������� ����������

type
  matrix = array [1..sourceCount] of source;
 
var  
  masSource : matrix; //������ ����������
  mainQueue: queue := new queue(); //�����
  mainPerfomer: perfomer; //����������
  f: text; //���� ��� ������
  sourceNumber : integer; //��������������� ���������� - ����� ���������
  lambda : lamMas; //������ �����
  tau : real; //���
  mainRepository : repository := new repository(); //��������� ������
  i,j : integer; 
  Kmin : integer := 1000;
  flag :  integer := 1; 
  min : integer; //�������� � ����������� �������� ������ �������

function getMin() : integer; //���������� ����� ��������� � ����������� ������� ������
var
  i : integer;
  minTime : integer := 1;
begin
  for i:= 2 to sourceCount do
  begin
    if (masSource[i].getNextClaimTime() < masSource[minTime].getNextClaimTime()) then
      minTime := i;
  end;
  getMin := minTime;
end;

procedure setClaims(var r : repository;var m : matrix;j : integer);  //������� ������ �� ����������� �����������,���������� ������ � ��������� ������
var 
  i : integer;
begin
  for i := 1 to sourceCount do
  begin
    r.setClaim(i,j,m[i].getFailureCount(),m[i].getProcessedClaimCount(),m[i].getCurrentClaimNumber());
  end;
end;

begin
  assign(f,output);
  rewrite(f);
  tau := 0.1;
  lambda[1] := 2.0;
  lambda[2] := 4.0;
  i := 0; 
    for i:= 1 to 11 do
    begin 
      randomize;
      mainPerfomer := new perfomer(tau);  //������������� �����������
      for j := 1 to sourceCount do  //������������� ����������
      begin
        masSource[j] := new source(j,lambda[j]);
      end;
      min := getMin(); //������� ����� ��������� � ����������� ������� ������
      //masSource[min].incrementationProcessedClaim(); //����������� ���������� ����������� ������
      mainPerfomer.pushClaim(getClaim(masSource[min])); //������� ������ � ��������
      mainPerfomer.GenerateTimeRelease(masSource[min].getNextClaimTime()); //���������� ����� ������������
      masSource[min].generateNextClaim(); //���������� ����� ����� ������
      writeln(f,'     ������ | ������������ | ����� | ����������� ������');
      while (true) do 
      begin
        if (mainQueue.isEmpty()) then //���� ����� ���� ������� � ��� ������
        begin
          min := getMin();
          mainQueue.push(getClaim(masSource[min]));
          masSource[min].generateNextClaim();
        end;
        while ((masSource[1].getNextClaimTime < mainPerfomer.getTimeRelease()) or (masSource[2].getNextClaimTime < mainPerfomer.getTimeRelease())) do
        //���� ����� ����� ������ ������ ������� ������������ ���������
        begin
          min := getMin();
          if (mainQueue.isBusy) then //���������� ������� ��� ��� ����� �����
          begin
            masSource[min].generateNextClaim();
            masSource[min].incrementationFailure();
          end else //������� ������ � �������
          begin
            mainQueue.push(getClaim(masSource[min]));
            masSource[min].generateNextClaim();
          end;
        end;
        mainQueue.correcting(mainPerfomer); //������������ ����� ������������ ������ � ������
        if (mainPerfomer.getTimeRelease <= mainQueue.get().getNextClaimTime()) then 
        //���� ����� ������������ ��������� ������ ��� ����� ��������� ����� ������
        begin
          sourceNumber := mainPerfomer.release(); //����� ���������, ��� ������ ��������� ����������
          // � ������������ ������������ ����������
          if (sourceNumber <> 0) then
          begin
            //Sleep(15);
            masSource[sourceNumber].incrementationProcessedClaim();
            mainPerfomer.GenerateTimeRelease(mainQueue.get().getNextClaimTime());
            mainPerfomer.pushClaim(getClaim(mainQueue.get()));
            mainQueue.pop();
          end;
        end;
      if (masSource[1].getCurrentClaimNumber() > Kmin) and (masSource[2].getCurrentClaimNumber() > Kmin) then //Kmin ������ �������������
      begin
        tau := tau + 0.1; //���� ������ �������� �� ����� Kmin ������
        break;
      end;
      end; //end of main cycle
      while not (mainQueue.isEmpty()) do
      begin
        sourceNumber := mainQueue.get().getSourceNumber();
        mainQueue.pop();
        masSource[sourceNumber].incrementationFailure();
      end;
      for j:=1 to sourceCount do //�����
      begin
        writeln(f,'#',j,' ',masSource[j].getFailureCount() : 8,' ',masSource[j].getProcessedClaimCount(): 10,' ',masSource[j].getCurrentClaimNumber(): 10,' ',
                     masSource[j].getFailureCount()/masSource[j].getCurrentClaimNumber(): 7 : 3);
      end;
      writeln(f,'������� ����� ��������');
      writeln(f,'����� 1 ',mainQueue.getMiddleCount(1));
      writeln(f,'����� 2 ',mainQueue.getMiddleCount(2));
      writeln(f);
      
      setClaims(mainRepository,masSource,i);//������� ������ � ���������
      mainrepository.setCount(1,i,mainQueue.getMiddleCount(1));
      mainrepository.setCount(2,i,mainQueue.getMiddleCount(2));
      mainQueue.nulling();
    end;
  close(f);
end.