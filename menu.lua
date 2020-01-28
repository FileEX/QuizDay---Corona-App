--[[
    Author: FileEX
]]

local composer = require 'composer';
local widget = require 'widget';
local scene = composer.newScene('menu');
require 'sounds';

local function createWindow(type)
	local options = {isModal = true, effect = 'zoomOutIn', time = 250, params = {tp = type}};

	composer.showOverlay('window', options);
end

local function newGameEvent(event)
	if (event.phase == 'ended') then
		-- pressed and released
		playTap();
		createWindow('game');
	end
end

local function statsEvent(event)
	if (event.phase == 'ended') then
		-- pressed and released
		playTap();
		createWindow('stats');
	end
end

local function settingsEvent(event)
	if (event.phase == 'ended') then
		-- pressed and released
		playTap();
		createWindow('settings');
	end
end

local function exitEvent(event)
	if (event.phase == 'ended') then
		native.requestExit();
	end
end

function scene:create( event )
	local sceneGroup = self.view;
	local bg = display.newImageRect('assets/images/menu.png', display.actualContentWidth, display.actualContentHeight);
	bg.x, bg.y = display.contentCenterX, display.contentCenterY;
	local logo = display.newImageRect('assets/images/qlogo.png', 260, 117);
	logo.x, logo.y = display.contentCenterX, 30;

	local startGame = widget.newButton({label='Rozpocznij grę', onEvent = newGameEvent, emboss = false, shape = 'roundedRect', width = 200, height = 40, cornerRadius = 2, labelColor = {default = {0.1,0.5,0.8,1}, over = {0.1,0.5,0.8,0.7}}, fillColor = {default = {0.20,0.21,0.36,1}, over={0.17,0.2,0.58,0.7}}, strokeColor = {default = {1,0.4,0,1}, over = {0.8,0.8,1,1}}, strokeWidth = 0});
	startGame.x, startGame.y = display.contentCenterX, 200;

	local stats = widget.newButton({label='Statystyki', onEvent = statsEvent, emboss = false, shape = 'roundedRect', width = 200, height = 40, cornerRadius = 2,labelColor = {default = {0.1,0.5,0.8,1}, over = {0.1,0.5,0.8,0.7}}, fillColor = {default = {0.20,0.21,0.36,1}, over={0.17,0.2,0.58,0.7}}, strokeColor = {default = {1,0.4,0,1}, over = {0.8,0.8,1,1}}, strokeWidth = 0});
	stats.x, stats.y = display.contentCenterX, 270;

	local settings = widget.newButton({label='Ustawienia', onEvent = settingsEvent, emboss = false, shape = 'roundedRect', width = 200, height = 40, cornerRadius = 2,labelColor = {default = {0.1,0.5,0.8,1}, over = {0.1,0.5,0.8,0.7}}, fillColor = {default = {0.20,0.21,0.36,1}, over={0.17,0.2,0.58,0.7}}, strokeColor = {default = {1,0.4,0,1}, over = {0.8,0.8,1,1}}, strokeWidth = 0});
	settings.x, settings.y = display.contentCenterX, 340;

	local exit = widget.newButton({label='Wyjdź z gry', onEvent = exitEvent, emboss = false, shape = 'roundedRect', width = 200, height = 40, cornerRadius = 2,labelColor = {default = {0.1,0.5,0.8,1}, over = {0.1,0.5,0.8,0.7}}, fillColor = {default = {0.20,0.21,0.36,1}, over={0.17,0.2,0.58,0.7}}, strokeColor = {default = {1,0.4,0,1}, over = {0.8,0.8,1,1}}, strokeWidth = 0});
	exit.x, exit.y = display.contentCenterX, 410;

	local ver = display.newText('QuizDay v 1.0', display.contentCenterX, display.actualContentHeight - 80, native.systemFontBold, 14);

	sceneGroup:insert(bg);
	sceneGroup:insert(logo);
	sceneGroup:insert(startGame);
	sceneGroup:insert(stats);
	sceneGroup:insert(settings);
	sceneGroup:insert(exit);
	sceneGroup:insert(ver);

	playTheme();
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

function scene:hide( event )
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

    -- Called prior to the removal of scene's "view" (sceneGroup)
    -- 
    -- INSERT code here to cleanup the scene
    -- e.g. remove display objects, remove touch listeners, save state, etc
end

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene;