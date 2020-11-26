-- This file is the initiation file for the bot. This is the file that should be ran with luvit in order to initiate the bot.

-- Require the Discordia framework
local discordia = require("discordia")
-- Create a client the run the bot on
CLIENT = discordia.Client()
-- Obtain the config file
CONFIG = require("./config.lua")




-- Start the bot
CLIENT:run('Bot '..CONFIG.token)