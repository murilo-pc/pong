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
	x = 640,
	y = 360,
	radius = 10,
}

function love.load() end

function love.update(dt)
	if love.keyboard.isDown("w") and left.y > 0 then
		left.y = left.y - 600 * dt
	end
	if love.keyboard.isDown("s") and left.y < 720 - left.size.y then
		left.y = left.y + 600 * dt
	end
	if love.keyboard.isDown("up") and right.y > 0 then
		right.y = right.y - 600 * dt
	end
	if love.keyboard.isDown("down") and right.y < 720 - right.size.y then
		right.y = right.y + 600 * dt
	end
end

function love.draw()
	love.graphics.circle("fill", ball.x, ball.y, ball.radius)
	love.graphics.rectangle("fill", left.x, left.y, left.size.x, left.size.y)
	love.graphics.rectangle("fill", right.x, right.y, right.size.x, right.size.y)
end
