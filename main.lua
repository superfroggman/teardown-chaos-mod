
timepassed = 0
timeToChaos = 600;
latestChaos = "";

function update()
	timepassed = timepassed + 1
    
    if timepassed > 250 then
        latestChaos = ""
    end

    if timepassed > timeToChaos  then
        timepassed = 0
		--run random function here
    end
end

function lowHealth()
	SetPlayerHealth(0.1)
end

function launchPlayerUp()
	SetPlayerVelocity(Vec(0, 30, 0))
end

function pauseGame()
	SetPaused(true)
end

function launchVehicleUp()
	local vehicle = GetPlayerVehicle()
	if vehicle ~= 0 then
		SetBodyVelocity(GetVehicleBody(vehicle), Vec(0,30,0))
	end
end

function draw()
    UiTextOutline(0,0,0,1, 0.5)
    UiFont("bold.ttf", 45)
    UiAlign("top left")
    UiText(tostring(round((timeToChaos/60) - (timepassed/60))), true)
    UiText(latestChaos, true)
end

function round(x)
    return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
  end