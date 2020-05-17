functor
import
   System
   Application
   QTk at 'x-oz://system/wp/QTk.ozf'
export
   updateWord:UpdateWord
   reachMostProb:ReachMostProb
   parse:Parse

define
   Show = System.show

   
   % Check if Word is a key of Dico.
   % If true: skip
   % If false: we initialize a new key (Word) in Dico (InitKey).
   fun {InDictTot Dico Word}
      local
	 fun {InitKey Dico Word}
	    local D in
	       D = {Dictionary.new}
	       {Dictionary.put Dico Word D}
	       false
	    end
	 end
      in
	 if {Dictionary.member Dico Word}
	 then true
	 else {InitKey Dico Word}
	 end
      end
   end


   % Update the dictionary 'Dico'for the sequence 'Word W'.
   % @pre: -'W' is the word following 'Word' in the text analyzed.
   %       -'Dico' is the dictionary where all the words and their followers are stocked.
   % @post: -if 'Word' is not already in 'Dico', we initialized it and then we add 'W' in its followers with a count of 1.
   %        -if 'Word' is already in 'Dico' but 'W' isn't already in its followers, we add 'W' with a count of 1.
   %        -if 'Word' is already in 'Dico' and 'W' is already in its followers, we increase by 1 the count of 'W'.
   proc{UpdateWord Dico Word W}
      local
	 proc {IncCountW D W}
	    local C Old in
	       {Dictionary.get D W C}
	       {Dictionary.exchange D W Old (C+1)}
	    end
	 end
      in
	 if {InDictTot Dico Word}
	 then
	    local D in
	       {Dictionary.get Dico Word D}
	       if {Dictionary.member D W}
	       then {IncCountW D W}
	       else
		  {Dictionary.put D W 1}
	       end
	    end
	 else
	    local D in
	       {Dictionary.get Dico Word D}
	       {Dictionary.put D W 1}
	    end
	 end
      end
   end


   % @pre: L is a list of tuples key#item from a dictionary.
   % @post: Returns a list of smaller lists [key item] from the tuples of L.   
   fun {TuplesToList L}
      local
	 fun {NextTuple L I N Ls}
	    if (N > I)
	    then Ls
	    else
	       local T Ts in
		  T = {Record.toList {List.nth L N}}
		  Ts = {List.append Ls [T]}
		  {NextTuple L I (N+1) Ts}
	       end
	    end
	 end
      in	 local I in
	    I = {List.length L}
	    {NextTuple L I 1 nil}
	 end
      end
   end


   % @pre: -'Dico' is the dictionary containing all the words from the text and their following word possibilities.
   %       -'Word' is the word used to predict the following word based on the probabilities.
   % @post: - returns the word with the highiest probability of following 'Word'.
   %        -if 'Word' wasn't in the analyzed text, returns 'Error: key not found'.
   fun {ReachMostProb Dico Word}
      local
	 fun {UpdateMostProb L I N M O}
	    if (N > I)
	    then M
	    else
	       local K Nbr in
		  Nbr = {List.nth {List.nth L N} 2}
		  if (Nbr > O)
		  then
		     K = {List.nth {List.nth L N} 1}
		     {UpdateMostProb L I (N+1) K Nbr}
		  else
		     {UpdateMostProb L I (N+1) M O}
		  end
	       end
	    end
	 end
      in
	 local D L S in
	    {Dictionary.condGet Dico Word nil D}
	    if {Dictionary.is D}
	    then
	       L = {Dictionary.entries D}
	       S = {TuplesToList L}
	       local I M O in
		  I = {List.length S}
		  M = {List.nth {List.nth S 1} 1}
		  O = {List.nth {List.nth S 1} 2}
		  {UpdateMostProb S I 2 M O}
	       end
	    else D
	    end
	 end
      end
   end

   %This function is used in the stream created by the function "createPort"
   %
   %@pre:
   %    Dico: Dico is a dictionary where we will store the N diagram analysis in.
   %
   %    Line: Line is in reality a tweet in Atom that has been stored in the stream. We will do an N diagram analysis on it
   %    if Line is equal to nil then that means we have reached the end of the stream and thus Count will augment by one.
   %
   %    Count: Stores the quantities of streams that have been completed.
   %
   %@post:
   %    Dico: The dictionary will have stored the relevant information obtained by the parsing to store in the dictionary.
   %    The stored value will be in VirtualString.
   %
   %    Line: nothing changes to this list of Atoms.
   %
   %    Count:Once the stream is completed it will augment by one. If this is the last stream to be completed then the procedure
   %    will show in the terminal "parsing completed" in order to inform the user that all four streams have been completed and the
   %    parsing is completed.
   %
   %Conditions:
   %    In the parsing we considered certain cases in order to keep a clean and comprehensible N diagram analysis. The code will neglect
   %    punctuations such as ".", ",", ")" etc... but we made exceptions with words with the "-", "/" and "#".  
   %
   
   proc{Parse Dico Line Count}
      
      Temp_1 Temp_2 Check_first Line_split in
      proc{Line_split Line_list}
	 
	 case Line_list of nil then
	    skip
	 [] H|T then 
	    if H == 32 then
	       
	       if @Check_first == 2 then %fullsotp then end
		  Temp_2 := {List.reverse @Temp_2}
		  Temp_2 := {VirtualString.toAtom @Temp_2}
		  
		  {UpdateWord Dico @Temp_1 @Temp_2}
		  Temp_1 := @Temp_2
		  Temp_2 := nil
		  {Line_split T}
   		  
	       else %in  case if it's 1 and 2 so one letter or a word 
		  Check_first := 2 
		  Temp_1 := {List.reverse @Temp_1}
		  Temp_1 := {VirtualString.toAtom @Temp_1}
		  {Line_split T}
   		 
	       end

            %common and plus is a word / and - ' 
	    elseif H==33 orelse H==46 orelse H==34 orelse H == 38 orelse H==40 orelse H==41 orelse H==58 orelse H==59 orelse H==63 orelse H == 42 orelse H==60 orelse H== 61 orelse H== 62 orelse H== 96 orelse H==123 orelse H== 124 orelse H== 125 orelse H==126 then
	       if T ==nil then %si un ponctuation c'est la fin 
		  Temp_2 := {List.reverse @Temp_2}
		  Temp_2 := {VirtualString.toAtom @Temp_2}
		  {UpdateWord Dico @Temp_1 @Temp_2}
	       else
		  {Line_split T}
	       end
	       
	    else
	       if @Check_first == 2 then 
		  Temp_2 := H|@Temp_2
		  if T ==nil then %quand on arrive a la fin 
		     Temp_2 := {List.reverse @Temp_2}
		     Temp_2 := {VirtualString.toAtom @Temp_2}
		     {UpdateWord Dico @Temp_1 @Temp_2}
		  else
		     {Line_split T}
		  end		  
	       else  		  
		  Temp_1 := H|@Temp_1
		  {Line_split T}
   		  
	       end
	    end
	 end    
      end
      
      Temp_1 = {NewCell nil}
      Temp_2 = {NewCell nil}
      Check_first = {NewCell 0}
   	 
      if Line \= false then
	 {Line_split Line}
      end
      
      if Line == nil then
	 if @Count == 3 then
	    {Show 'Parsing complete'}
	 else
	    Count := @Count + 1
	 end		    
      end      
   end   
end 