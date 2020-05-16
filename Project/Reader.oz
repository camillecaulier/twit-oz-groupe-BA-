functor%Alexis  
import
   Open
   System
export
   textfile:TextFile
   scan:Scan
   file_reading:File_reading
   
define
    % Fetches the N-th line in a file
    % @pre: - InFile: a TextFile from the file
    %       - N: the desires Nth line
    % @post: Returns the N-the line or 'none' in case it doesn't exist
   Show = System.show
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
   proc{File_reading P1 P2 P3 P4}
      for I in 1..208 do
	 local File_name File in
	    File_name="tweets/part_"#{Int.toString I}#".txt"
	    %{Show File_name}
	    File = {New TextFile init(name:File_name)}
	    for J in 1..100 do
	       local Line in
		  Line = {File getS($)}
		  if J mod 4 == 0 then
		     {Send P1 Line}
		  elseif J mod 4 == 1 then
		     {Send P2 Line}
		  elseif J mod 4 == 2 then
		     {Send P3 Line}
		  else
		     {Send P4 Line}
		  end
	       end
	    end
	    {File close}
	 end
      end
      {Send P1 nil}
      {Send P2 nil}
      {Send P3 nil}
      {Send P4 nil}
   end
    

end