--[[
	Author: FileEX
]]

local composer = require 'composer';
local widget = require 'widget';
local scene = composer.newScene();
local dt = require 'questionsData';
require 'sounds';
local dta = require 'userdata';

local pts,gA,bA = 0,0,0;

local btns,qTable = {};
local cbars = {};

local level,question,chances,time,timeRem,tm,winn,lock,isMusic,typeOfGame;

local circleContent,questionLabel,bg,infoLabel,infoCenterLabel,infoCenterTwoLabel,setticon,exitIcon;

local temp = {};

local function createWindow(type,pt)
	local options = {isModal = true, effect = 'zoomOutIn', time = 250, params = {tp = type, pt = pts, tog = typeOfGame}};

	composer.showOverlay('window', options);
end

local function getQuestionsFromLevel(level)
	local n;
	if level == 1 then n = 4; elseif level == 2 then n = 10; elseif level == 3 then n = 15; end;
	return n;
end

local function mrn(tbl,f,t)
	local n = math.random(f,t);
	if tbl[n] then n = mrn(tbl,f,t); end;
	tbl[n] = n;
	return n;
end

local function sort()
	local t,td = {},{};
	for i = 1,4 do
		table.insert(t, i);
	end

	table.sort(t, function(a,b) return -a * math.random(4,5) < -b * math.random(3,4) end);

	for k,v in pairs(t) do
		table.insert(td, v);
	end

	return td;
end

local function gen(first)
	local q = getQuestionsFromLevel(level);
	local dt = dt[level];
	local t = {};
	local tb = sort();

	math.randomseed( os.time() );

	for i = 1,q do
		local m = mrn(temp, 1, #dt);
		t[i] = dt[m];
		if not first then
			timer.performWithDelay(500, function()
				questionLabel.text = t[question][1];
				transition.to(questionLabel, {alpha = 1, time = 800});
				for i = 1,4 do
					btns[i]:setFillColor(0.20,0.21,0.36);
					transition.to(btns[i], {alpha = 1, time = 800});

					btns[i]:setLabel(t[question][2][tb[i]]);
					btns[i].ind = t[question][3][tb[i]];
				end 

				if time then
					timeRem = 30;
					timer.cancel(tm);
					tm = nil;
					tm = timer.performWithDelay(1000, timerEvent, 30);
					circleContent.text = '30';
					if lock then
						timer.cancel(lock);
						lock = nil;
					end
				end

				if isMusic then
					stopMusic();
					isMusic = false;
				end

				if t[question][4] ~= nil then
					playMusic(t[question][4]);
					isMusic = true;
					if time then
						timer.pause(tm);
						timeRem = 30;
					end
					lock = timer.performWithDelay(10000, function()
						if time then
							timer.resume(tm);
						end

						lock = nil;
						isMusic = false;
					end, 1);
				end

			end, 1);
		else
			questionLabel.text = t[question][1];
			transition.to(questionLabel, {alpha = 1, time = 800});
			for i = 1,4 do
				transition.to(btns[i], {alpha = 1, time = 800});
				btns[i]:setLabel(t[question][2][tb[i]]);
				btns[i].ind = t[question][3][tb[i]];
			end

			if t[question][4] ~= nil then
				playMusic(t[question][4]);
				isMusic = true;
				if time then
					timer.pause(tm);
					timeRem = 30;
				end
				lock = timer.performWithDelay(10000, function()
					if time then
						timer.resume(tm);
					end
						
					lock = nil;
					isMusic = false;
				end, 1);
			end
		end
	end

	return t;
end

local function nextQuestion()
	local tb = sort();

	timer.performWithDelay(500, function()
		questionLabel.text = qTable[question][1];
		transition.to(questionLabel, {alpha = 1, time = 800});
		for i = 1,4 do
			if btns[i] then
				btns[i]:setFillColor(0.20,0.21,0.36);
				transition.to(btns[i], {alpha = 1, time = 800});

				btns[i]:setLabel(qTable[question][2][tb[i]]);
				btns[i].ind = qTable[question][3][tb[i]];
			end
		end 

		if time then
			timeRem = 30;
			timer.cancel(tm);
			tm = nil;
			tm = timer.performWithDelay(1000, timerEvent, 30);
			circleContent.text = '30';
			if lock then
				timer.cancel(lock);
				lock = nil;
			end
		end

		if isMusic then
			stopMusic();
			isMusic = false;
		end

		if qTable[question][4] ~= nil then
			playMusic(qTable[question][4]);
			isMusic = true;
			if time then
				timer.pause(tm);
				timeRem = 30;
			end
			lock = timer.performWithDelay(10000, function()
				if time then
					timer.resume(tm);
				end
							
				lock = nil;
				isMusic = false;
			end, 1);
		end

	end, 1);
end

function timerEvent(event)
	timeRem = timeRem - 1;

	circleContent.text = timeRem;
	if timeRem <= 0 then
		playSignal(0);
		chances = chances - 1;

		display.remove(cbars[chances + 1]);
		cbars[chances + 1] = nil;

		if (chances <= 0) then
			-- end game
			createWindow('lose',pts);
			if isMusic then
				stopMusic();
				isMusic = false;
				if lock then
					timer.cancel(lock);
				end
			end
		else
			transition.to(questionLabel, {alpha = 0, time = 500});
			for i = 1,4 do
				transition.to(btns[i], {alpha = 0, time = 500});
			end

			question = question + 1;

			infoCenterLabel.text = 'Pytanie '..question..' z '..getQuestionsFromLevel(level);

			if ((question - 1) < getQuestionsFromLevel(level)) then
				nextQuestion();
			else
				level = level + 1;
				infoCenterLabel.text = 'Pytanie '..question..' z '..getQuestionsFromLevel(level);
				if (level < 4) then
					infoLabel.text = 'Etap: '..level;
					if (level > 2) then
						startFinal();
					end

					question = 1;

					if not time then
						circleContent.text = (getQuestionsFromLevel(level) - (question - 1));
					end

					for k,v in pairs(temp) do
						temp[k] = nil;
					end

					qTable = gen();
				else
					winn = true;
					createWindow('win', pts);
				end
			end
		end
	end
end

local function startFinal()
	local sceneGroup = scene.view;
	bg.alpha = 0;
	reloadTheme(3);
	playTheme();
	bg.fill = {type = 'image', filename ='assets/images/final.png'};
	transition.to(bg, {alpha = 1, time = 250});
	pts = pts + (chances * 10);
	chances = 3;
	for i = 1,3 do
		display.remove(cbars[i]);

		cbars[i] = display.newRect((display.actualContentWidth - 32) + i * 8, -20, 5, 10);
		cbars[i]:setFillColor(0,1,0,1);

		sceneGroup:insert(cbars[i]);
	end
	infoCenterTwoLabel.text = 'Punkty '..pts;
end

local function answerEvent(event)
	if (event.phase == 'ended' and event.target.alpha == 1) then
		playTap();

		local an = event.target.ind;

		playSignal(an);

		if (an == 1) then
			-- good
			event.target:setFillColor(0,1,0,event.target.alpha);
			pts = pts + (level > 2 and 20 or 10);
			infoCenterTwoLabel.text = 'Punkty: '..pts;
			gA = gA + 1;
		else
			-- bad
			event.target:setFillColor(1,0,0,event.target.alpha);

			chances = chances - 1;

			display.remove(cbars[chances + 1]);
			cbars[chances + 1] = nil;

			if (chances <= 0) then
				-- end game
				createWindow('lose',pts);
				if isMusic then
					stopMusic();
					isMusic = false;
					if lock then timer.cancel(lock); end;
				end
			end

			bA = bA + 1;
		end

		transition.to(questionLabel, {alpha = 0, time = 500});
		for i = 1,4 do
			transition.to(btns[i], {alpha = 0, time = 500});
		end

		question = question + 1;

		if not time then
			circleContent.text = (getQuestionsFromLevel(level) - (question - 1));
		else
			infoCenterLabel.text = 'Pytanie '..question..' z '..getQuestionsFromLevel(level);
		end

		if ((question - 1) < getQuestionsFromLevel(level)) then
			nextQuestion();
		else
			level = level + 1;

			if (level < 4) then
				infoLabel.text = 'Etap: '..level;
				if (level > 2) then
					startFinal();
				end

				question = 1;

				if not time then
					circleContent.text = (getQuestionsFromLevel(level) - (question - 1));
				else
					infoCenterLabel.text = 'Pytanie '..question..' z '..getQuestionsFromLevel(level);
				end

				for k,v in pairs(temp) do
					temp[k] = nil;
				end

				qTable = gen();
			else
				winn = true;
				createWindow('win', pts);
			end
		end
	end
end

local function onSettings(event)
	if (event.phase == 'ended') then
		playTap();
		createWindow('settings');
	end
end

local function onExit(event)
	if (event.phase == 'ended') then
		playTap();
		createWindow('bMenu');
	end
end

function scene:create(event)
	local sceneGroup = self.view;
	local tp = event.params.a;
	typeOfGame = tp;

	bg = display.newImageRect((tp == 'classic' or tp =='classicTime') and  'assets/images/round.png' or 'assets/images/final.png', display.actualContentWidth, display.actualContentHeight);
	bg.x, bg.y = display.contentCenterX, display.contentCenterY;

	sceneGroup:insert(bg);

	level,question,chances = 1,1,3;
	winn = false;

	if (tp == 'final' or tp == 'finalTime') then level = 3; end;

	if (tp == 'classicTime' or tp == 'finalTime') then
		time = true;
		timeRem = 30;
		tm = timer.performWithDelay(1000, timerEvent, 30);
	end 

	infoLabel = display.newText('Etap: '..level, 30,-20, native.systemFontBold, 13);
	if (time) then
		infoCenterLabel = display.newText('Pytanie: '..question..' z '..getQuestionsFromLevel(level), display.contentCenterX, -20, native.systemFontBold, 13);
		sceneGroup:insert(infoCenterLabel);
	end
	local infoRightLabel = display.newText('Szanse: ', display.actualContentWidth - 50, -20, native.systemFontBold, 13);
	infoCenterTwoLabel = display.newText('Punkty: 0', display.contentCenterX, time and 5 or -20, native.systemFontBold, 13);

	for i = 1,chances do
		cbars[i] = display.newRect((display.actualContentWidth - 32) + i * 8, -20, 5, 10);
		cbars[i]:setFillColor(0,1,0,1);

		sceneGroup:insert(cbars[i]);
	end

	for i = 1,4 do
		btns[i] = widget.newButton({label='', onEvent = answerEvent, emboss = false, shape = 'roundedRect', width = display.actualContentWidth - 30, height = 40, cornerRadius = 2,labelColor = {default = {0.1,0.5,0.8,1}, over = {0.1,0.5,0.8,0.7}}, fillColor = {default = {0.20,0.21,0.36,1}, over={0.17,0.2,0.58,0.7}}, strokeColor = {default = {1,0.4,0,1}, over = {0.8,0.8,1,1}}, strokeWidth = 0});
		btns[i].x, btns[i].y = display.contentCenterX, (display.actualContentHeight - 320) + 60 * i;

		sceneGroup:insert(btns[i]);
	end

	setticon = display.newImageRect('assets/images/settings.png', 24, 24);
	setticon.x, setticon.y = display.actualContentWidth - 20,10;

	exitIcon = display.newImageRect('assets/images/exit.png', 24, 24);
	exitIcon.x, exitIcon.y = 20, 10;

	local options = {
		text = '',
		x = display.contentCenterX,
		y = 200,
		width = display.actualContentWidth - 30,
		height = 180,
		font = native.systemFontBold,
		fontSize = 17,
		align = 'center',
	}

	questionLabel = display.newText(options);

	local circle = display.newCircle(display.contentCenterX, time and 65 or 50, 35);
	circle:setFillColor(1,1,1,0);
	circle.strokeWidth = 4;
	circle:setStrokeColor(0.4,0.9,0.6,1);

	circleContent = display.newText('', display.contentCenterX, time and 65 or 50, native.systemFontBold, 25);

	if not time then
		circleContent.text = (getQuestionsFromLevel(level) - (question - 1));
	else
		circleContent.text = '30';
	end

	sceneGroup:insert(setticon);
	sceneGroup:insert(exitIcon);
	sceneGroup:insert(questionLabel);
	sceneGroup:insert(infoLabel);
	sceneGroup:insert(infoRightLabel);
	sceneGroup:insert(infoCenterTwoLabel);
	sceneGroup:insert(circle);
	sceneGroup:insert(circleContent);

	setticon:addEventListener('touch', onSettings);
	exitIcon:addEventListener('touch', onExit);

	qTable = gen(true);
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
        -- Called when the scene is still off screen and is about to move on screen
       
    elseif phase == "did" then
        -- Called when the scene is now on screen
        -- 
        -- INSERT code here to make the scene come alive
        -- e.g. start timers, begin animation, play audio, etc
        
    end 
end

function scene:hide(event)
	local sceneGroup = self.view
    local phase = event.phase

    if event.phase == "will" then
        -- Called when the scene is on screen and is about to move off screen
        --
        -- INSERT code here to pause the scene
        -- e.g. stop timers, stop animation, unload sounds, etc.)

    elseif phase == "did" then
        -- Called when the scene is now off screen
		
    end 
end

function scene:destroy( event )
    local sceneGroup = self.view

    if winn then
	    local pt = dta.get('points');
	    local wrnds = dta.get('winningRounds');
	    setUserDataValue('points', tonumber(pt) + pts);
	    setUserDataValue('winningRounds', tonumber(wrnds) + 1);
	end

	local ans = dta.get('answers');
	local gans = dta.get('goodAnswers');
	local bans = dta.get('badAnswers');
	local rnd = dta.get('allRounds');

	setUserDataValue('answers', tonumber(ans) + bA + gA);
	setUserDataValue('goodAnswers', tonumber(gans) + gA);
	setUserDataValue('badAnswers', tonumber(bans) + bA);

	if winn or chances <= 0 then
		setUserDataValue('allRounds', tonumber(rnd) + 1);
	end

	if tm then
		timer.cancel(tm);
	end
end

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene;