local sql = require("sqlite3")
local SQL = {}
-- Internal
SQL.name = "sql" -- This needs to be unique enough not to fuck mess the global table
SQL.con = sql.open("master.db")

--[[
Name: SQL.Query
Def: Used to run a query against the database
Args:
	q: String, The query to run 
]]--
function SQL.Query(q)
	return SQL.con:exec(q)
end

--[[
Name: SQL.Escape
Def: Validate and escape an input
Args:
	q: String, The string to escape
]]--
function SQL.Escape(q)
	q = string.gsub(q, "'", "''")

	return q
end

--[[
Name: SQL.TableExists
Def: Check if a table exists
Args:
	n: String, The table to check for
]]--
function SQL.TableExists(n)
	return SQL.Query(string.format("SELECT name FROM sqlite_master WHERE type='table' AND name='%s';", SQL.Escape(n))) and true or false
end

return SQL