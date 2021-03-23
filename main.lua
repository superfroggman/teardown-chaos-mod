#include "effects.lua"
#include "options.lua"

--NON-CONFIGURABLE
timeToChaos = (GetInt("savegame.mod.timeToChaos", 10) * 60) --configurable in options
timepassed = 0
latestChaos = "";
activeEffects = {}
local lastVehicle

function init()
	if timeToChaos == 0 then
		timeToChaos = 600
	end

	if not GetBool("savegame.mod.effectsSet") then
		resetEffects()
	end
end

function tick()
	--Get player vehicle
	v = GetPlayerVehicle()
	if(v ~= 0) then
		lastVehicle = v
	end

	--Run active effects
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

	--Select random effects
    if timepassed >= timeToChaos  then
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







function runRandomFunction ()
	
	--Get random effect
	randomNumber = math.ceil(math.random(#effects))
	effect = effects[randomNumber]

	--Prevent previous effect from running again
	if(effect[2] == latestChaos or not GetBool("savegame.mod.effect"..randomNumber)) then
		runRandomFunction()
		return
	end

	--Run effect
    func = effect[1]
	if(func) then
		if(effect[3] == 0) then
			func()
		else
			addActiveEffect(effect)
		end
		--Set text to effect text
		latestChaos = effect[2]
    else
        latestChaos = "error"
    end
end

function addActiveEffect(effect)
	--Need to do this to pass by value and not by reference
	--Can probably be done better
	qa = effect[1]
	qb = effect[2]
	qc = effect[3]
	activeEffects[#activeEffects + 1] = {qa, qb, qc}
end



--USEFUL FUNCTIONS
function raycast()
	local t = GetCameraTransform()
	local dir = TransformToParentVec(t, {0, 0, -1})
	
	local hit, dist, normal, shape = QueryRaycast(t.pos, dir, 1000)
	if hit then
		local hitPoint = VecAdd(t.pos, VecScale(dir, dist))
		return hitPoint
	end
end

function round(x)
    return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
end
