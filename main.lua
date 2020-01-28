--[[
	Author: FileEX
]]
local composer = require 'composer';

display.setStatusBar(display.HiddenStatusBar);

local audioManager = require 'sounds';
local ud = require 'userdata';

local function onSystemEvent( event )
    if (event.type == 'applicationExit') then
    	local soundOp,musicOp = audioManager.get();
    	local userData = ud.get();

    	local appPreferences =
		{
		    soundsBool = soundOp,
		 	musicBool = musicOp,
		 	answers = userData.answers,
		 	goodAnswers = userData.goodAnswers,
		 	badAnswers = userData.badAnswers,
		 	allRounds = userData.allRounds,
		 	winningRounds = userData.winningRounds,
		 	points = userData.points
		};

    	saveData(appPreferences);
    elseif (event.type == 'applicationStart') then
    	loadData();
    	local data = ud.get();

      	local allA, goodA, badA, rounds, winRounds, points, soundOp, musicOp = data['answers'], data['goodAnswers'], data['badAnswers'], data['allRounds'], data['winningRounds'], data['points'], data['soundsBool'], data['musicBool'];

 		if (type(allA) == 'nil') then -- others var are the same
 			allA, goodA, badA, rounds, winRounds, points,soundOp,musicOp = 0, 0, 0, 0, 0, 0, true, true;
 		end

 		setUserData({
 			answers = allA,
 			goodAnswers = goodA,
 			badAnswers = badA,
 			allRounds = rounds,
 			winningRounds = winRounds,
 			points = points,
 		});

		updateSoundsData(soundOp, musicOp);

		composer.gotoScene('menu');
		data = nil;
		collectgarbage('collect');
    end
end

Runtime:addEventListener( "system", onSystemEvent );