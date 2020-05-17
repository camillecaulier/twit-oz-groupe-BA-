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
   
   
    
   N_diagramme = {Dictionary.new} %dictionary to put all the N diagram analysis in
   Count= {NewCell 0}             %variable to know when the streams have been completed
   
   
   
   
   Port_1 = {CreatePortParse Algo.parse N_diagramme Count}
   Port_2 = {CreatePortParse Algo.parse N_diagramme Count}
   Port_3 = {CreatePortParse Algo.parse N_diagramme Count}
   Port_4 = {CreatePortParse Algo.parse N_diagramme Count}

   

   thread{Reader.file_reading 1 Port_1}end %will read files 1->52
   thread{Reader.file_reading 2 Port_2}end %will read files 53->104
   thread{Reader.file_reading 3 Port_3}end %will read files 105->156
   thread{Reader.file_reading 4 Port_4}end %will read files 157->208
   
   
    
%%% GUI
    % Make the window description, all the parameters are explained here:
    % http://mozart2.org/mozart-v1/doc-1.4.0/mozart-stdlib/wp/qtk/html/node7.html)
   Text1 Text2 Description=td(
			      title: "Frequency count"
			      lr(
				 text(handle:Text1 width:28 height:5 background:white foreground:black wrap:word)
				 button(text:"Automatic fill" action:AutomaticFill)
				 button(text:"recommendation" action:Recommend)
				 button(text:"exit" action:Exit)
				 
				 )
			      text(handle:Text2 width:28 height:5 background:black foreground:white glue:w wrap:word)
			      action:proc{$}{Application.exit 0} end % quit app gracefully on window closing
			      
			      )
   proc {FilterPunctuation Word}
      local LastLetter Length in %to filter out the last letter if it's a punctuation or
	 LastLetter = {List.last @Word}
	 if LastLetter == 32 orelse LastLetter ==33 orelse LastLetter==46 orelse LastLetter==34 orelse LastLetter == 38 orelse LastLetter==40 orelse LastLetter==41 orelse LastLetter==58 orelse LastLetter==59 orelse LastLetter==63 orelse LastLetter == 42 orelse LastLetter==60 orelse LastLetter== 61 orelse LastLetter== 62 orelse LastLetter== 96 orelse LastLetter==123 orelse LastLetter== 124 orelse LastLetter== 125 orelse LastLetter==126 then
	    Length = {List.length @Word}
	    Word := {List.take @Word (Length-1)} 
	    {FilterPunctuation Word}
	 end
      end
   end
   
	 
      
   proc {AutomaticFill} Inserted ToInsert N L Prob Line Word PastWord in

      Inserted ={Text1 getText(p(1 0) 'end' $)} 
      N = {List.length Inserted}
      L = {List.take Inserted (N-1)}     
      Line = {String.tokens L 32}
      Word= {NewCell {List.last Line}}
      
      PastWord = {List.last Line} % this is so that we can keep the old form of the line with the punctaution

      Prob = {Algo.reachMostProb N_diagramme {String.toAtom @Word}}
      
      if Prob == nil then
	 {Text2 set(1:"Donald Trump doesn't use that word really often sorry or you have misspelled the word")}
      else
	 ToInsert = ' '#Prob
	 
	 
	 {Text1 tk(insert 'end' ToInsert)}
      end
   end
   
   proc{Recommend}
      Inserted ToInsert N L Prob Line Word in
      Inserted ={Text1 getText(p(1 0) 'end' $)}
      N = {List.length Inserted}
      L = {List.take Inserted (N-1)}
      Line = {String.tokens L 32}
      Word = {List.last Line}
      Prob = {Algo.reachMostProb N_diagramme {String.toAtom Word}}
      if Prob == nil then
	 {Text2 set(1:"Donald Trump doesn't use that word really often sorry")}
      else
	 ToInsert= "Trump's favourite word after "#{String.toAtom Word}#" is: "#Prob
	 {Text2 set(1:ToInsert)}
      end
      
   end
   proc{Exit}
      {Application.exit 0}
   end
   
   W={QTk.build Description}
   {W show}

   
   {Text1 bind(event:"<Control-s>" action:AutomaticFill)} % You can also bind events

   {Show 'You can print in the terminal...'}

end
