command.Register("echo", "Repeat after me!", function(msg, args)
	msg.channel:send(table.concat(args, " ")) -- Put the arguments back togther.
end)