uses
  QueueUnit, SourceUnit, PerfomerUnit,Canvas,Data;

const
  input = 'input.txt';
  output = 'output.txt';

var  
  firstSource: source;
  secondSource: source;
  mainQueue: queue := new queue();
  mainPerfomer: perfomer;
  Time: integer;
  f: text;
  sourceNumber : integer;
  lambda : real;
  tau : integer;
  inp : text;
  mainRepository : repository := new repository();
  i : integer;
  
begin
  assign(inp,input);
  reset(inp);
  readln(inp,tau);
  close(inp);
  lambda := 0.5;
  i := 0;
  while (lambda < 1.505) do
  begin 
    i := i+1;
    randomize;
    firstSource := new source(1,tau);
    secondSource := new source(2,tau);
    mainPerfomer := new perfomer(round (lambda * 100));
    Time := 0;
    assign(f, output);
    rewrite(f);
    writeln(f,'queue ', 'mainPerfomerTime ', 'firstSourceTime ', 'secondSourceTime ', 'count');
    while (true) do
    begin
      if not(mainQueue.isEmpty()) then
        writeln(f,mainQueue.get().getNextClaimTime(), mainPerfomer.getTimeRelease():17, firstSource.getNextClaimTime: 17, secondSource.getNextClaimTime(): 17, mainQueue.getCount(): 5)
      else
        writeln(f,'NaN', mainPerfomer.getTimeRelease():17, firstSource.getNextClaimTime: 17, secondSource.getNextClaimTime(): 17, mainQueue.getCount(): 5);
      if (mainQueue.isEmpty()) then
      begin
        if (firstSource.getNextClaimTime() < secondSource.getNextClaimTime()) then
        begin
          mainQueue.push(getClaim(firstSource));
          firstSource.generateNextClaim(); 
        end else // end of then-branch (firstSource.getNextClaimTime() < secondSource.getNextClaimTime())
        begin
          mainQueue.push(getClaim(secondSource));
          secondSource.generateNextClaim();
        end;     // end of else-branch (firstSource.getNextClaimTime() < secondSource.getNextClaimTime())
      end;
      while (((firstSource.getNextClaimTime < mainPerfomer.getTimeRelease()) or (secondSource.getNextClaimTime < mainPerfomer.getTimeRelease()))) do
      begin
      if (mainQueue.isBusy) then
      begin
          if (firstSource.getNextClaimTime() < secondSource.getNextClaimTime()) then
          begin
            firstSource.generateNextClaim();
            firstSource.incrementationFailure();
          end else
          begin
            secondSource.generateNextClaim();
            secondSource.incrementationFailure();
          end;
      end else
      if (firstSource.getNextClaimTime < secondSource.getNextClaimTime()) then
      begin
          if (firstSource.getNextClaimTime() < mainPerfomer.getTimeRelease()) then
          begin
            mainQueue.push(getClaim(firstSource));
            firstSource.generateNextClaim(); 
          end
          end else
          begin
            if (secondSource.getNextClaimTime() < mainPerfomer.getTimeRelease()) then
            begin
              mainQueue.push(getClaim(secondSource));
              secondSource.generateNextClaim(); 
            end;
      end;
      end;
      mainQueue.correcting(mainPerfomer);
      if (mainPerfomer.getTimeRelease <= mainQueue.get().getNextClaimTime()) then
      begin
        sourceNumber := mainPerfomer.release();
        case sourceNumber of
          1 : firstSource.incrementationProcessedClaim();
          2 : secondSource.incrementationProcessedClaim();
        end;
        mainPerfomer.GenerateTimeRelease(mainQueue.get().getNextClaimTime());
        mainPerfomer.pushClaim(getClaim(mainQueue.get()));
        mainQueue.pop();
      end;
    if (mainPerfomer.getTimeRelease() > 100000) then
    begin
      lambda := lambda + 0.1;
      break;
    end;
    end; //end of main cycle
    while not (mainQueue.isEmpty()) do
    begin
      sourceNumber := mainQueue.get().getSourceNumber();
      mainQueue.pop();
      case sourceNumber of
          1 : firstSource.incrementationFailure();
          2 : secondSource.incrementationFailure();
      end;
    end;
    writeln(firstSource.getFailureCount(),' ',firstSource.getProcessedClaimCount(),' ',firstSource.getCurrentClaimNumber());
    mainRepository.setter(1,i,firstSource.getFailureCount());
    mainRepository.setter(2,i,secondSource.getFailureCount());
    writeln(secondSource.getFailureCount(),' ',secondSource.getProcessedClaimCount(),' ',secondSource.getCurrentClaimNumber());
  end;
  main(mainRepository);
  close(f);
end.