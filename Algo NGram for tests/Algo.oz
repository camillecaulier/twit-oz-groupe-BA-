functor
import
   System
   Application

export
   updateWord:UpdateWord
   reachMostProb:ReachMostProb

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
   fun {UpdateWord Dico Word W}
      local
	 fun {IncCountW D W}
	    local C Old in
	       {Dictionary.condGet D W 'Error: unvalid key' C}
	       {Dictionary.condExchange D W 'Error' Old (C+1)}
	       if (Old == {Dictionary.get D W}-1)
	       then 'Already a key, already a word'
	       else 'Error'
	       end
	    end
	 end
      in
	 if {InDictTot Dico Word}
	 then
	    local D in
	       {Dictionary.condGet Dico Word 'Error: unvalid key' D}
	       if {Dictionary.member D W}
	       then {IncCountW D W}
	       else
		  {Dictionary.put D W 1}
		  'Already a key, new word'
	       end
	    end
	 else
	   local D in
	      {Dictionary.condGet Dico Word 'Error: unvalid key' D}
	      {Dictionary.put D W 1}
	      'New key, new word'
	   end
	 end
      end
   end



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
	    D = {Dictionary.get Dico Word}
	    if {Dictionary.is D}
	    then
	       L = {Dictionary.entries D}
	       if {List.is L}
	       then
		  S = {TuplesToList L}
		  if {List.is S}
		  then
		     if (S == nil)
		     then 'Error: empty list after TuplesToList'
		     else
			local I M O in
			   I = {List.length S}
			   M = {List.nth {List.nth S 1} 1}
			   O = {List.nth {List.nth S 1} 2}
			   {UpdateMostProb S I 2 M O}
			end
		     end
		  else 'An error occured during TuplesToList'
		  end
	       else
		  'Error: not a list'
	       end
	    else
	       'Error: not a dictionary'
	    end
	 end
      end
   end
   

	 
   Dico = {Dictionary.new}

   {Show {UpdateWord Dico 'Hello' 'World'}}
   {Show {UpdateWord Dico 'Bonjour' 'Monsieur'}}
   {Show {UpdateWord Dico 'World' 'Test'}}
   {Show {UpdateWord Dico 'Hello' 'World'}}
   {Show {UpdateWord Dico 'Hello' 'Everyone'}}
   {Show {UpdateWord Dico 'Hello' 'Everyone'}}
   {Show {UpdateWord Dico 'Hello' 'Everyone'}}
   {Show {UpdateWord Dico 'Hello' 'Hi'}}
   {Show {UpdateWord Dico 'Hello' 'Bonjour'}}
   {Show {ReachMostProb Dico 'Hello'}}
   
   {Application.exit 0}

end 