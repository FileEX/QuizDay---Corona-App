--[[
	Author: FileEX
]]

audio.reserveChannels(4); -- sounds, bg streams, audio questions, answer effect

local volume = {0.9,0.4};
local sounds,music;

local tapSound = audio.loadSound('assets/sounds/tap.wav'); --- button tap
local bgTheme = audio.loadStream('assets/sounds/menuTheme.ogg'); -- first load menu theme
local succesSound, errorSound = audio.loadSound('assets/sounds/ok.wav'), audio.loadSound('assets/sounds/bad.wav');
local ms;

function loadAudioData()
	audio.setVolume(volume[1], {channel = 1});
	audio.setVolume(volume[2], {channel = 2});
	audio.setVolume(1.0, {channel = 3});
	audio.setVolume(volume[1], {channel = 4});
end

function playTap()
	if sounds then
		audio.play(tapSound, {channel = 1, duration = 500, fadeIn = 100});
	end
end

function playSignal(i)
	if sounds then
		audio.play(i == 1 and succesSound or errorSound, {channel = 4});
	end
end

function updateSoundsData(snd,msc)
	if not msc then
		audio.stop(2);
		--audio.dispose(bgTheme);
		--bgTheme = nil;
	end

	sounds,music = snd,msc;
end

function getSoundsData()
	return sounds,music;
end

function reloadTheme(to)
	audio.stop(2);
	audio.dispose(bgTheme);
	bgTheme = nil;
	bgTheme = audio.loadStream(to == 1 and 'assets/sounds/gameTheme.ogg' or (to == 2 and 'assets/sounds/menuTheme.ogg' or 'assets/sounds/finalTheme.ogg')); -- change theme
end

function playTheme()
	if music then
		audio.play(bgTheme, {channel = 2, loops = -1});
	end
end

local function pauseTheme(pause)
	if pause then
		audio.pause(2);
	else
		if music then
			audio.resume(2);
		end
	end
end

function stopMusic()
	audio.stop(3);
	audio.dispose(ms);
	ms = nil;
end

local function finishMusic(event)
	if event.completed then
		audio.stop(3);
		audio.dispose(ms);
		ms = nil;
		pauseTheme(false);
	end
end

function playMusic(id)
	pauseTheme(true);
	ms = audio.loadStream('assets/musics/'..id..'.ogg');
	audio.play(ms, {channel = 3, onComplete = finishMusic});
end

loadAudioData();

return {get = getSoundsData};