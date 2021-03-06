#include "effects.lua"
#include "utilities.lua"

timeToChaos = GetInt("savegame.mod.timeToChaos", 10)

--From https://steamcommunity.com/sharedfiles/filedetails/?id=2419552682
function drawButton(title, key, value)
	UiPush();
		if UiTextButton(title, 320, 40) then
			SetBool(key, not GetBool(key));	
		end

		if GetBool(key) then
			UiColor(0.5, 1, 0.5);
			UiTranslate(-140, 0);
			UiImage("ui/menu/mod-active.png");
		else
			UiTranslate(-140, 0);
			UiImage("ui/menu/mod-inactive.png");
		end
	UiPop();
end




function init()
	--Set default enabled effects if not already changed
	if not GetBool("savegame.mod.effectsSet") then
		resetEffects()
	end
end

function draw()
	UiTranslate(UiCenter(), 250)
	UiAlign("center middle")

	--Title
	UiFont("bold.ttf", 48)
	UiText("Chaos Mod Options")
		
	--Needed to render buttons
	UiFont("regular.ttf", 26)
	UiButtonImageBox("ui/common/box-outline-6.png", 6, 6)

	--Text
	UiTranslate(0, 100)
	UiFont("bold.ttf", 36)
	UiText("Time between chaos: ")
	UiFont("regular.ttf", 26)

	--Slider
	UiPush()
		UiTranslate(0, 50)
		UiColor(1,1,0.7)
		UiRect(250, 3)
		UiColor(1,1,1)
		UiTranslate(-125, 0)
		timeToChaos = UiSlider("gfx/dot.png", "x", timeToChaos, 1, 250)
		SetInt("savegame.mod.timeToChaos", timeToChaos)
		UiTranslate(125, 20)
		UiFont("regular.ttf", 24)
		UiText(math.floor(timeToChaos))	
	UiPop()
	
	--Effect buttons
	buttonW = 350
	perRow = 5
	UiPush()
		UiTranslate(250, 150)
		UiTranslate(-UiCenter(), 0)
		for i = 1, #effects, 1 do
			drawButton(effects[i][2], "savegame.mod.effect" .. i, true)

			UiTranslate(buttonW,0)
			if(i%perRow==0) then
				UiTranslate(0,50)
				UiTranslate(-buttonW*(perRow), 0) 
			end
		end
	UiPop()
	
	--Close button
	UiTranslate(0, 550)
	if UiTextButton("Close", 200, 40) then
		Menu()
    end
end

