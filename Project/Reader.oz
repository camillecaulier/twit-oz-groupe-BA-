functor%Alexis  
import
   Open
   System
export
   textfile:TextFile
   file_reading:File_reading
   
define
   Show = System.show
   
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