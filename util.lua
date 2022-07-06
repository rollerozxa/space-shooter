function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
	return	x1 < x2+w2
		and	x2 < x1+w1
		and	y1 < y2+h2
		and	y2 < y1+h1
end

function CheckCollisionObj(obj1, obj2)
	return CheckCollision(obj1.x, obj1.y, obj1.size.x, obj1.size.y, obj2.x, obj2.y, obj2.size.x, obj2.size.y)
end

function Obj(x,y,w,h)
	return {
		x = x,
		y = y,
		size = {
			x = w,
			y = h
		}
	}
end

function math.clamp(low, n, high)
	return math.min(math.max(n, low), high)
end

function math.lerp(a,b,t)
	return a * (1-t) + b * t
end

function NewImage(filename)
	return love.graphics.newImage("assets/"..filename..".png")
end

