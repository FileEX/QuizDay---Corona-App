--[[
	Author: FileEX
]]

local composer = require 'composer';
local scene = composer.newScene();
local widget = require 'widget';
local gameType;
require 'sounds';

local rulesData = {
	['classic'] = [[Tryb klasyczny podzielony jest na trzy etapy. Na odpowiedź masz nieograniczony czas, każdy etap różni się ilością pytań oraz ich stopniem trudności. W kółku na ekranie widnieje liczba pozostałych pytań.

Etap I
	Musisz udzielić odpowiedzi na 4 pytania. Musisz zachować conajmniej jedną szansę, aby przejść do następnego etapu. Masz 3 szanse. Za każdą poprawną odpowiedź otrzymujesz 10 punktów.
	
Etap II
	W tym etapie musisz udzielić odpowiedzi na 10 pytań, aby przejść do etapu finałowego musisz zachować choć jedną szansę. Masz tyle szans ile zachowałeś z pierwszego etapu. Za każdą poprawną odpowiedź otrzymujesz 10 punktów.
	
	Etap III (Finał)
	Jest to etap finałowy, musisz udzielić odpowiedzi na 15 pytań. Za każdą poprawną odpowiedź otrzymujesz 20 punktów. Dodatkowo otrzymujesz 10 punktów za każdą zachowaną szansę w poprzednim etapie. W tym etapie masz nowe 3 szanse.]],
	['classicTime'] = [[Tryb klasyczny podzielony jest na trzy etapy. Na odpowiedź masz 30 sekund, każdy etap różni się ilością pytań oraz ich stopniem trudności. W kółku na ekranie widnieje pozostały czas na udzielenie odpoweidzi, ilość pytań znajduje się u góry ekranu.

Etap I
	Musisz udzielić odpowiedzi na 4 pytania. Musisz zachować conajmniej jedną szansę, aby przejść do następnego etapu. Masz 3 szanse. Za każdą poprawną odpowiedź otrzymujesz 10 punktów.
	
Etap II
	W tym etapie musisz udzielić odpowiedzi na 10 pytań, aby przejść do etapu finałowego musisz zachować choć jedną szansę. Masz tyle szans ile zachowałeś z pierwszego etapu. Za każdą poprawną odpowiedź otrzymujesz 10 punktów.
	
Etap III (Finał)
	Jest to etap finałowy, musisz udzielić odpowiedzi na 15 pytań. Za każdą poprawną odpowiedź otrzymujesz 20 punktów. W tym etapie masz nowe 3 szanse.]],
	['final'] = [[Jest to etap finałowy. Na każdą odpowiedź masz nieograniczony czas. Musisz udzielić odpowiedzi na 15 pytań. Masz 3 szanse. W kółku na ekranie widnieje liczba pozostałych pytań.]],
	['finalTime'] = [[Jest to etap finałowy. Na każdą odpowiedź masz 30 sekund. Musisz udzielić odpowiedzi na 15 pytań. Masz 3 szanse. W kółku na ekranie widnieje pozostały czas na udzielenie odpowiedzi. Ilość pozostałych pytań znajduje się u góry ekranu.]],
};

local function closeEvent(event)
	if (event.phase == 'ended') then
		playTap();
		composer.hideOverlay('fade', 250);
	end
end

local function startEvent(event)
	if (event.phase == 'ended') then
		playTap();
		composer.hideOverlay('fade', 250);
		composer.removeScene('window');
		composer.removeScene('menu');
		composer.gotoScene('game', {effect = 'crossFade', time = 350, params = {a = gameType}});
		if (gameType == 'final' or gameType == 'finalTheme') then
			reloadTheme(3);
		else
			reloadTheme(1);
		end
		playTheme();
	end
end

local function createWindow(data)
	local sceneGroup = scene.view;

	local window = display.newRoundedRect(display.contentCenterX, display.contentCenterY, display.actualContentWidth - 60, display.actualContentHeight - 60, 5);
	window:setFillColor(0.14,0.124,0.227,1);
	local title = display.newText('Zasady gry', display.contentCenterX, 25, native.systemFontBold, 17);
	title:setFillColor(1,1,1,1);

	local scrollView = widget.newScrollView({left = 30, top = 45, width = display.actualContentWidth - 60, height = display.actualContentHeight - 245, horizontalScrollDisabled = true, hideBackground = true, hideScrollBar = true});

	local options = 
	{
    	text = '',  
    	x = 130,
    	y = 270,
    	width = 250,
    	height = -(display.actualContentHeight - 220),
    	font = native.systemFont,
    	fontSize = 14,
    	align = 'left',
	};

	local rules = display.newText(options);
	scrollView:insert(rules);

	sceneGroup:insert(window);
	sceneGroup:insert(title);
	sceneGroup:insert(scrollView);

	if (data == 'classicRules') then
		rules.text = rulesData['classic'];
		rules.y = 270;
		gameType = 'classic';
	elseif (data == 'classicTimeRules') then
		rules.text = rulesData['classicTime'];
		rules.y = 270;
		gameType = 'classicTime';
	elseif (data == 'finalRules') then
		rules.text = rulesData['final'];
		rules.y = 45;
		gameType = 'final';
	elseif (data == 'finalTimeRules') then
		rules.text = rulesData['finalTime'];
		rules.y = 60;
		gameType = 'finalTime';
	end

	local start = widget.newButton({label='Rozpocznij', onEvent = startEvent, emboss = false, shape = 'roundedRect', width = 200, height = 40, cornerRadius = 2,labelColor = {default = {0.1,0.5,0.8,1}, over = {0.1,0.5,0.8,0.7}}, fillColor = {default = {0.20,0.21,0.36,1}, over={0.17,0.2,0.58,0.7}}, strokeColor = {default = {1,0.4,0,1}, over = {0.8,0.8,1,1}}, strokeWidth = 0});
	start.x, start.y = display.contentCenterX, display.actualContentHeight - 170;

	local close = widget.newButton({label='Zamknij', onEvent = closeEvent, emboss = false, shape = 'roundedRect', width = 200, height = 40, cornerRadius = 2,labelColor = {default = {0.1,0.5,0.8,1}, over = {0.1,0.5,0.8,0.7}}, fillColor = {default = {0.20,0.21,0.36,1}, over={0.17,0.2,0.58,0.7}}, strokeColor = {default = {1,0.4,0,1}, over = {0.8,0.8,1,1}}, strokeWidth = 0});
	close.x, close.y = display.contentCenterX, display.actualContentHeight - 100;

	sceneGroup:insert(close);
	sceneGroup:insert(start);
end

function scene:show(event)
	createWindow(event.params.tp);
end

function scene:hide(event)
	local sceneGroup = self.view;
	local phase = event.phase;
	local parent = event.parent;

	if (phase == 'will') then
		local options = {isModal = true, effect = 'zoomOutIn', time = 250, params = {tp = 'game'}};

		composer.showOverlay('window', options);
	end
end

scene:addEventListener('show', scene);
scene:addEventListener('hide', scene);

return scene;