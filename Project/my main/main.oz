functor %alexis
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

   fun {NewPortObject0 Process}
       Port Stream
    in
       Port={NewPort Stream}
       thread for M in Stream do {Process M} end end
       Port
    end
    proc{Fichier P1 P2}
       for I in 1..208 do
	  local Str in
	     Str="tweets/part_"#{Int.toString I}#".txt"
	     if (I mod 2==0) then
		{Send P1 Str}
	     else
		{Send P2 Str}
	     end
	     
	  end
       end
       {Send P1 nil}
       {Send P2 nil}
    end
    proc{Handle VirtualStr}
       case VirtualStr of nil then skip
       else
	  local Str in
	     Str={VirtualString.toString VirtualStr}  %Changer toAtom en toStr pour lire fichier
	     {SendToDecoupe Str}  %appeler m�thode
	  end
       end
    end
    P1={NewPortObject0 Handle}
    P2={NewPortObject0 Handle}
    P3={NewPortObject0 Show}
    P4={NewPortObject0 Show}
    proc{SendToDecoupe Str}
       {Reader.decoupeLignes Str P3 P4}
    end
    {Fichier P1 P2}
    

%%% GUI
    % Make the window description, all the parameters are explained here:
    % http://mozart2.org/mozart-v1/doc-1.4.0/mozart-stdlib/wp/qtk/html/node7.html)
   Text1 Text2 Description=td(
			      title: "Frequency count"
			      lr(
				 text(handle:Text1 width:28 height:5 background:white foreground:black wrap:word)
				 button(text:"Change" action:Press)
				 )
			      text(handle:Text2 width:28 height:5 background:black foreground:white glue:w wrap:word)
			      action:proc{$}{Application.exit 0} end % quit app gracefully on window closing
			      )
   proc {Press} Inserted in
      Inserted = {Text1 getText(p(1 0) 'end' $)} % example using coordinates to get text
      {Text2 set(1:Inserted)} % you can get/set text this way too
   end
    % Build the layout from the description
   W={QTk.build Description}
   {W show}
   
   {Text1 tk(insert 'end' {GetFirstLine "tweets/part_1.txt"})}
   {Text1 bind(event:"<Control-s>" action:Press)} % You can also bind events
   
   {Show 'You can print in the terminal...'}
   {Browse '... or use the browser window'}

   % D = {Dictionary.new}
   % {Show {Algo.updateWord D 'hello' 'world'}}
   % {Show {Algo.reachMostProb D 'Hello'}}
   % {Show {Algo.reachMostProb D 'hello'}}
   %{Browse {GetFirstLine "tweets/part_t.txt"}}
   
end
