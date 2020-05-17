functor
import
   QTk at 'x-oz://system/wp/QTk.ozf'
   System
   Application
   OS
   Browser
   Reader
   Algo
define
%%% Easier macros for imported functions
   Browse = Browser.browse
   Show = System.show

%%% Read File
   fun {GetFirstLine IN_NAME}
      {Reader.scan {New Reader.textfile init(name:IN_NAME)} 1}
   end
   
   %This function is used to create a stream
   %
   %@pre:
   %     Operation: The procedure to use on the elements contained in the stream. To be used in conjunction with the variables Dico and Number
   %     Operation will take Number,Dico and an item of the stream as variables. The code will execute Operation in a thread.
   %     In this code Operation will only be used to implement Algo.parse
   %     (to get further information please visit the documentation for Algo.parse)
   %
   %     Number: a cell variable to count how many streams have been completed.
   %
   %     Dico: a dictionary stocked with the values of the N diagram analysis.
   %
   %@post:
   %     Since the function uses only Algo.parse when the funciton is completed then we can say that the parsing is completed
   %
   %     Operation: Operation is a procedure and thus it will have only finished storing the values in the Dico (Dico is a dictionary).
   %
   %     Number: The cell will have a value of 3 stored in it.
   %
   %     Dico: Since the parsing is completed we will have all the necessary data obtained from parsing in this dictionary.
														      

   fun {CreatePortParse Operation Dico Number}
      Port Stream
   in
      Port={NewPort Stream}
      thread for Item in Stream do
		{Operation Dico Item Number}
	     end
      end
      Port
   end

   fun{CreatePortPro Operation}
      Port Stream
   in
      Port = {NewPort Stream}
      thread for Item in Stream do
		{Operation Item}
	     end
      end
      Port
   end
   

   fun {CreatePortRead Operation PortNumber Port1 Port2 Port3 Port4}
      Port Stream
   in
      Port = {NewPort Stream}
      thread for Item in Stream do
		{Operation PortNumber Port1 Port2 Port3 Port4}
	     end
      end
      Port
   end
   
   
   %lecture -> port -> dictionary   
   N_diagramme = {Dictionary.new}
   Count= {NewCell 0}
   
   
   
   
   Port_1 = {CreatePortParse Algo.parse N_diagramme Count}
   Port_2 = {CreatePortParse Algo.parse N_diagramme Count}
   Port_3 = {CreatePortParse Algo.parse N_diagramme Count}
   Port_4 = {CreatePortParse Algo.parse N_diagramme Count}

   % Port_1 = {CreatePortPro Show}
   % Port_2 = {CreatePortPro Show}
   % Port_3 = {CreatePortPro Show}
   % Port_4 = {CreatePortPro Show}

   % Port_1_reading = {CreatePortRead Reader.file_reading 0 Port_1 Port_2 Port_3 Port_4} %will read files 1->52
   % Port_2_reading = {CreatePortRead Reader.file_reading 1 Port_1 Port_2 Port_3 Port_4} %will read files 53->104
   % Port_3_reading = {CreatePortRead Reader.file_reading 2 Port_1 Port_2 Port_3 Port_4} %will read files 105->156
   % Port_4_reading = {CreatePortRead Reader.file_reading 3 Port_1 Port_2 Port_3 Port_4} %will read files 157->208

   thread{Reader.file_reading 1 Port_1}end
   thread{Reader.file_reading 2 Port_2}end
   thread{Reader.file_reading 3 Port_3}end
   thread{Reader.file_reading 4 Port_4}end
   
   
    
%%% GUI
    % Make the window description, all the parameters are explained here:
    % http://mozart2.org/mozart-v1/doc-1.4.0/mozart-stdlib/wp/qtk/html/node7.html)
   Text1 Description=td(
			      title: "Frequency count"
			      lr(
				 text(handle:Text1 width:28 height:5 background:white foreground:black wrap:word)
				 button(text:"Word recommendation" action:Press)
				 )
			     
			      action:proc{$}{Application.exit 0} end % quit app gracefully on window closing
			      )
   proc {Press} Inserted ToInsert N L Prob Line Word in
      Inserted ={Text1 getText(p(1 0) 'end' $)} % example using coordinates to get text
      N = {List.length Inserted}
      L = {List.take Inserted (N-1)}
      %{Show {String.toAtom Inserted}}
      Line = {String.tokens L 32}
      Word = {List.last Line}
      Prob = {Algo.reachMostProb N_diagramme {String.toAtom Word}}
      ToInsert= {List.append L {List.append 32|nil Prob}}
      
      {Text1 set(1:ToInsert)} % you can get/set text this way too
   end
    % Build the layout from the description 
   W={QTk.build Description}
   {W show}

   {Text1 tk(insert 'end' 'hello phone')}
   {Text1 bind(event:"<Control-s>" action:Press)} % You can also bind events

   %{Show 'You can print in the terminal...'}
   %{Browse '... or use the browser window'}
end
