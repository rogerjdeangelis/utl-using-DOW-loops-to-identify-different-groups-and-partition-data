%let pgm=utl-using-DOW-loops-to-identify-different-groups-and-partition-data;                                                            
                                                                                                                                         
Using DOW loops to identify different groups and partition data                                                                          
                                                                                                                                         
     Four Solutions                                                                                                                      
                                                                                                                                         
          a. General solution - best solution                                                                                            
             Has many applications ( need to know how many patients taking mutiple                                                       
             different combiations of drugs quickly)                                                                                     
             Richard DeVenezia <rdevenezia@GMAIL.COM>                                                                                    
                                                                                                                                         
          b. DOW Loop                                                                                                                    
                                                                                                                                         
          c. proc sql and datastep view                                                                                                  
                                                                                                                                         
          d. merge then set DOW                                                                                                          
             Keintz, Mark                                                                                                                
             mkeintz@wharton.upenn.edu                                                                                                   
                                                                                                                                         
             The DOW loop solution can benefit by replacing the first DOW with a merge/by,                                               
             which allows the code for explicit tracking of index categories to                                                          
             be replaced by data set name options:                                                                                       
                                                                                                                                         
github                                                                                                                                   
https://tinyurl.com/ycnlyqvu                                                                                                             
https://github.com/rogerjdeangelis/utl-using-DOW-loops-to-identify-different-groups-and-partition-data                                   
                                                                                                                                         
macros                                                                                                                                   
https://tinyurl.com/y9nfugth                                                                                                             
https://github.com/rogerjdeangelis/utl-macros-used-in-many-of-rogerjdeangelis-repositories                                               
                                                                                                                                         
Other DOW repos                                                                                                                          
https://github.com/rogerjdeangelis?tab=repositories&q=DOW+in%3Aname&type=&language=                                                      
                                                                                                                                         
I need to identify certain combinations of subjects taken by my students and create two tables.                                          
                                                                                                                                         
   a. Students taking with Math and Science in their course load                                                                         
   b. Students taking with Math and Music in their course load                                                                           
                                                                                                                                         
Note a student may be in both groups in he/she is taking all three subjects                                                              
                                                                                                                                         
/*                   _                                                                                                                   
(_)_ __  _ __  _   _| |_                                                                                                                 
| | `_ \| `_ \| | | | __|                                                                                                                
| | | | | |_) | |_| | |_                                                                                                                 
|_|_| |_| .__/ \__,_|\__|                                                                                                                
        |_|                                                                                                                              
*/                                                                                                                                       
                                                                                                                                         
data have;                                                                                                                               
 input ID Index$;                                                                                                                        
cards4;                                                                                                                                  
 1 Math                                                                                                                                  
 1 Science                                                                                                                               
 1 Music                                                                                                                                 
 2 Math                                                                                                                                  
 2 Science                                                                                                                               
 3 Music                                                                                                                                 
 3 Science                                                                                                                               
 3 Math                                                                                                                                  
 4 Music                                                                                                                                 
;;;;                                                                                                                                     
run;quit;                                                                                                                                
                                                                                                                                         
/*                                                                                                                                       
WORK.HAVE total obs=9                                                                                                                    
                                                                                                                                         
                 | RULES                                                                                                                 
                 |                                                                                                                       
  ID    INDEX    |                                                                                                                       
                 |                                                                                                                       
   1    Math     | In set MS ("Math","SCIENCE") and MM ("Math","MUSIC")                                                                  
   1    Science  |                                                                                                                       
   1    Music    |                                                                                                                       
                 |                                                                                                                       
   2    Math     | In set MS ("Math","SCIENCE") but not MM ("Math","MUSIC")                                                              
   2    Science  |                                                                                                                       
                 |                                                                                                                       
   3    Music    | In set MS ("Math","SCIENCE") and MM ("Math","MUSIC")                                                                  
   3    Science  |                                                                                                                       
   3    Math     |                                                                                                                       
                 |                                                                                                                       
   4    Music    | Not in either do not output                                                                                           
                                                                                                                                         
*/                                                                                                                                       
                                                                                                                                         
/*                   _     _               _                                                                                             
(_)_ __  _ __  _   _| |_  | |__   ___  ___| |_                                                                                           
| | `_ \| `_ \| | | | __| | `_ \ / _ \/ __| __|                                                                                          
| | | | | |_) | |_| | |_  | |_) |  __/\__ \ |_                                                                                           
|_|_| |_| .__/ \__,_|\__| |_.__/ \___||___/\__|                                                                                          
        |_|                                                                                                                              
*/                                                                                                                                       
                                                                                                                                         
WORK.HAVE total obs=12                                                                                                                   
                                                                                                                                         
  ID    INDEX                                                                                                                            
                                                                                                                                         
   1    Math                                                                                                                             
   1    Science                                                                                                                          
   1    Music                                                                                                                            
   2    Math                                                                                                                             
   2    Science                                                                                                                          
   3    Music                                                                                                                            
   3    Science                                                                                                                          
   3    Math                                                                                                                             
   4    Music                                                                                                                            
   5    SAS                                                                                                                              
   5    Poetry                                                                                                                           
   6    Rumbling                                                                                                                         
                                                                                                                                         
                                                                                                                                         
/*           _               _                                                                                                           
  ___  _   _| |_ _ __  _   _| |_                                                                                                         
 / _ \| | | | __| `_ \| | | | __|                                                                                                        
| (_) | |_| | |_| |_) | |_| | |_                                                                                                         
 \___/ \__,_|\__| .__/ \__,_|\__|                                                                                                        
           _    |_|        _                                                                                                             
  __ _    | |__   ___  ___| |_                                                                                                           
 / _` |   | `_ \ / _ \/ __| __|                                                                                                          
| (_| |_  | |_) |  __/\__ \ |_                                                                                                           
 \__,_(_) |_.__/ \___||___/\__|                                                                                                          
                                                                                                                                         
 Richard DeVenezia <rdevenezia@GMAIL.COM>                                                                                                
*/                                                                                                                                       
                                                                                                                                         
WORK.WANT total obs=11                                                                                                                   
                                                                                                                                         
                          NUM_                                                                                                           
  SUBJECTS              SUBJECTS                                                                                                         
                                                                                                                                         
  *none*                    1     Rumbling                                                                                               
  Math                      3                                                                                                            
  Math,Music                2                                                                                                            
  Math,Science              3                                                                                                            
  Math,Science,Music        2                                                                                                            
  Music                     3                                                                                                            
  Poetry                    1                                                                                                            
  SAS                       1                                                                                                            
  SAS,Poetry                1                                                                                                            
  Science                   3                                                                                                            
  Science,Music             2                                                                                                            
                                                                                                                                         
                                                                                                                                         
/*     _   _                                                                                                                             
  ___ | |_| |__   ___ _ __ ___                                                                                                           
 / _ \| __| `_ \ / _ \ `__/ __|                                                                                                          
| (_) | |_| | | |  __/ |  \__ \                                                                                                          
 \___/ \__|_| |_|\___|_|  |___/                                                                                                          
                                                                                                                                         
*/                                                                                                                                       
                                                                                                                                         
                                                                                                                                         
Students who have both math and music in their courseload                                                                                
=========================================================                                                                                
                                                                                                                                         
 WORK.MM total obs=6                                                                                                                     
                                                                                                                                         
 ID    INDEX                                                                                                                             
                                                                                                                                         
  1    Music         (Math and musix students)                                                                                           
  1    Math                                                                                                                              
  1    Science                                                                                                                           
                                                                                                                                         
  3    Science                                                                                                                           
  3    Music                                                                                                                             
  3    Math                                                                                                                              
                                                                                                                                         
                                                                                                                                         
Students who have both math and science in their courseload                                                                              
===========================================================                                                                              
                                                                                                                                         
WORK.MS total obs=8                                                                                                                      
                                                                                                                                         
  ID    INDEX                                                                                                                            
                                                                                                                                         
   1    Math         (Math and science students)                                                                                         
   1    Science                                                                                                                          
   1    Music                                                                                                                            
                                                                                                                                         
   2    Math                                                                                                                             
   2    Science                                                                                                                          
                                                                                                                                         
   3    Music                                                                                                                            
   3    Science                                                                                                                          
   3    Math                                                                                                                             
                                                                                                                                         
/*                                                                                                                                       
 _ __  _ __ ___   ___ ___  ___ ___                                                                                                       
| `_ \| `__/ _ \ / __/ _ \/ __/ __|                                                                                                      
| |_) | | | (_) | (_|  __/\__ \__ \                                                                                                      
| .__/|_|  \___/ \___\___||___/___/                                                                                                      
|_|        ____            __                                                                                                            
  __ _    | __ )  ___  ___| |_                                                                                                           
 / _` |   |  _ \ / _ \/ __| __|                                                                                                          
| (_| |_  | |_) |  __/\__ \ |_                                                                                                           
 \__,_(_) |____/ \___||___/\__|                                                                                                          
                                                                                                                                         
*/                                                                                                                                       
Roger:                                                                                                                                   
                                                                                                                                         
Interesting problem that can be processed using multilabel formatting after                                                              
mapping the 'index' to a bit value and aggregating those bits for each ID                                                                
to a single value representing index 'memberships'.                                                                                      
                                                                                                                                         
How a bit for each 'index' is assigned can be either an apriori list, or                                                                 
constructed dynamically from an initial parse over the data.                                                                             
/*                   _                                                                                                                   
(_)_ __  _ __  _   _| |_                                                                                                                 
| | `_ \| `_ \| | | | __|                                                                                                                
| | | | | |_) | |_| | |_                                                                                                                 
|_|_| |_| .__/ \__,_|\__|                                                                                                                
        |_|                                                                                                                              
*/                                                                                                                                       
                                                                                                                                         
data have;                                                                                                                               
 length id 8 index $10;                                                                                                                  
 input ID Index $;                                                                                                                       
cards4;                                                                                                                                  
 1 Math                                                                                                                                  
 1 Science                                                                                                                               
 1 Music                                                                                                                                 
 2 Math                                                                                                                                  
 2 Science                                                                                                                               
 3 Music                                                                                                                                 
 3 Science                                                                                                                               
 3 Math                                                                                                                                  
 4 Music                                                                                                                                 
 5 SAS                                                                                                                                   
 5 Poetry                                                                                                                                
 6 Rumbling                                                                                                                              
;;;;                                                                                                                                     
run;quit;                                                                                                                                
                                                                                                                                         
WORK.HAVE total obs=12                                                                                                                   
                                                                                                                                         
  ID    INDEX                                                                                                                            
                                                                                                                                         
   1    Math                                                                                                                             
   1    Science                                                                                                                          
   1    Music                                                                                                                            
   2    Math                                                                                                                             
   2    Science                                                                                                                          
   3    Music                                                                                                                            
   3    Science                                                                                                                          
   3    Math                                                                                                                             
   4    Music                                                                                                                            
   5    SAS                                                                                                                              
   5    Poetry                                                                                                                           
   6    Rumbling                                                                                                                         
                                                                                                                                         
/*           _               _                                                                                                           
  ___  _   _| |_ _ __  _   _| |_                                                                                                         
 / _ \| | | | __| `_ \| | | | __|                                                                                                        
| (_) | |_| | |_| |_) | |_| | |_                                                                                                         
 \___/ \__,_|\__| .__/ \__,_|\__|                                                                                                        
                |_|                                                                                                                      
*/                                                                                                                                       
                                                                                                                                         
                                                                                                                                         
 WORK.WANT total obs=11                                                                                                                  
                                                                                                                                         
  SUBJECT Combinations  Num_Students                                                                                                     
                                                                                                                                         
  *none*                     1        Rumbling                                                                                           
  Math                       3                                                                                                           
  Math,Music                 2                                                                                                           
  Math,Science               3                                                                                                           
  Math,Science,Music         2                                                                                                           
  Music                      3                                                                                                           
  Poetry                     1                                                                                                           
  SAS                        1                                                                                                           
  SAS,Poetry                 1                                                                                                           
  Science                    3                                                                                                           
  Science,Music              2                                                                                                           
                                                                                                                                         
/*                                                                                                                                       
 _ __  _ __ ___   ___ ___  ___                                                                                                           
| `_ \| `__/ _ \ / __/ _ \/ __|                                                                                                          
| |_) | | | (_) | (_|  __/\__ \                                                                                                          
| .__/|_|  \___/ \___\___||___/                                                                                                          
|_|                                                                                                                                      
*/                                                                                                                                       
                                                                                                                                         
* apriori bit assignments;                                                                                                               
data bits;                                                                                                                               
  length bitmap $9 bit 8 index $10;                                                                                                      
  input bit index$;                                                                                                                      
  bitmap=put(bit, binary9.);                                                                                                             
cards4;                                                                                                                                  
 1 Math                                                                                                                                  
 2 Science                                                                                                                               
 4 Music                                                                                                                                 
 8 Philosophy                                                                                                                            
16 Literature                                                                                                                            
32 Gym                                                                                                                                   
64 Rocketry                                                                                                                              
128 SAS                                                                                                                                  
256 Poetry                                                                                                                               
;;;;                                                                                                                                     
run;                                                                                                                                     
                                                                                                                                         
/*                                                                                                                                       
WORK.BITS total obs=9                                                                                                                    
                                                                                                                                         
  BITMAP      BIT    INDEX                                                                                                               
                                                                                                                                         
 000000001      1    Math                                                                                                                
 000000010      2    Science                                                                                                             
 000000100      4    Music                                                                                                               
 000001000      8    Philosophy                                                                                                          
 000010000     16    Literature                                                                                                          
 000100000     32    Gym                                                                                                                 
 001000000     64    Rocketry                                                                                                            
 010000000    128    SAS                                                                                                                 
 100000000    256    Poetry                                                                                                              
*/                                                                                                                                       
                                                                                                                                         
* informat to map index to bit 'mask' value;                                                                                             
data cntl;                                                                                                                               
  set bits end=end;                                                                                                                      
  fmtname = '@idxbit';       * @ for informat;                                                                                           
                                                                                                                                         
  output;                                                                                                                                
  if end then do;                                                                                                                        
    hlo = 'o';                                                                                                                           
    bit = .;                                                                                                                             
    output;                                                                                                                              
  end;                                                                                                                                   
run;                                                                                                                                     
                                                                                                                                         
proc format cntlin=cntl(rename=(index=start bit=label));                                                                                 
run;                                                                                                                                     
                                                                                                                                         
* format to map bit 'mask' value to index;                                                                                               
data cntl2;                                                                                                                              
  set bits end=end;                                                                                                                      
  fmtname = 'bitidx';                                                                                                                    
                                                                                                                                         
  output;                                                                                                                                
  if end then do;                                                                                                                        
    hlo = 'o';                                                                                                                           
    index = '?';                                                                                                                         
    output;                                                                                                                              
  end;                                                                                                                                   
run;                                                                                                                                     
                                                                                                                                         
proc format cntlin=cntl2(rename=(bit=start index=label));                                                                                
run;                                                                                                                                     
                                                                                                                                         
* multilabel format, for each value determine each subset of bits and the                                                                
corresponding index list;                                                                                                                
data bitss;                                                                                                                              
  retain fmtname 'bitlists';                                                                                                             
  retain HLO 'SM';                                                                                                                       
                                                                                                                                         
  bits = 0;                                                                                                                              
                                                                                                                                         
  length list $120;                                                                                                                      
  list = '*none*';                                                                                                                       
                                                                                                                                         
  output;                                                                                                                                
                                                                                                                                         
  if 0 then set bits nobs=top_bit;                                                                                                       
                                                                                                                                         
  do bits = 1 to 2**top_bit - 1;                                                                                                         
    do bitss = 1 to bits;                                                                                                                
      if band(bits,bitss) = bitss then do;                                                                                               
        v = 1;                                                                                                                           
        list = '';                                                                                                                       
        do bit = 1 to top_bit;                                                                                                           
          if band(bitss,v) then do;                                                                                                      
            list = catx(',', list, put(v,bitidx.));                                                                                      
          end;                                                                                                                           
          v = v * 2;                                                                                                                     
        end;                                                                                                                             
        output;                                                                                                                          
      end;                                                                                                                               
    end;                                                                                                                                 
  end;                                                                                                                                   
  stop;                                                                                                                                  
  keep fmtname hlo bits list;                                                                                                            
run;                                                                                                                                     
                                                                                                                                         
proc format cntlin=bitss(rename=(bits=start list=label));                                                                                
run;                                                                                                                                     
                                                                                                                                         
* for each ID compute bit value that is aggregate of index 'memberships';                                                                
data havebits;                                                                                                                           
  bits = 0;                                                                                                                              
  do until (last.id);                                                                                                                    
    set have;                                                                                                                            
    by id;                                                                                                                               
                                                                                                                                         
    bits = bor ( bits, coalesce ( input (index, idxbit.), 0 ) );                                                                         
  end;                                                                                                                                   
                                                                                                                                         
  keep id bits;                                                                                                                          
run;                                                                                                                                     
                                                                                                                                         
                                                                                                                                         
ods html file='tabulate.html' style=plateau;                                                                                             
                                                                                                                                         
proc tabulate data=havebits;                                                                                                             
  class bits / mlf;  * multilabel format;                                                                                                
  table bits, n='# of Students with combination';                                                                                        
  format bits bitlists.;                                                                                                                 
  label bits = 'Student Indexes, all combinations (MLF)';                                                                                
run;                                                                                                                                     
                                                                                                                                         
ods html close;                                                                                                                          
                                                                                                                                         
                                                                                                                                         
%utl_odsrpt(setup);                                                                                                                      
options formchar="|";                                                                                                                    
proc tabulate data=havebits;                                                                                                             
  class bits / mlf;  * multilabel format;                                                                                                
  table bits="", n="Num_Students"/ box="Subjects" ;                                                                                      
  format bits bitlists.;                                                                                                                 
run;                                                                                                                                     
%utl_odsrpt(outdsn=want);                                                                                                                
                                                                                                                                         
/*            _                                                                                                                          
| |__      __| | _____      __                                                                                                           
| `_ \    / _` |/ _ \ \ /\ / /                                                                                                           
| |_) |  | (_| | (_) \ V  V /                                                                                                            
|_.__(_)  \__,_|\___/ \_/\_/                                                                                                             
                                                                                                                                         
*/                                                                                                                                       
                                                                                                                                         
data have;                                                                                                                               
 input ID Index$;                                                                                                                        
cards4;                                                                                                                                  
 1 Math                                                                                                                                  
 1 Science                                                                                                                               
 1 Music                                                                                                                                 
 2 Math                                                                                                                                  
 2 Science                                                                                                                               
 3 Music                                                                                                                                 
 3 Science                                                                                                                               
 3 Math                                                                                                                                  
 4 Music                                                                                                                                 
;;;;                                                                                                                                     
run;quit;                                                                                                                                
                                                                                                                                         
proc datasets lib=work;                                                                                                                  
  delete mm ms;                                                                                                                          
run;quit;                                                                                                                                
                                                                                                                                         
data MS MM;                                                                                                                              
                                                                                                                                         
  do until(last.id);                                                                                                                     
                                                                                                                                         
    set have;                                                                                                                            
    by id;                                                                                                                               
                                                                                                                                         
    * set flags by id;                                                                                                                   
    select (index);                                                                                                                      
       when ("Math   ") flgA=1;                                                                                                          
       when ("Science") flgB=1;                                                                                                          
       when ("Music  ") flgC=1;                                                                                                          
    end;                                                                                                                                 
  end;                                                                                                                                   
                                                                                                                                         
  do until(last.id);                                                                                                                     
    * cycle through the data again and use the flags to split data;                                                                      
    set have;                                                                                                                            
    by id;                                                                                                                               
                                                                                                                                         
    if ( flgA*flgB = 1 ) then output ms;                                                                                                 
    if ( flgA*flgC = 1 ) then output mm;                                                                                                 
  end;                                                                                                                                   
                                                                                                                                         
  flgA=0;                                                                                                                                
  flgB=0;                                                                                                                                
  flgC=0;                                                                                                                                
  drop flg:;                                                                                                                             
run;quit;                                                                                                                                
/*                  _                                                                                                                    
  ___     ___  __ _| |                                                                                                                   
 / __|   / __|/ _` | |                                                                                                                   
| (__ _  \__ \ (_| | |                                                                                                                   
 \___(_) |___/\__, |_|                                                                                                                   
                 |_|                                                                                                                     
*/                                                                                                                                       
                                                                                                                                         
data have;                                                                                                                               
 input ID Index$;                                                                                                                        
cards4;                                                                                                                                  
 1 Math                                                                                                                                  
 1 Science                                                                                                                               
 1 Music                                                                                                                                 
 2 Math                                                                                                                                  
 2 Science                                                                                                                               
 3 Music                                                                                                                                 
 3 Science                                                                                                                               
 3 Math                                                                                                                                  
 4 Music                                                                                                                                 
;;;;                                                                                                                                     
run;quit;                                                                                                                                
                                                                                                                                         
proc datasets lib=work;                                                                                                                  
  delete mm ms;                                                                                                                          
run;quit;                                                                                                                                
                                                                                                                                         
                                                                                                                                         
proc sql;                                                                                                                                
   create                                                                                                                                
      table want_pre as                                                                                                                  
   select                                                                                                                                
     *                                                                                                                                   
     ,max(index="Math")*max(index="Science") as flg_ms                                                                                   
     ,max(index="Math")*max(index="Music")   as flg_mm                                                                                   
   from                                                                                                                                  
     have                                                                                                                                
   group                                                                                                                                 
     by id                                                                                                                               
;quit;                                                                                                                                   
                                                                                                                                         
data mm ms;                                                                                                                              
  set want_pre;                                                                                                                          
  if flg_ms then output ms;                                                                                                              
  if flg_mm then output mm;                                                                                                              
run;quit;                                                                                                                                
                                                                                                                                         
/*   _                                                                                                                                   
  __| |    _ __ ___   ___ _ __ __ _  ___                                                                                                 
 / _` |   | `_ ` _ \ / _ \ `__/ _` |/ _ \                                                                                                
| (_| |_  | | | | | |  __/ | | (_| |  __/                                                                                                
 \__,_(_) |_| |_| |_|\___|_|  \__, |\___|                                                                                                
                              |___/                                                                                                      
*/                                                                                                                                       
                                                                                                                                         
                                                                                                                                         
data have;                                                                                                                               
 input ID Index$;                                                                                                                        
cards4;                                                                                                                                  
 1 Math                                                                                                                                  
 1 Science                                                                                                                               
 1 Music                                                                                                                                 
 2 Math                                                                                                                                  
 2 Science                                                                                                                               
 3 Music                                                                                                                                 
 3 Science                                                                                                                               
 3 Math                                                                                                                                  
 4 Music                                                                                                                                 
;;;;                                                                                                                                     
run;quit;                                                                                                                                
                                                                                                                                         
proc datasets lib=work;                                                                                                                  
  delete mm ms;                                                                                                                          
run;quit;                                                                                                                                
                                                                                                                                         
/*                                                                                                                                       
The DOW loop solution can benefit by replacing the first DOW with a merge/by,                                                            
which allows the code for explicit tracking of index categories to                                                                       
be replaced by data set name options:                                                                                                    
*/                                                                                                                                       
                                                                                                                                         
data mm (where=(flagmm=1))  ms (where=(flagms=1));                                                                                       
  merge have (where=(index='Math')    in=inmth)                                                                                          
        have (where=(index='Music')   in=inmus)                                                                                          
        have (where=(index='Science') in=insci);                                                                                         
  by id;                                                                                                                                 
                                                                                                                                         
  if last.id;                                                                                                                            
  flagms=inmth and insci;                                                                                                                
  flagmm=inmth and inmus;                                                                                                                
  do until (last.id);                                                                                                                    
    set have;                                                                                                                            
    by id;                                                                                                                               
    output;                                                                                                                              
  end;                                                                                                                                   
                                                                                                                                         
run;                                                                                                                                     
                                                                                                                                         
                                                                                                                                         
                                                                                                                                         
                                                                                                                                         
                                                                                                                                         
                                                                                                      
