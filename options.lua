function draw()
	UiTranslate(UiCenter(), 250)
	UiAlign("center middle")

	--Title
	UiFont("bold.ttf", 48)
	UiText("Chaos Mod options")
	
	--Draw buttons
	UiTranslate(0, 200)
	UiFont("regular.ttf", 26)
	value = UiSlider("images/dot.png", "x", value, 0, 100)
	
	UiTranslate(0, 100)
	if UiTextButton("Close", 200, 40) then
		Menu()
	end
end

