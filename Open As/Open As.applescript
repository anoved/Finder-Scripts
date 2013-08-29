(*
	Open As… 1.0 by Jim DeVona
	http://anoved.net/2007/08/open-as-pseudo-stationery-finder.html
	17 August 2006
	
	Open an explicitly named copy of the selected file or folder. With a
	Finder item selected, invoke this script. You will be prompted to
	choose a new name and location for the item. Click "Save" to
	duplicate the item and open the named duplicate.

	This script is the result of dissatisfaction with many applications'
	lack of support for "Stationery Pad" files. Unless an application
	provides proper Stationery Pad support, opening Stationery Pad files
	with the Finder creates a duplicate with "copy [#]" appended to the
	original base filename and opens that. This requires subsequently
	modifying the duplicate's filename, or choosing "Save As…" from the
	application and deleting the initial duplicate. I would prefer to
	name the new instance directly. This script provides such a solution;
	it has the added advantage of working with any file, not just those
	marked as Stationery Pads.
	
	I suggest saving this script in ~/Library/Scripts/Applications/Finder
	and assigning it the keyboard shortcut Shift-Command-O via a utility
	such as FastScripts.
*)

on OpenAsNew(_file)
	tell application "Finder"
		activate
		set _name to name of _file
		set _dupe to choose file name with prompt "Open " & _name & " as:" default name _name default location ((container of _file) as alias)
		try
			do shell script "/bin/cp -R -f " & quoted form of POSIX path of _file & " " & quoted form of POSIX path of _dupe
		on error _errMsg number _errNumber
			display alert "Could not duplicate file or folder (" & _errNumber & "):" message _errMsg as critical
			return
		end try
		open _dupe
	end tell
end OpenAsNew

on run
	tell application "Finder"
		set _files to selection
	end tell
	repeat with _file in _files
		OpenAsNew(_file as alias)
	end repeat
end run