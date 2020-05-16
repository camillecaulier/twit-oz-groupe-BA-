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
      in
	 local I in
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
	    {Dictionary.condGet Dico Word 'Error: key not found' D}
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
   
   proc{Parse Dico Line}
      
      Temp_1 Temp_2 Check_first Line_split in
      proc{Line_split Line_list}
	 %{Show 'hello'}
	 case Line_list of nil then skip
	 [] H|T then %nil espace ponctuation"
	    if H == 32 then
	       %{Show 'Fuck  you you bitch'}
	       if @Check_first == 2 then %fullsotp then end
		  Temp_2 := {List.reverse @Temp_2}
		  Temp_2 := {VirtualString.toAtom @Temp_2}
		  %{Show @Temp_2}
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
	    elseif H==33 orelse H==46 orelse H==34 orelse H==40 orelse H==41 orelse H==58 orelse H==59 orelse H==63 orelse H == 42 orelse H==60 orelse H== 61 orelse H== 62 orelse H== 96 orelse H==123 orelse H== 124 orelse H== 125 orelse H==126 then
	       if T ==nil then %si un ponctuation c'est la fin 
		  Temp_2 := {List.reverse @Temp_2}
		  Temp_2 := {VirtualString.toAtom @Temp_2}
		  %{Show @Temp_2}
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
		     %{Show @Temp_2}
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
   	 %0 just started	 
   	 %1 letter first word
   	 %2 got the first letter of the second word
   	 %3 just changed
      if Line \= false then
	 {Show {Dictionary.entries Dico}}
	 {Line_split Line}
      end      
   end
   
   
end 