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
   %procedure that will send the lines of a file to the the respective port to be parsed
   %
   %@pre:
   %     PortNumber: A number that will allow use which fiels to assign. We have 208 files and these
   %     files will be divided into 4 batches equally.
   %
   %     Port: Port to where we will send the lines of the files to.
   proc{File_reading PortNumber Port}
      local FirstFileNumber LastFileNumber in
	 LastFileNumber = PortNumber * 52
	 FirstFileNumber = LastFileNumber - 51 
	 
	 for I in FirstFileNumber..LastFileNumber do
	    local File_name File in
	       File_name="tweets/part_"#{Int.toString I}#".txt"
	       File = {New TextFile init(name:File_name)}
	       for J in 1..100 do
		  local Line in
		     Line = {File getS($)}
		     {Send Port Line}
		  end
	       end
	       {File close}
	    end
	 end
	 {Send Port nil}
      end
   end
   
    

end