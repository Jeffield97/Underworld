local function logEvent(file, text)
	local file_exists = fileExists("logs/"..file)
	local real_time = getRealTime()
	local year = real_time.year + 1900
	local month = real_time.month < 10 and "0"..real_time.month + 1 or real_time.month + 1
	local month_day = real_time.monthday < 10 and "0"..real_time.monthday or real_time.monthday
	local hour = real_time.hour < 10 and "0"..real_time.hour or real_time.hour
	local minute = real_time.minute < 10 and "0"..real_time.minute or real_time.minute
	local second = real_time.second < 10 and "0"..real_time.second or real_time.second
	if file_exists then
		local log_file = fileOpen("logs/"..file)
		if log_file then
			fileSetPos(log_file, fileGetSize(log_file))
			fileWrite(log_file, "\r\n["..year.."-"..month.."-"..month_day.." "..hour..":"..minute..":"..second.."] "..text)
			fileFlush(log_file)
			fileClose(log_file)
		else
			outputDebugString("Couldn't open log file.", 0, 255, 127, 0)
			return false
		end
	else
		local new_log = fileCreate("logs/"..file)
		if new_log then
			outputDebugString(file.." log file created successfully.", 0, 255, 127, 0)
			fileWrite(new_log, "["..year.."-"..month.."-"..month_day.." "..hour..":"..minute..":"..second.."] Log file created successfully.")
			if text then
				fileSetPos(new_log, fileGetSize(new_log))
				fileWrite(new_log, "\r\n["..year.."-"..month.."-"..month_day.." "..hour..":"..minute..":"..second.."] "..text)
			end
			fileFlush(new_log)
			fileClose(new_log)
		else
			outputDebugString("Couldn't create new log file.", 0, 255, 127, 0)
			return false
		end	
	end
end