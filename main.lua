local left = {
	size = { x = 10, y = 100 },
	y = 250,
	x = 50,
	velocity = 0,
	speed = 1000,
	max_velocity = 800,
	brake = 600,
}
local right = {
	size = { x = 10, y = 100 },
	y = 250,
	x = 1230,
	velocity = 0,
	speed = 1000,
	max_velocity = 800,
	brake = 600,
}
local ball = {
	x = 640,
	y = 360,
	radius = 10,
	angle = 0.75 * math.pi,
	speed = 500,
}

local function ball_colision(paddle)
	return ball.y >= paddle.y - ball.radius
		and ball.y <= paddle.y + paddle.size.y + ball.radius
		and ball.x > paddle.x - ball.radius
		and ball.x < paddle.x + paddle.size.x + ball.radius
end

local function ball_movement(dt)
	ball.x = ball.x + ball.speed * math.cos(ball.angle) * dt
	ball.y = ball.y + ball.speed * math.sin(ball.angle) * dt
	if ball.y < 0 + ball.radius or ball.y > 720 - ball.radius then
		ball.angle = -ball.angle
	end
	if ball_colision(left) then
		ball.x = left.x + left.size.x + ball.radius
		ball.angle = math.pi - ball.angle - left.velocity / (left.velocity * 4) * math.pi
	end
	if ball_colision(right) then
		ball.x = right.x - ball.radius
		ball.angle = math.pi - ball.angle - right.velocity / (right.max_velocity * 4) * math.pi
	end

	if ball.x < 0 - ball.radius * 2 or ball.x > 1280 + ball.radius * 2 then
		ball.x = 640
		ball.y = 360
		ball.angle = ball.angle + math.pi
	end
end

local function paddle_movment(paddle, up, down, dt)
	if love.keyboard.isDown(up) and paddle.velocity > paddle.max_velocity * -1 then
		paddle.velocity = paddle.velocity - paddle.speed * dt
	elseif love.keyboard.isDown(down) and paddle.velocity < paddle.max_velocity then
		paddle.velocity = paddle.velocity + paddle.speed * dt
	else
		if paddle.velocity > 0 then
			paddle.velocity = paddle.velocity - paddle.brake * dt
		elseif paddle.velocity < 0 then
			paddle.velocity = paddle.velocity + paddle.brake * dt
		end
	end
	paddle.y = paddle.y + paddle.velocity * dt
	if paddle.y < 0 then
		paddle.y = 0
		paddle.velocity = 0
	elseif paddle.y > 720 - paddle.size.y then
		paddle.y = 720 - paddle.size.y
		paddle.velocity = 0
	end
end

function love.load() end

function love.update(dt)
	paddle_movment(right, "up", "down", dt)
	paddle_movment(left, "w", "s", dt)
	ball_movement(dt)
end

function love.draw()
	love.graphics.circle("fill", ball.x, ball.y, ball.radius)
	love.graphics.rectangle("fill", left.x, left.y, left.size.x, left.size.y)
	love.graphics.rectangle("fill", right.x, right.y, right.size.x, right.size.y)
end
