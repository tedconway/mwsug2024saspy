* Bring Your SAS and Python Worlds Together With SASPy!
  Create SAS dataset from Excel workbook containing NBA salaries (source: espn.com/nba/stats);

proc import file='/home/ted.conway/NBA_2023_2024_SALARIES_FROM_ESPN.xlsx' out=nba_data dbms=xlsx;
                              
data myhome.nba_salary_data(drop=salary rename=(salaryn=SALARY)); * Data prep;
set nba_data;
POSITION=scan(name,-1);       * Grab player's position (last comma-delimited strin in name);     
salaryn=input(compress(salary,'$,'),best15.); * Convert salary to numeric (strip '$' and ',' chars);
format salaryn dollar15.;     * Format salary;
PLAYERS=1;                    * Make counter field available if needed; 
options nocenter;             * Sneak a peek at the data;
proc print data=myhome.nba_salary_data(obs=2);
proc freq data=myhome.nba_salary_data;
tables position conference division team;
run;