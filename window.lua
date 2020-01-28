--[[
	Author: FileEX
]]

local composer = require 'composer';
local widget = require 'widget';
local scene = composer.newScene();
local audioManager = require 'sounds';
local userd = require 'userdata';

local back,gameT, lastSettings;

local function showRules(type)
	local options = {isModal = false, effect = 'zoomOutIn', time = 250, params = {tp = type}};

	composer.showOverlay('rules', options);
end

local function closeEvent(event)
	if (event.phase == 'ended') then
		playTap();
		composer.hideOverlay('fade', 250);
		if back then
			composer.removeScene('game');
			composer.removeScene('window');
			composer.gotoScene('menu', {effect = 'crossFade', time = 300});

			reloadTheme(2);
			playTheme();
		end

		if lastSettings then
			local soundOp,musicOp = audioManager.get();
    		local userData = userd.get();
    		userData.soundsBool = soundOp;
    		userData.musicBool = musicOp;

    		saveData(userData);
		end
	end
end

local function onClassicEvent(event)
	if (event.phase == 'ended') then
		playTap();
		showRules('classicRules');
	end
end

local function onClassicTimeEvent(event)
	if (event.phase == 'ended') then
		playTap();
		showRules('classicTimeRules');
	end
end

local function onFinalEvent(event)
	if (event.phase == 'ended') then
		playTap();
		showRules('finalRules');
	end
end

local function onFinalTimeEvent(event)
	if (event.phase == 'ended') then
		playTap();
		showRules('finalTimeRules');
	end
end

local function backEvent(event)
	if (event.phase == 'ended') then
		playTap();
		stopMusic();
		composer.hideOverlay('fade', 250);
		composer.removeScene('game');
		composer.removeScene('window');
		composer.gotoScene('menu', {effect = 'crossFade', time = 300});

		reloadTheme(2);
		playTheme();
	end
end

local function startEvent(event)
	if (event.phase == 'ended') then
		playTap();
		stopMusic();

		reloadTheme(1);
		playTheme();
		composer.hideOverlay('fade', 250);
		composer.removeScene('game');
		composer.removeScene('window');
		composer.gotoScene('game', {effect = 'crossFade', time = 300, params = {a = gameT}});
	end
end

local function createWindow(data, pts,gmt)
	local sceneGroup = scene.view;
	if not sceneGroup then return end;

	lastSettings = nil;

	local window = display.newRoundedRect(display.contentCenterX, display.contentCenterY, display.actualContentWidth - 40, display.actualContentHeight - 40, 5);
	window:setFillColor(0.14,0.124,0.227,1);
	local title = display.newText('', display.contentCenterX, 5, native.systemFontBold, 17);
	title:setFillColor(1,1,1,1);

	sceneGroup:insert(window);
	sceneGroup:insert(title);

	local close = widget.newButton({label='Zamknij', onEvent = closeEvent, emboss = false, shape = 'roundedRect', width = 200, height = 40, cornerRadius = 2,labelColor = {default = {0.1,0.5,0.8,1}, over = {0.1,0.5,0.8,0.7}}, fillColor = {default = {0.20,0.21,0.36,1}, over={0.17,0.2,0.58,0.7}}, strokeColor = {default = {1,0.4,0,1}, over = {0.8,0.8,1,1}}, strokeWidth = 0});
	close.x, close.y = display.contentCenterX, display.actualContentHeight - 100;

	if data == 'game' then
		title.text = 'Wybierz tryb';
		local classic,classicTime,final,finalTime;

		local classic = widget.newButton({label='Klasyczny', onEvent = onClassicEvent, emboss = false, shape = 'roundedRect', width = 200, height = 40, cornerRadius = 2,labelColor = {default = {0.1,0.5,0.8,1}, over = {0.1,0.5,0.8,0.7}}, fillColor = {default = {0.20,0.21,0.36,1}, over={0.17,0.2,0.58,0.7}}, strokeColor = {default = {1,0.4,0,1}, over = {0.8,0.8,1,1}}, strokeWidth = 0});
		classic.x, classic.y = display.contentCenterX, 75;

		local classicTime = widget.newButton({label='Klasyczny na czas', onEvent = onClassicTimeEvent, emboss = false, shape = 'roundedRect', width = 200, height = 40, cornerRadius = 2,labelColor = {default = {0.1,0.5,0.8,1}, over = {0.1,0.5,0.8,0.7}}, fillColor = {default = {0.20,0.21,0.36,1}, over={0.17,0.2,0.58,0.7}}, strokeColor = {default = {1,0.4,0,1}, over = {0.8,0.8,1,1}}, strokeWidth = 0});
		classicTime.x, classicTime.y = display.contentCenterX, 145;

		local final = widget.newButton({label='Finał', onEvent = onFinalEvent, emboss = false, shape = 'roundedRect', width = 200, height = 40, cornerRadius = 2,labelColor = {default = {0.1,0.5,0.8,1}, over = {0.1,0.5,0.8,0.7}}, fillColor = {default = {0.20,0.21,0.36,1}, over={0.17,0.2,0.58,0.7}}, strokeColor = {default = {1,0.4,0,1}, over = {0.8,0.8,1,1}}, strokeWidth = 0});
		final.x, final.y = display.contentCenterX, 215;

		local finalTime = widget.newButton({label='Finał na czas', onEvent = onFinalTimeEvent, emboss = false, shape = 'roundedRect', width = 200, height = 40, cornerRadius = 2,labelColor = {default = {0.1,0.5,0.8,1}, over = {0.1,0.5,0.8,0.7}}, fillColor = {default = {0.20,0.21,0.36,1}, over={0.17,0.2,0.58,0.7}}, strokeColor = {default = {1,0.4,0,1}, over = {0.8,0.8,1,1}}, strokeWidth = 0});
		finalTime.x, finalTime.y = display.contentCenterX, 285;

		sceneGroup:insert(classic);
		sceneGroup:insert(classicTime);
		sceneGroup:insert(final);
		sceneGroup:insert(finalTime);
	elseif data == 'stats' then
		title.text = 'Statystyki';
		local leftText,rightText;

		local scrollView = widget.newScrollView({left = 20, top = 20, width = display.actualContentWidth - 40, height = display.actualContentHeight - 150, horizontalScrollDisabled = true, hideBackground = true, hideScrollBar = true});

		local answ = userd.get('answers');
		local gansw = userd.get('goodAnswers');
		local bansw = userd.get('badAnswers');
		local rnd = userd.get('allRounds');
		local wrnd = userd.get('winningRounds');
		local pts = userd.get('points');

		leftText = display.newText('Wszystkich odpowiedzi:\nPoprawnych odpowiedzi:\nBłędnych odpowiedzi:\nRozegranych gier:\nWygranych gier:\nPunkty:\n', 90, 70, native.systemFontBold, 14);
		rightText = display.newText(answ..'\n'..gansw..'\n'..bansw..'\n'..rnd..'\n'..wrnd..'\n'..pts..'\n', display.actualContentWidth - 80, 70, native.systemFontBold, 14);

		scrollView:insert(leftText);
		scrollView:insert(rightText);

		sceneGroup:insert(scrollView);
	elseif data == 'settings' then
		title.text = 'Ustawienia';
		local sound,music;
		local soundOp,musicOp = audioManager.get();
		-- load data
		local function soundEvent(event)
			if (event.phase == 'ended') then
				playTap();
				soundOp = not soundOp;
				sound:setLabel('Dźwięk: '..(soundOp and 'Wł' or 'Wył'));

				updateSoundsData(soundOp,musicOp);
			end
		end

		local function musicEvent(event)
			if (event.phase == 'ended') then
				playTap();
				musicOp = not musicOp;
				music:setLabel('Muzyka: '..(musicOp and 'Wł' or 'Wył'));

				updateSoundsData(soundOp,musicOp);
				if musicOp then
					playTheme();
				end
			end
		end

		sound = widget.newButton({label='Dźwięk: '..(soundOp and 'Wł' or 'Wył'), onEvent = soundEvent, emboss = false, shape = 'roundedRect', width = 200, height = 40, cornerRadius = 2,labelColor = {default = {0.1,0.5,0.8,1}, over = {0.1,0.5,0.8,0.7}}, fillColor = {default = {0.20,0.21,0.36,1}, over={0.17,0.2,0.58,0.7}}, strokeColor = {default = {1,0.4,0,1}, over = {0.8,0.8,1,1}}, strokeWidth = 0});
		sound.x, sound.y = display.contentCenterX, 65;

		music = widget.newButton({label='Muzyka: '..(musicOp and 'Wł' or 'Wył'), onEvent = musicEvent, emboss = false, shape = 'roundedRect', width = 200, height = 40, cornerRadius = 2,labelColor = {default = {0.1,0.5,0.8,1}, over = {0.1,0.5,0.8,0.7}}, fillColor = {default = {0.20,0.21,0.36,1}, over={0.17,0.2,0.58,0.7}}, strokeColor = {default = {1,0.4,0,1}, over = {0.8,0.8,1,1}}, strokeWidth = 0});
		music.x, music.y = display.contentCenterX, 115;

		sceneGroup:insert(sound);
		sceneGroup:insert(music);

		lastSettings = true; -- last window was settings
	elseif data == 'rules' then
		title.text = 'Zasady gry';
	elseif data == 'bMenu' then
		title.text = 'Wyjście';

		local label,plbl,btn;
		label = display.newText('Czy na pewno chcesz opuścić grę?\n                Zdobyte punkty\n\n\n\n\n  Nie zostaną zapisane i przepadną!', display.contentCenterX, display.contentCenterY, 260, 160, native.systemFontBold, 15);

		plbl = display.newText(pts, display.contentCenterX - 5, display.contentCenterY - 10, native.systemFontBold, 28);

		local btn = widget.newButton({label='Do menu głównego', onEvent = backEvent, emboss = false, shape = 'roundedRect', width = 200, height = 40, cornerRadius = 2,labelColor = {default = {0.1,0.5,0.8,1}, over = {0.1,0.5,0.8,0.7}}, fillColor = {default = {0.20,0.21,0.36,1}, over={0.17,0.2,0.58,0.7}}, strokeColor = {default = {1,0.4,0,1}, over = {0.8,0.8,1,1}}, strokeWidth = 0});
		btn.x, btn.y = display.contentCenterX, display.actualContentHeight - 170;

		local icn = display.newImageRect('assets/images/question.png', 96, 96);
		icn.x,icn.y = display.contentCenterX, display.contentCenterY - 152;

		sceneGroup:insert(btn);
		sceneGroup:insert(label);
		sceneGroup:insert(plbl);
		sceneGroup:insert(icn);
	elseif data == 'lose' then
		title.text = 'Przegrana';
		--print(pts,gmt);

		local label = display.newText('Niestety zabrakło Ci już szans, aby                        grać dalej.\n\n                Zdobyte punkty', display.contentCenterX, display.contentCenterY, 260, 100, native.systemFontBold, 15);
		local plbl = display.newText(pts, display.contentCenterX - 5, display.contentCenterY + 45, native.systemFontBold, 28);

		local restart = widget.newButton({label='Nowa gra', onEvent = startEvent, emboss = false, shape = 'roundedRect', width = 200, height = 40, cornerRadius = 2,labelColor = {default = {0.1,0.5,0.8,1}, over = {0.1,0.5,0.8,0.7}}, fillColor = {default = {0.20,0.21,0.36,1}, over={0.17,0.2,0.58,0.7}}, strokeColor = {default = {1,0.4,0,1}, over = {0.8,0.8,1,1}}, strokeWidth = 0});
		restart.x, restart.y = display.contentCenterX, display.actualContentHeight - 170;

		local icn = display.newImageRect('assets/images/sad.png', 96, 96);
		icn.x,icn.y = display.contentCenterX, display.contentCenterY - 152;

		gameT = gmt;

		back = true;

		sceneGroup:insert(label);
		sceneGroup:insert(plbl);
		sceneGroup:insert(restart);
		sceneGroup:insert(icn);
	elseif data == 'win' then
		title.text = 'Wygrana';

		local label = display.newText('  Gratulacje! Zwycięstwo w finale.\n                Zdobyte punkty', display.contentCenterX, display.contentCenterY, 250, 100, native.systemFontBold, 15);
		local plbl = display.newText(pts, display.contentCenterX - 5, display.contentCenterY + 10, native.systemFontBold, 28);
		
		local restart = widget.newButton({label='Nowa gra', onEvent = startEvent, emboss = false, shape = 'roundedRect', width = 200, height = 40, cornerRadius = 2,labelColor = {default = {0.1,0.5,0.8,1}, over = {0.1,0.5,0.8,0.7}}, fillColor = {default = {0.20,0.21,0.36,1}, over={0.17,0.2,0.58,0.7}}, strokeColor = {default = {1,0.4,0,1}, over = {0.8,0.8,1,1}}, strokeWidth = 0});
		restart.x, restart.y = display.contentCenterX, display.actualContentHeight - 170;

		local icn = display.newImageRect('assets/images/smile.png', 96, 96);
		icn.x, icn.y = display.contentCenterX, display.contentCenterY - 152;

		gameT = gmt;

		back = true;

		sceneGroup:insert(label);
		sceneGroup:insert(plbl);
		sceneGroup:insert(restart);
		sceneGroup:insert(icn);
	end

	sceneGroup:insert(close);
end

function scene:show(event)
	back,gameT = nil,nil;
	createWindow(event.params.tp, event.params.pt, event.params.tog);
end

function scene:hide(event)
	local sceneGroup = self.view;
	local phase = event.phase;
	local parent = event.parent;

	if (phase == 'will') then

	end
end

scene:addEventListener('show', scene);
scene:addEventListener('hide', scene);
return scene;