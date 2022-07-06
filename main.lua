
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
		player = NewImage("ball"),
		bullet = NewImage("bullet")
	}

	fonts = {
		default = love.graphics.newFont(11),
	}

	love.graphics.setFont(fonts.default)
end

local playing = true

local bullets = {

}

local oldspacedown

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

	if love.keyboard.isDown("space") and not oldspacedown then
		local newbullet = Obj(player.x, player.y, 16, 8)
		newbullet.angle = player.angle

		table.insert(bullets, newbullet)
	end
	--oldspacedown = love.keyboard.isDown("space")

	for id, bullet in pairs(bullets) do
		bullet.x = bullet.x + (10*math.cos(bullet.angle))
		bullet.y = bullet.y + (10*math.sin(bullet.angle))

		-- Drop bullet if too far off screen
		if not CheckCollision(-50,-50,resolution.x+100,resolution.y+100, bullet.x, bullet.y, bullet.size.x, bullet.size.y) then
			bullets[id] = nil
		end
	end
end

function love.draw()
	love.graphics.setBackgroundColor(0.1,0.1,0.1)
	love.graphics.setColor(0.9,0.9,0.9)

	local numbullets = 0

	for _,bullet in pairs(bullets) do
		love.graphics.draw(assets.bullet, bullet.x, bullet.y, bullet.angle, 1, 1)
		numbullets = numbullets + 1
	end

	love.graphics.draw(assets.player, player.x, player.y, player.angle, 4, 4, player.size.x/8, player.size.y/8)

	love.graphics.setFont(fonts.default)
	love.graphics.print("FPS: "..love.timer.getFPS()..", #bullets = "..numbullets, 5, 10)
end
