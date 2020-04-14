uses
  QueueUnit, SourceUnit, PerfomerUnit,Canvas;

var  
  firstSource: source := new source(1);
  secondSource: source := new source(2);
  mainQueue: queue := new queue();
  mainPerfomer: perfomer := new perfomer();
  Time: integer;
  failureCount: integer;
  claimCount: integer;
  f: text;
  sourceNumber : integer;

begin
  randomize;
  claimCount := 2;
  failureCount := 0;
  Time := 0;
  assign(f, 'output.txt');
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
        inc(failureCount);
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
    {else
    begin
      if (firstSource.getNextClaimTime() < secondSource.getNextClaimTime()) then
      begin
        mainQueue.push(getClaim(firstSource));
        firstSource.generateNextClaim(); 
      end else // end of then-branch (firstSource.getNextClaimTime() < secondSource.getNextClaimTime())
      begin
        mainQueue.push(getClaim(secondSource));
        secondSource.generateNextClaim();
      end;
    end;}
  if (mainPerfomer.getTimeRelease() > 100000) then
      break;
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
  writeln(secondSource.getFailureCount(),' ',secondSource.getProcessedClaimCount(),' ',secondSource.getCurrentClaimNumber());
  //main();
  close(f);
end.