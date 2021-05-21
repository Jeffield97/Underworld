addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),
	function()
		call(getResourceFromName("scoreboard"),"addScoreboardColumn","FPS",2,"FPS",22)
	end
)