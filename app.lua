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
print("[HANDLERS]", "Loading handler files")
for k, v in fs.scandirSync("./handler") do
	print("[HANDLERS]", "Loading:", k)
	local data = require("./handler/"..k)
	if not data.name then
		print("	", "[HANDLERS]", "Error:", k, "does not have a valid name!")
	elseif _G[data.name] then
		print("	", "[HANDLERS]", "Error:", k, "has a name which is already registered as a handler. The name is", data.name)
	else
		_G[data.name] = data
		print("	", "[HANDLERS]", "Success:", k, "has been loaded with the name", data.name)
	end
end

--[[
	COMMANDS
]]
-- We don't do anything fancy here, just load the files and let the global handlers do the rest
print("[CMDS]", "Loading command files")
for k, v in fs.scandirSync("./commands") do
	print("[CMDS]", "Loading:", k)
	local data = require("./commands/"..k)
	print("	", "[CMDS]", "Success:", k, "has been loaded.")
end

--[[
	EVENTS
]]
-- Pretty much the same as commands, just load the files and let Discordia handle the emitter stuff.
print("[EVENTS]", "Loading command files")
for k, v in fs.scandirSync("./events") do
	print("[EVENTS]", "Loading:", k)
	local data = require("./events/"..k)
	print("	", "[EVENTS]", "Success:", k, "has been loaded.")
end

-- Start the bot
CLIENT:run('Bot '..CONFIG.token)