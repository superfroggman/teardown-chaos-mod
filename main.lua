timepassed = 0
timeToChaos = 600;
latestChaos = "";

function update()
    timepassed = timepassed + 1

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

function hole()
	MakeHole(GetPlayerTransform().pos, 5, 5, 5)
end

function removeVehicle()
	local vehicle = GetPlayerVehicle()
	if vehicle ~= 0 then
		Delete(GetVehicleBody(vehicle))
	end
end

function ignitePlayer()
	SpawnFire(GetPlayerTransform().pos)
end

function knock()
    PlaySound(LoadSound("./sound/knock.ogg"))
end



--EFFECT LIST

--Function name, effect text, time (0 for once)
effects =
{
	{lowHealth, "Low health"},
	{launchUp, "Launch Up"},
	{hole, "Diggy Diggy Hole"},
	{removeVehicle, "Bye Bye Vehicle"},
    {ignitePlayer, "Fire go brrrrrr"},
    {knock, "Who's there"}
}

function runRandomFunction ()
	--Get random effect
	randomNumber = math.ceil(math.random(#effects))
	tableItem = effects[randomNumber]

	--Prevent previous effect from running again
	if(tableItem[2] == latestChaos) then
		runRandomFunction()
		return
	end

	--Run effect
    func = tableItem[1]
	if(func) then
		func()
		--Set text to effect text
		latestChaos = tableItem[2]
    else
        latestChaos = "error"
    end
end