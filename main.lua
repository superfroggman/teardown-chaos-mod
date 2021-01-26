
timepassed = 0

function update()
	timepassed = timepassed + 1
    
    if timepassed > 600 then
        timepassed = 0
		
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

