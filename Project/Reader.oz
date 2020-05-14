functor%Alexis  
import
   Open
   System
export
   textfile:TextFile
   scan:Scan
   read_doc:Read_doc
   file_reading:File_reading
   
define
    % Fetches the N-th line in a file
    % @pre: - InFile: a TextFile from the file
    %       - N: the desires Nth line
    % @post: Returns the N-the line or 'none' in case it doesn't exist
   fun {Scan InFile N}
      Line={InFile getS($)}
   in
      if Line==false then
	 {InFile close}
	 none
      else
	 if N==1 then
	    {InFile close}
	    Line
	 else
	    {Scan InFile N-1}
	 end
      end
   end
   class TextFile % This class enables line-by-line reading
      from Open.file Open.text
   end
   proc{File_reading P1 P2}
      for I in 1..208 do
	 local File_name File in
	    File_name="tweets/part_"#{Int.toString I}#".txt"
	    File = {New TextFile init(name:File_name)}
	    for J in 1..100 do
	       local Line in
		  Line = {File getS($)}
		  if J mod 2 == 0 then
		     {Send P1 Line}
		  else
		     {Send P2 Line}
		  end
	       end
	    end
	    {File close}
	 end
      end
      {Send P1 nil}
      {Send P2 nil}
   end
   proc{Read_doc File_name Port_1 Port_2} %no need for this 
      local File Text in
	 File = {New TextFile init(name:File_name)}
	 Text = {NewCell nil}
	 for Line_number in 1..100 do
	    Text := {File getS($)}
	     
	    if Line_number mod 2 == 0 then
	       {Send Port_1 @Text}
	    elseif Line_number mod 2 == 1 then
	       {Send Port_2 @Text}
	    end
	 end
	 {File close}
	  %{File close} %fermer le fichie
      end
   end
    

end