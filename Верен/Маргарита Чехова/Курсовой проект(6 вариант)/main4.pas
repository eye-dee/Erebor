uses
  QueueUnit, SourceUnit, PerfomerUnit,Canvas,Data,graphABC;

const
  input = 'input.txt';   //input file
  output = 'output.txt';  //output file

var  
  firstSource: source; 
  secondSource: source;
  mainQueue: queue := new queue();  //buffer
  mainPerfomer: perfomer; 
  Time: integer;
  f: text;
  sourceNumber : integer;
  lambda : real;
  tau : integer;
  inp : text;  //file for inputing
  mainRepository : repository := new repository();
  i : integer;
  Kmin : integer;
  flag : boolean;

begin
  lambda := 0.5;
  i := 0;
  InitGraph();
  DataInputing(Kmin,flag);
  drawAxesSystem();
  assign(f, output);
  rewrite(f);
  while (lambda < 1.505) do
  begin 
    i := i+1;
    changeColor(i);
    randomize;
    firstSource := new source(1);
    secondSource := new source(2);
    mainPerfomer := new perfomer(lambda);
    Time := 0;
    //writeln(f,'queue ', 'mainPerfomerTime ', 'firstSourceTime ', 'secondSourceTime ', 'count');
    while (true) do
    begin
     { if not(mainQueue.isEmpty()) then
        writeln(f,mainQueue.get().getNextClaimTime(), mainPerfomer.getTimeRelease():17, firstSource.getNextClaimTime: 17, secondSource.getNextClaimTime(): 17, mainQueue.getCount(): 5)
      else
        writeln(f,'NaN', mainPerfomer.getTimeRelease():17, firstSource.getNextClaimTime: 17, secondSource.getNextClaimTime(): 17, mainQueue.getCount(): 5);}
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
      if (mainPerfomer.getTimeRelease() <= mainQueue.get().getNextClaimTime()) then
      begin
        sourceNumber := mainPerfomer.release();
        draw(firstsource.getCurrentClaimNumber(),firstSource.getFailureCount());
        //sleep(5);
        case sourceNumber of
          1 : firstSource.incrementationProcessedClaim();
          2 : secondSource.incrementationProcessedClaim();
        end;
        mainPerfomer.GenerateTimeRelease(mainQueue.get().getNextClaimTime());
        mainPerfomer.pushClaim(getClaim(mainQueue.get()));
        mainQueue.Calculate();
        mainQueue.pop();
      end;
    if (firstSource.getCurrentClaimNumber() > Kmin) and (secondSource.getCurrentClaimNumber() > Kmin) then //Kmin задать пользователем
    begin
      lambda := lambda + 0.1;
      break;
    end;
    end; //end of main cycle
    while not (mainQueue.isEmpty()) do
    begin
      sourceNumber := mainQueue.get().getSourceNumber();
      mainQueue.Calculate();
      mainQueue.pop();
      case sourceNumber of
          1 : firstSource.incrementationFailure();
          2 : secondSource.incrementationFailure();
      end;
    end;
    //sleep(500);
    mainRepository.setClaim(1,i,firstSource.getFailureCount(),firstSource.getProcessedClaimCount(),firstSource.getCurrentClaimNumber());
    mainRepository.setClaim(2,i,secondSource.getFailureCount(),secondSource.getProcessedClaimCount(),secondSource.getCurrentClaimNumber());
    mainrepository.setCount(i,mainQueue.getMiddleCount());
    mainQueue.nulling();
    if (flag) then
    begin
      clearWindow();
      drawAxesSystem();
    end;
  end;
  
  close(f);
  main(mainRepository);
  
end.