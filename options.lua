timeToChaos = GetInt("savegame.mod.timeToChaos", 10)

function draw()
	UiTranslate(UiCenter(), 250)
	UiAlign("center middle")
	if timeToChaos == 0 then
		timeToChaos = 10
	end
	SetInt("savegame.mod.timeToChaos", timeToChaos)
	--Title
	UiFont("bold.ttf", 48)
	UiText("Chaos Mod options")
	
	--Draw buttons
	UiTranslate(0, 100)
	UiFont("regular.ttf", 26)
	UiText("Time between chaos: "..timeToChaos)
	UiTranslate(0, 50)
	UiButtonImageBox("ui/common/box-outline-6.png", 6, 6)
	UiPush()
		UiTranslate(-110, 0)
		if UiTextButton("Decrease", 200, 40) then
			if timeToChaos > 1 then
				timeToChaos = timeToChaos - 1
			end
		end
		UiTranslate(220, 0)
		if UiTextButton("Increase", 200, 40) then
			if timeToChaos < 100 then
				timeToChaos = timeToChaos + 1
			end
		end
	UiPop()
	
	UiTranslate(0, 100)
	if UiTextButton("Close", 200, 40) then
		Menu()
	end
end

