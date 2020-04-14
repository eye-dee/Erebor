const
  epsilon = 0.00001;

function fact(n : integer; var prev : real) : real; //функци€ вычисл€юща€ факториал
//чтобы не вычисл€ть каждый факториал заново, используем вычислени€ предыдущего
begin
  if(n = 1) or (n = 0) then
  begin
    prev := 1;
    fact := 1;
  end  else
  begin
    prev := prev*n;
    fact := prev;
  end;
end;

function seria1(n : integer) : real; //р€д первый
var
  temp : real;
begin
  temp := 1.0/power(n,n);
  if (n mod 2 = 0) then
    seria1 := -temp
  else
    seria1 := temp;
end;

function seria2(n : integer) : real; //второй и так дальше
begin
  seria2 := 1.0/power(2.0,n) + 1.0/power(3.0,n);
end;

function seria3(n : integer) : real;
begin
  seria3 := (2.0*n-1.0)/power(2.0,n);
end;

function seria4(n : integer) : real;
begin
  seria4 := 1.0/(3.0*n - 2.0)/(3.0*n + 1);
end;

function seria5(n : integer; var prevFact : real) : real;
begin
  seria5 := power(10.0,n)/fact(n,prevFact);
end;

function seria6(n : integer;prevResult : real) : real;
var
  i,prev : integer;
begin
  if (n = 1) then
    seria6 := 0.5
  else
    begin
    prevResult := prevResult*n;
    prev := (n-1)*2 + 1;
    for i := prev to 2*n do
    begin
      prevResult := prevResult/i;
    end;
  end;
end;

function seria7(n : integer; var prevFact : real) : real;
begin
  seria7 := fact(n,prevFact)/power(n,n);
end;

function seria8(n : integer; var prevFact : real) : real;
begin
  seria8 := power(2.0,n)*fact(n,prevFact)/power(n,n);
end;

function seria9(n : integer; prevResult : real) : real;
var
  i : integer;
  prev : integer;
begin
  if (n = 1) then
    seria9 := 1.5
  else
  begin
    prevResult := prevResult*3*n;
    prev := (n-1)*2 + 1;
    for i := prev to 2*n do
    begin
      prevResult := prevResult/i;
    end;
  end;
end;

function seria10(n : integer; var prevFact : real) : real;
begin
  seria10 := fact(n,prevFact)/3.0/power(n,n);
end;

function seria11(n : integer; prevResult : real) : real;
var
  i : integer;
  sum1,sum2 : real;
begin
  if (n = 1) then
    seria11 := 0.5
  else
  begin
    prevResult := prevResult*n;
    sum1 := power(2.0,n-1);
    sum2 := sum1*2;
    for i := round(sum1) + 1 to round(sum2) do
    begin
      prevResult := prevResult/i;
    end;
  end;
end;

function seria12(n : integer; prevResult : real) : real;
begin
  if (n = 1) then
    seria12 := 2.0
  else
    seria12 := prevResult*2.0/(n-1.0);
end;

VAR
  sum : real := 0.0;
  res : real;
  i : integer := 1;
  previousFact : real := 0.0;
  k : integer;

BEGIN
readln(k);

if (k = 1) then
begin
//////////////////////////////////////////////////
res := seria1(i);
while (abs(res) >= epsilon) do
begin
  sum := sum + res;
  i := i + 1;
  res := seria1(i);
end;
 writeln(sum)  ;
 sum := 0;
 i := 1;
 res := 0;
///////////////////////////////////////////////////
end;

if (k = 2) then
begin
//////////////////////////////////////////////////
res := seria2(i);
while (abs(res) >= epsilon) do
begin
  sum := sum + res;
  i := i + 1;
  res := seria2(i);
end;
 writeln(sum);
 sum := 0;
 i := 1;
 res := 0;
///////////////////////////////////////////////////
end;

if (k = 3) then
begin
//////////////////////////////////////////////////
res := seria3(i);
while (abs(res) >= epsilon) do
begin
  sum := sum + res;
  i := i + 1;
  res := seria3(i);
end;
 writeln(sum);
 sum := 0;
 i := 1;
 res := 0;
///////////////////////////////////////////////////
end;

if (k = 4) then
begin
//////////////////////////////////////////////////
res := seria4(i);
while (abs(res) >= epsilon) do
begin
  sum := sum + res;
  i := i + 1;
  res := seria4(i);
end;
 writeln(sum);
 sum := 0;
 i := 1;
 res := 0;
///////////////////////////////////////////////////
end;

if (k = 5) then
begin
//////////////////////////////////////////////////
res := seria5(i,previousFact);
while (abs(res) >= epsilon) do
begin
  sum := sum + res;
  i := i + 1;
  res := seria5(i,previousFact);
end;
 writeln(sum);
 sum := 0;
 i := 1;
 res := 0;
 previousFact := 0.0;
///////////////////////////////////////////////////
end;

if (k = 6) then
begin
//////////////////////////////////////////////////
res := seria6(i,res);
while (abs(res) >= epsilon) do
begin
  sum := sum + res;
  i := i + 1;
  res := seria6(i,res);
end;
 writeln(sum);
 sum := 0;
 i := 1;
 res := 0;
///////////////////////////////////////////////////
end;

if (k = 7) then
begin
//////////////////////////////////////////////////
res := seria7(i,previousFact);
while (abs(res) >= epsilon) do
begin
  sum := sum + res;
  i := i + 1;
  res := seria7(i,previousFact);
end;
 writeln(sum);
 sum := 0;
 i := 1;
 res := 0;
 previousFact := 0.0;
///////////////////////////////////////////////////
end;

if (k = 8) then
begin
//////////////////////////////////////////////////
res := seria8(i,previousFact);
while (abs(res) >= epsilon) do
begin
  sum := sum + res;
  i := i + 1;
  res := seria8(i,previousFact);
end;
 writeln(sum);
 sum := 0;
 i := 1;
 res := 0;
 previousFact := 0.0;
///////////////////////////////////////////////////
end;

if (k = 9) then
begin
//////////////////////////////////////////////////
res := seria9(i,res);
while (abs(res) >= epsilon) do
begin
  sum := sum + res;
  i := i + 1;
  res := seria9(i,res);
end;
 writeln(sum);
 sum := 0;
 i := 1;
 res := 0;
///////////////////////////////////////////////////
end;

if (k = 10) then
begin
//////////////////////////////////////////////////
res := seria10(i,previousFact);
while (abs(res) >= epsilon) do
begin
  sum := sum + res;
  i := i + 1;
  res := seria10(i,previousFact);
end;
 writeln(sum);
 sum := 0;
 i := 1;
 res := 0;
 previousFact := 0.0;
///////////////////////////////////////////////////
end;

if (k = 11) then
begin
//////////////////////////////////////////////////
res := seria11(i,res);
while (abs(res) >= epsilon) do
begin
  sum := sum + res;
  i := i + 1;
  res := seria11(i,res);
end;
 writeln(sum);
 sum := 0;
 i := 1;
 res := 0;
///////////////////////////////////////////////////
end;

if (k = 12) then
begin
//////////////////////////////////////////////////
res := seria12(i,res);
while (abs(res) >= epsilon) do
begin
  sum := sum + res;
  i := i + 1;
  res := seria12(i,res);
end;
 writeln(sum);
 sum := 0;
 i := 1;
 res := 0;
///////////////////////////////////////////////////
end;
END.