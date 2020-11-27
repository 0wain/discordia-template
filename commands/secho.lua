command.Register("secho", "Echo, but silently!", function(msg, args)
	msg.channel:send(table.concat(args, " ")) -- Put the arguments back togther.

	-- Delete the original message
	msg:delete()
end)