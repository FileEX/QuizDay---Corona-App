--[[
	Author: FileEX
]]

require 'serialize';

userData = {};
local path = system.pathForFile( "data.dt", system.DocumentsDirectory );

function setUserData(data)
	userData = data;
end

function setUserDataValue(key, value)
	userData[key] = value;
end

function getUserData(key)
	return (key and userData[key] or userData);
end

function saveData(tbl)
	local f = io.open(path, 'w');
	local s = table.show(tbl == nil and userData or tbl, 'userData');
	f:write(s);
	f:close();
end

function loadData()
	local f = io.open(path, 'r');
	if (not f) then
		f = io.open(path, 'w');
		f:write('userData = {};');
		loadstring('userData = {};')();
		f:close();
	else
		local t = f:read('*a');
		loadstring(t)();
		f:close();
	end
end

return {get = getUserData};