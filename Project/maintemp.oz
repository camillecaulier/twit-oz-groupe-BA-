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

   % Test = 'how are you'
   % Bettertest = [104 111 119 32 97 114 101 32 121 111 117] 
   % Testing = {Atom.toString Test}
   % Bettertesting = {String.toAtom Bettertest}
   % {Browse Testing}
   % {Browse Bettertesting}
   % if {Reader.scan {New Reader.textfile init(name:"tweets/part_1.txt")} 101}== nil
   % then {Show 'howdy'}
   Test_cell = {Cell.new nil}
   Test_cell := [1 2 3 4]
   {Show @Test_cell}
   if {Reader.scan {New Reader.textfile init(name:"tweets/part_1.txt")} 101} == none
   then {Show 'hello'}
   end
   
   
   fun{DocRead File_name}
      Cell_data = {Cell.new nil}
      Add = {Cell.new nil}
      Temp = {Cell.new nil}
      fun{Line_read Line}
	 Temp := {Reader.scan {New Reader.textfile init(name:File_name)} Line}
	 if {Reader.scan {New Reader.textfile init(name:File_name)} Line} == none
	 then
	    @Cell_data
	 else
	    Add := {List.append @Cell_data Temp}
	    Cell_data := @Add
	    {Line_read Line+1}
	 end
      end
   in
      {Line_read 1}
   end
   % fun{Para $}
   %    cell 0-100
   %    cell2
   %    threads
   %    thread
   % 	 thead
   % 	 thread
	    

   

   {Show 'chicken'}
   {Show {DocRead "tweets/part_1.txt"}}
   {Show 'chicken'}
   

   
   %32=> space
   
   
end

   