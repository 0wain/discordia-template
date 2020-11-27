local COMMAND = {}
-- Internal
COMMAND.name = "command" -- This needs to be unique enough not to fuck mess the global table

COMMAND.commands = {}
COMMAND.prefix = "!"

--[[
Name: COMMAND.SetPrefix
Def: Set the active prefix. This allows you to hotswap the prefix depending (for example) the guild.
	This is only really used when the internal event is enabled.
Args:
	perfix: String, The prefix to set
]]--
function COMMAND.SetPrefix(command)
	return COMMAND.commands[command] or false
end
--[[
Name: COMMAND.GetPrefix
Def: Get the active prefix
]]--
function COMMAND.GetPrefix()
	return command.prefix
end

--[[
Name: COMMAND.Register
Def: Used to register a new command
Args:
	command: String, The command used to run it 
	desc: String, The description of the command
	func: Function, The function to run when the command is called 
]]--
function COMMAND.Register(command, desc, func)
	if not command then
		print("[COMMAND]", "[Error]", "Invalid command name given")
		return
	end

	if not func then
		print("[COMMAND]", "[Error]", "Invalid callback function given")
		return
	end

	command = string.lower(command)

	COMMAND.commands[command] = {
		command = command,
		desc = desc or "n/a",
		func = func
	}

	print("[COMMAND]", "The command", command, "has now been registered")
end

--[[
Name: COMMAND.IsCommand
Def: The the data of a command (If exists)
Args:
	command: String, The command used check
Return:
	Table OR false, The command and its data
]]--
function COMMAND.GetCommand(command)
	return COMMAND.commands[command] or false
end

--[[
Name: COMMAND.FormatArguments
Def: Formats arguments correctly
Args:
	table: Table, The args to format
Return:
	Table, The args formatted
Source:
	https://github.com/TheXYZNetwork/xAdmin/blob/master/lua/xadmin/core/sv_core.lua#L116
]]--
function COMMAND.FormatArguments(args)
	local Start, End = nil, nil

	for k, v in pairs(args) do
		if (string.sub(v, 1, 1) == "\"") then
			Start = k
		elseif Start and (string.sub(v, string.len(v), string.len(v)) == "\"") then
			End = k
			break
		end
	end

	if Start and End then
		args[Start] = string.Trim(table.concat(args, " ", Start, End), "\"")

		for i = 1, (End - Start) do
			table.remove(args, Start + 1)
		end

		args = command.FormatArguments(args)
	end

	return args
end

if CONFIG.commandEvent then
	CLIENT:on("messageCreate", function(msg)
		-- The message creator
		local author = msg.author
		-- The message content, what it says
		local content = msg.content

		-- Prevent the bot from processing its own messages
		if author == CLIENT.user then return end
		-- Ignore other bots
		if author.bot then return end

		--
		-- <Insert check for prefix>
		--
		local prefix = command.GetPrefix()
		-- Invalid prefix
		if not (string.sub(content, 1, string.len(prefix)) == prefix) then
			return
		end
	
		-- Break the command and args up.
		local args = command.FormatArguments(string.Explode(" ", content))
		-- Now we know the prefix is legit, we can remove it
		args[1] = string.sub(args[1], string.len(prefix) + 1)

		-- Get the command data
		local command = command.GetCommand(string.lower(args[1]))
		-- Not a valid command
		if not command then print("Invalid command", "'"..args[1].."'") return end
		-- Remove the command from the args table
		table.remove(args, 1)

		-- Run the command, providing the formatted args and the message.
		command.func(msg, args)
	end)
end

return COMMAND
