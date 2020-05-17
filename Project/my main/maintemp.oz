functor %maintemp
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
   % fun {GetFirstLine IN_NAME}
   %    {Reader.scan {New Reader.textfile init(name:IN_NAME)} 1}
   % end
   

  
   

   Test = {Atom.toString 'fuck this rea lly. hard yolo'}
   {Show Test}
   Dic_test = {Dictionary.new}
   
   proc{Parse_test Dico Line}
      
      Temp_1 Temp_2 Check_first Line_split in
      proc{Line_split Line_list}
	 {Show 'hello'}
	 case Line_list of nil then
	    skip
	 [] H|T then %nil espace ponctuation"
	    if H == 32 then
	       {Show 'Fuck  you you bitch'}
	       if @Check_first == 2 then %fullsotp then end
		  Temp_2 := {List.reverse @Temp_2}
		  Temp_2 := {VirtualString.toAtom @Temp_2}
		  {Show @Temp_2}
		  {Algo.updateWord Dico @Temp_1 @Temp_2}
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
		  {Show @Temp_2}
		  {Algo.updateWord Dico @Temp_1 @Temp_2}
	       else
		  {Line_split T}
	       end
	       
	    else
	       if @Check_first == 2 then 
		  Temp_2 := H|@Temp_2
		  if T ==nil then %quand on arrive a la fin 
		     Temp_2 := {List.reverse @Temp_2}
		     Temp_2 := {VirtualString.toAtom @Temp_2}
		     {Show @Temp_2}
		     {Algo.updateWord Dico @Temp_1 @Temp_2}
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
	    
      {Line_split Line}
   end
 
   
   {Parse_test Dic_test Test}
   {Browse {Dictionary.entries Dic_test}}
   %{Browse {Dictionary.entries {Dictionary.get Dic_test 'lly'}}}
   % Argent = {Dictionary.new}'
   % {Algo.updateWord Argent 'hey' 'you'}
   % {Browse {Dictionary.entries Argent}}
   
%%% GUI
    % Make the window description, all the parameters are explained here:
    % http://mozart2.org/mozart-v1/doc-1.4.0/mozart-stdlib/wp/qtk/html/node7.html)

   
    % Text1 Text2 Description=td(
    %     title: "Frequency count"
    %     lr(
    %         text(handle:Text1 width:28 height:5 background:white foreground:black wrap:word)
    %         button(text:"Change" action:Press)
    %     )
    %     text(handle:Text2 width:28 height:5 background:black foreground:white glue:w wrap:word)
    %     action:proc{$}{Application.exit 0} end % quit app gracefully on window closing
    % )
    % proc {Press} Inserted in
    %     Inserted = {Text1 getText(p(1 0) 'end' $)} % example using coordinates to get text
    %     {Text2 set(1:Inserted)} % you can get/set text this way too
    % end
    % % Build the layout from the description
    % W={QTk.build Description}
    % {W show}

    % {Text1 tk(insert 'end' {GetFirstLine "tweets/part_1.txt"})}
    % {Text1 bind(event:"<Control-s>" action:Press)} % You can also bind events

    % {Show 'You can print in the terminal...'}
    % {Browse '... or use the browser window'}
end
