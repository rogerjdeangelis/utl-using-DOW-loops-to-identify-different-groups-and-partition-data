Using DOW loops to identify different groups and partition data Using DOW loops                                           
to identify different groups and partition data;                                                                          
                                                                                                                          
     Three Solutions                                                                                                      
                                                                                                                          
          a. DOW Loop                                                                                                     
                                                                                                                          
          b. proc sql and datastep view                                                                                   
                                                                                                                          
          c. merge then set DOW                                                                                           
             Keintz, Mark                                                                                                 
             mkeintz@wharton.upenn.edu                                                                                    
                                                                                                                          
             The DOW loop solution can benefit by replacing the first DOW with a merge/by,                                
             which allows the code for explicit tracking of index categories to                                           
             be replaced by data set name options:                                                                        
                                                                                                                          
github                                                                                                                    
https://tinyurl.com/ycnlyqvu                                                                                              
https://github.com/rogerjdeangelis/utl-using-DOW-loops-to-identify-different-groups-and-partition-data                    
                                                                                                                          
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
                                                                                                                          
/*           _               _                                                                                            
  ___  _   _| |_ _ __  _   _| |_                                                                                          
 / _ \| | | | __| `_ \| | | | __|                                                                                         
| (_) | |_| | |_| |_) | |_| | |_                                                                                          
 \___/ \__,_|\__| .__/ \__,_|\__|                                                                                         
                |_|                                                                                                       
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
|_|  _                 _                                                                                                  
  __| | _____      __ | | ___   ___  _ __                                                                                 
 / _` |/ _ \ \ /\ / / | |/ _ \ / _ \| `_ \                                                                                
| (_| | (_) \ V  V /  | | (_) | (_) | |_) |                                                                               
 \__,_|\___/ \_/\_/   |_|\___/ \___/| .__/                                                                                
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
                                                                                                                          
/*         _       _       _            _                                                                                 
 ___  __ _| |   __| | __ _| |_ __ _ ___| |_ ___ _ __                                                                      
/ __|/ _` | |  / _` |/ _` | __/ _` / __| __/ _ \ `_ \                                                                     
\__ \ (_| | | | (_| | (_| | || (_| \__ \ ||  __/ |_) |                                                                    
|___/\__, |_|  \__,_|\__,_|\__\__,_|___/\__\___| .__/                                                                     
        |_|                                    |_|                                                                        
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
                                                                                                                          
                                                                                                                          
/*                                                                                                                        
 _ __ ___   ___ _ __ __ _  ___                                                                                            
| `_ ` _ \ / _ \ `__/ _` |/ _ \                                                                                           
| | | | | |  __/ | | (_| |  __/                                                                                           
|_| |_| |_|\___|_|  \__, |\___|                                                                                           
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
                                                                                                                          
