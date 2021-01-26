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
		runRandomFunction()
    end
end



--DRAW

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



--EFFECTS

function lowHealth()
	SetPlayerHealth(0.1)
end

function launchUp()
	local vehicle = GetPlayerVehicle()

	velocity = Vec(0,30,0)
	if vehicle ~= 0 then
		SetBodyVelocity(GetVehicleBody(vehicle), velocity)
	else
		SetPlayerVelocity(velocity)
	end
end

function pauseGame()
	SetPaused(true)
end



--EFFECT LIST

c_tbl =
{
	{lowHealth, "Low health"},
	{launchUp, "Launch Up"},
	{pauseGame, "Pause Game"},
}

function runRandomFunction ()
	randomNumber = math.ceil(math.random(#c_tbl))
	tableItem = c_tbl[randomNumber]
    func = tableItem[1]
    if(func) then
		func()
		latestChaos = tableItem[2]
    else
        latestChaos = "error"
    end
end