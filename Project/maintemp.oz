functor %%%%%%%%%mai %C:\LINFO_1104_pardigmes_de_programation\twit-oz-groupe-BA-\Project
import
   QTk at 'x-oz://system/wp/QTk.ozf'
   System
   Application
   OS
   Browser

   Reader

   
define
   Browse = Browser.browse
   Show = System.show

   % fun {GetFirstLine IN_NAME}
   %    {Reader.scan {New Reader.textfile init(name:IN_NAME)} 1}
   % end
   %{Show {GetFirstLine "tweets/part_1.txt"}}
   
   %in a sense we will make a recursive program
   % Parse = {String.toAtom "tweets/part_1.txt"}
   
   % Value ={Reader.scan {New Reader.textfile init(name:Parse)} 1}
   % {Browse {String.toAtom Value}}

   Test = 'how are you...'
   Bettertest = [104 111 119 32 97 114 101 32 121 111 117] 
   Testing = {Atom.toString Test}
   Bettertesting = {String.toAtom Bettertest}
   {Browse Testing}
   {Browse Bettertesting}
   % if {Reader.scan {New Reader.textfile init(name:"tweets/part_1.txt")} 101}== nil
   % then {Show 'howdy'}
   	 

   
   %32=> space
   
   
end

   