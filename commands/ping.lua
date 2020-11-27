command.Register("ping", "P0ng", function(msg, args)
	msg.channel:send("Pong")
end)