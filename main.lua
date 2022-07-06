
require('util')

local assets, fonts

local speed = 8

local resolution = {
	x = 800,
	y = 600
}

local player = Obj(resolution.x/2, resolution.y/2, 64, 32)

player.angle = 0
player.tilt = 0
player.vel = 0

local score = {
	player = 0,
	enemy = 0
}

function love.load()
	love.graphics.setDefaultFilter('nearest', 'nearest', 4)

	assets = {
		player = NewImage("ball")
	}

	fonts = {
		default = love.graphics.newFont(11),
	}

	love.graphics.setFont(fonts.default)
end

local playing = true

function love.update()
	if love.keyboard.isDown("a") then
		player.tilt = - math.pi/64
	end

	if love.keyboard.isDown("d") then
		player.tilt = math.pi/64
	end

	if love.keyboard.isDown("w") then
		player.vel = 4
	end

	if love.keyboard.isDown("s") then
		player.vel = -4
	end

	player.angle = player.angle + player.tilt

	player.x = player.x + (player.vel*math.cos(player.angle))
	player.y = player.y + (player.vel*math.sin(player.angle))

	player.vel = math.lerp(player.vel, 0, 0.05)
	player.tilt = math.lerp(player.tilt, 0, 0.1)
end

function love.draw()
	love.graphics.setBackgroundColor(0.1,0.1,0.1)
	love.graphics.setColor(0.9,0.9,0.9)

	love.graphics.draw(assets.player, player.x, player.y, player.angle, 4, 4, player.size.x/8, player.size.y/8)

	love.graphics.setFont(fonts.default)
	love.graphics.print("FPS: "..love.timer.getFPS(), 5, 10)
end
