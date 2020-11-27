-- React to a message whenever it's been edited
CLIENT:on("messageUpdate", function(msg)
	msg:addReaction("👀")
end)