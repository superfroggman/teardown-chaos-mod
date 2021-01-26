
timepassed = 0

function update()
	timepassed = timepassed + 1
    
    if timepassed > 600 then
        timepassed = 0
        
        SetPlayerHealth(0.1)
    end
end
