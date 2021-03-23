
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

function resetEffects()
	for i = 1, #effects, 1 do
		SetBool("savegame.mod.effect" .. i, effects[i][4])
	end

	SetBool("savegame.mod.effectsSet", true)
end