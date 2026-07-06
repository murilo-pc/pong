local left = {
	size = { x = 10, y = 100 },
	y = 250,
	x = 50,
}
local right = {
	size = { x = 10, y = 100 },
	y = 250,
	x = 1230,
}
local ball = {
	--size =
}

function love.load() end

function love.update(dt)
	if love.keyboard.isDown("w") then
		left.y = left.y - 600 * dt
	end
	if love.keyboard.isDown("s") then
		left.y = left.y + 600 * dt
	end
	if love.keyboard.isDown("up") then
		right.y = right.y - 600 * dt
	end
	if love.keyboard.isDown("down") then
		right.y = right.y + 600 * dt
	end
end

function love.draw()
	love.graphics.rectangle("fill", left.x, left.y, left.size.x, left.size.y)
	love.graphics.rectangle("fill", right.x, right.y, right.size.x, right.size.y)
end
