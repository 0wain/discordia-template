-- This file is the initiation file for the bot. This is the file that should be ran with luvit in order to initiate the bot.

--[[
	INIT
]]--
-- Luvit stuff
local fs = require('fs') -- luvit built-in library
-- Stolen from SinisterRectus' Luna

-- Require the Discordia framework
local discordia = require("discordia")
discordia.extensions()

-- We define these globally so we can access them anywhere as they're core parts of the system.
-- Create a client the run the bot on
_G.CLIENT = discordia.Client()
-- Obtain the config file
_G.CONFIG = require("./config.lua")

--[[
	LIBRARIES
]]--
print("[LIBRARIES]", "Loading library files")
for k, v in fs.scandirSync("./lib") do
	print("[LIBRARIES]", "Loading:", k)
	local data = require("./lib/"..k)
	print("	", "[LIBRARIES]", "Success:", k, "has been loaded.")
end

--[[
	HANDLERS
]]--
print("[HANDLER]", "Loading handler files")
for k, v in fs.scandirSync("./handler") do
	print("[HANDLER]", "Loading:", k)
	local data = require("./handler/"..k)
	if not data.name then
		print("	", "[HANDLER]", "Error:", k, "does not have a valid name!")
	elseif _G[data.name] then
		print("	", "[HANDLER]", "Error:", k, "has a name which is already registered as a handler. The name is", data.name)
	else
		_G[data.name] = data
		print("	", "[HANDLER]", "Success:", k, "has been loaded with the name", data.name)
	end
end


command.Register("123", "lol gay", function(msg, args)
	print("123:", msg, args)
end)

-- Start the bot
CLIENT:run('Bot '..CONFIG.token)