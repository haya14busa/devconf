#!/usr/bin/env osascript
-- toggle-visibility.scpt
-- Usage: osascript toggle-visibility.scpt "Ghostty"
-- (You can also save as an “Application” in Script Editor or Automator)

on run argv
	-- Check the number of arguments
	if (count of argv) ≠ 1 then
		display dialog "Usage: osascript toggle-visibility.scpt \"<Application Name>\"" buttons {"OK"} default button 1
		return
	end if

	set appName to item 1 of argv

	-- 1. Make sure the app is running (does nothing if already running)
	try
		tell application appName to run
	on error errMsg number errNum
		-- The app couldn’t be found or launched
		display dialog "Cannot run “" & appName & "”: " & errMsg buttons {"OK"} default button 1
		return
	end try

	-- 2. Toggle the visibility via System Events
	tell application "System Events"
		-- Wait until the process actually exists (in case launch is slow)
		repeat until exists (application process appName)
			delay 0.1
		end repeat

		set appProc to first application process whose name is appName
		set isVisible to visible of appProc
		set visible of appProc to not isVisible
	end tell
end run

