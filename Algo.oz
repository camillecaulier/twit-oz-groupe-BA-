functor
import
   System
   Application

define
   Show = System.show
   
   % In case it's Word's first appearance in the text.
   % We create a new key (Word) in Dico with another dictionary D as it's value.
   % We initialize a first key (CountTot) in D with the value 1.
   % Return false (meaning Word wasn't already in Dico).
   % fun {InitKey Dico Word}
   %    local D in
   % 	 D = {Dictionary.new}
   % 	 {Dictionary.put D 'CountTot' 1}
   % 	 {Dictionary.put Dico Word D}
   % 	 false
   %    end
   % end


   % In case Word is already a key of Dico.
   % We increase by 1 the total count of Word in the text (CountTot).
   % Return true (meaning Word was already in Dico)
   % fun {IncreaseCount Dico Word}
   %    local C Old in
   % 	 C = {Dictionary.get {Dictionary.get Dico Word} 'CountTot'}
   % 	 {Dictionary.exchange {Dictionary.get Dico Word} 'CountTot' Old (C+1)}
   % 	 if (Old == {Dictionary.get {Dictionary.get Dico Word} 'CountTot'}-1)
   % 	 then true
   % 	 else 'Error'
   % 	 end
   %    end
   % end


   % Check if Word is a key of Dico.
   % If true: we increase CountTot of Word (IncreaseCount).
   % If false: we initialize a new key (Word) in Dico (InitKey).
   fun {InDictTot Dico Word}
      local
	 
	 fun {IncreaseCount Dico Word}
	    local C Old in
	       C = {Dictionary.get {Dictionary.get Dico Word} 'CountTot'}
	       {Dictionary.exchange {Dictionary.get Dico Word} 'CountTot' Old (C+1)}
	       if (Old == {Dictionary.get {Dictionary.get Dico Word} 'CountTot'}-1)
	       then true
	       else 'Error'
	       end
	    end
	 end
	 
	 fun {InitKey Dico Word}
	    local D in
	       D = {Dictionary.new}
	       {Dictionary.put D 'CountTot' 1}
	       {Dictionary.put Dico Word D}
	       false
	    end
	 end
      in
	 if {Dictionary.member Dico Word}
	 then {IncreaseCount Dico Word}
	 else {InitKey Dico Word}
	 end
      end
   end

   
   fun {UpdateWord Dico Word W}
      local

	 fun {IncCountW D W}
	    local C Old in
	       C = {Dictionary.get D W}
	       {Dictionary.exchange D W Old (C+1)}
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
	       D = {Dictionary.get Dico Word}
	       if {Dictionary.member D W}
	       then {IncCountW D W}
	       else
		  {Dictionary.put D W 1}
		  'Already a key, new word'
	       end
	    end
	 else
	   local D in
	      D = {Dictionary.get Dico Word}
	      {Dictionary.put D 'MostProb' W}
	      {Dictionary.put D W 1}
	      'New key, new word'
	   end
	 end
      end
   end
   
   
      

   
   Dico = {Dictionary.new}

   % {Show {InDictTot Dico 'Hello'}}
   % {Show {InDictTot Dico 'Bonjour'}}
   % {Show {InDictTot Dico 'World'}}
   {Show {UpdateWord Dico 'Hello' 'World'}}
   {Show {UpdateWord Dico 'Bonjour' 'Monsieur'}}
   {Show {UpdateWord Dico 'World' 'Test'}}
   {Show {UpdateWord Dico 'Hello' 'World'}}
   {Show {UpdateWord Dico 'Hello' 'Everyone'}}
   {Show {Dictionary.entries Dico}}
   {Show {Dictionary.entries {Dictionary.get Dico 'Hello'}}}
   {Show {Dictionary.entries {Dictionary.get Dico 'Bonjour'}}}
   {Show {Dictionary.entries {Dictionary.get Dico 'World'}}}
   
   {Application.exit 0}

end