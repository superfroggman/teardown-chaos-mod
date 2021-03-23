
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
function vehicleBoost()
	local power = 0.5
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
			PlayLoop(LoadLoop("./sound/rocket.ogg"), t.pos, 0.75)
		else
			--Idle particle effect
			SpawnParticle("fire", p, VecScale(d, 1), 0.3, 0.1)
			SpawnParticle("smoke", p, VecScale(d, 2), 0.5, 1.0)
		end
	end
end

function loadLevel()
	StartLevel("basic", "./maps/basic/main.xml")
end

function vehicleSpin()
	local angVel = Vec(0,2000,0)
	local vehicle = GetPlayerVehicle()

	if vehicle ~= 0 then
		SetBodyAngularVelocity(GetVehicleBody(vehicle), angVel)
	end
end

function laserVision()
	hitPoint = raycast()
	MakeHole(hitPoint, 0.2, 0.2, 0.2)
	SpawnParticle("smoke", hitPoint, Vec(0, 1, 0), 1, 2)
end

function fireVision()
	SpawnFire(raycast())
end

function explosionAtSight()
	Explosion(raycast(), 1)
end

function throttle()
	if(lastVehicle ~= 0) then
		DriveVehicle(lastVehicle, 1, 0, false)
	end
end

function fullHealth()
	SetPlayerHealth(1)
end



--EFFECT LIST

--Function name, effect text, time (0 for once), active by default
effects =
{
	{lowHealth, "Low health", 0, true},
	{launchUp, "Launch Up", 0, true},
	{hole, "Diggy Diggy Hole", 0, true},
	{removeVehicle, "Bye Bye Vehicle", 0, false},
    {fireTrail, "Fire go brrrrrr", 300, true},
    {knock, "Who's there?", 0, true},
	{vehicleBoost, "BOOST", 1200, true},
	{vehicleSpin, "You spin me right round", 0, true},
	{laserVision, "Laser vision", 300, true},
	{fireVision, "Fire vision", 300, true},
	{explosionAtSight, "Watch where you're looking", 0, true},
	{throttle, "Runaway vehicle", 600, true},
	{fullHealth, "Invincibility", 600, true}
}

