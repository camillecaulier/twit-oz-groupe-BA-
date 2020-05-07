functor
export
   updateWord:UpdateWord
   reachMostProb:ReachMostProb

define

   
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
   fun {UpdateWord Dico Word W}
      local
	 fun {IncCountW D W}
	    local C Old in
	       {Dictionary.get D W C}
	       {Dictionary.exchange D W Old (C+1)}
	       'Already a key, already a word'
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
		  'Already a key, new word'
	       end
	    end
	 else
	   local D in
	      {Dictionary.get Dico Word D}
	      {Dictionary.put D W 1}
	      'New key, new word'
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
   
end 