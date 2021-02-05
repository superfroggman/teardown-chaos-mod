--NON-CONFIGURABLE
timeToChaos = (GetInt("savegame.mod.timeToChaos", 10) * 60) --configurable in options
timepassed = 0
latestChaos = "";
activeEffects = {}

function init()
	if timeToChaos == 0 then
		timeToChaos = 600
	end
end

function update()
	timepassed = timepassed + 1
	for i = 1, #activeEffects, 1 do
		effect = activeEffects[i]
		--Run effect function
		func = effect[1]
		if(func) then
			func()
		end

		--Decrease time left
		activeEffects[i][3] = effect[3] - 1
		--Remove active effect if time has run out
		if(effect[3] <= 0) then
			table.remove(activeEffects, i)
			i = i - 1
		end
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

function hole()
	MakeHole(GetPlayerTransform().pos, 5, 5, 5)
end

function removeVehicle()
	local vehicle = GetPlayerVehicle()
	if vehicle ~= 0 then
		Delete(GetVehicleBody(vehicle))
	end
end

function fireTrail()
	SpawnFire(GetPlayerTransform().pos)
end

function knock()
    PlaySound(LoadSound("./sound/knock.ogg"))
end

--TAKEN DIRECTLY FROM DEV EXAMPLE
power = 0.5
function vehicleBoost()
	--Only active when player is in vehicle
	v = GetPlayerVehicle()
	if v > 0 then
		--Compute tail point and back direction on vehicle in world space
		local t = GetVehicleTransform(v)
		local p = TransformToParentPoint(t, Vec(0, 0.5, 3))
		local d = TransformToParentVec(t, Vec(0, 0, 1))

		if InputDown("up") then
			--Push the vehicle forwards
			local b = GetVehicleBody(v)	
			local v = GetBodyVelocity(b)
			v = VecAdd(v, VecScale(d, -power))
			SetBodyVelocity(b, v)

			--Engaged particle effects
			local pvel = VecScale(v, 0.7)
			SpawnParticle("fire", p, VecAdd(pvel, VecScale(d, 2)), 1.0, 0.5)
			SpawnParticle("smoke", p, VecAdd(pvel, VecScale(d, 5)), 1, 3.0)
			SpawnParticle("darksmoke", p, VecAdd(pvel, VecScale(d, 10)), 1.5, 1.0)
			
			--Play sound
			PlayLoop(LoadLoop("rocket.ogg"), t.pos, 0.75)
		else
			--Idle particle effect
			SpawnParticle("fire", p, VecScale(d, 1), 0.3, 0.1)
			SpawnParticle("smoke", p, VecScale(d, 2), 0.5, 1.0)
		end
	end
end




--EFFECT LIST

--Function name, effect text, time (0 for once)
effects =
{
	{lowHealth, "Low health", 0},
	{launchUp, "Launch Up", 0},
	{hole, "Diggy Diggy Hole", 0},
	{removeVehicle, "Bye Bye Vehicle", 0},
    {fireTrail, "Fire go brrrrrr", 300},
    {knock, "Who's there?", 0},
	{vehicleBoost, "BOOST", 300}
}

function runRandomFunction ()
	--Get random effect
	randomNumber = math.ceil(math.random(#effects))
	effect = effects[randomNumber]

	--Prevent previous effect from running again
	if(effect[2] == latestChaos) then
		runRandomFunction()
		return
	end

	--Run effect
    func = effect[1]
	if(func) then
		if(effect[3] == 0) then
			func()
		else
			--Need to do this to pass by value and not by reference
			--Can probably be done better
			qa = effect[1]
			qb = effect[2]
			qc = effect[3]
			activeEffects[#activeEffects + 1] = {qa, qb, qc}
		end
		--Set text to effect text
		latestChaos = effect[2]
    else
        latestChaos = "error"
    end
end