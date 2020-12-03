
-- experimental camera

local camera = {}
camera.x = 0
camera.y = 0
camera.sx = 1
camera.sy = 1
camera.rotation = 0

function camera:set()
  love.graphics.push()
  love.graphics.rotate(-self.rotation)
  love.graphics.scale(1 / self.sx, 1 / self.sy)
  love.graphics.translate(-self.x, -self.y)
end

function camera:unset()
  love.graphics.pop()
end

function camera:rotate(dr)
  self.rotation = self.rotation + dr
end

function camera:move(dx, dy)
  self.x = self.x + (dx or 0)
  self.y = self.y + (dy or 0)
end

function camera:scale(sx, sy)
  sx = sx or 1
  sy = sy or 1
  self.sx = self.sx * sx
  self.sy = self.sy * sy
end

function camera:setX(value)
  if self._bounds then
    self.x = math.clamp(value, self._bounds.x1, self._bounds.x2)
  else
    self.x = value
  end
end

function camera:setY(value)
  if self._bounds then
    self.y = math.clamp(value, self._bounds.y1, self._bounds.y2)
  else
    self.y = value
  end
end

function camera:setPosition(x, y)
  if x then self:setX(x) end
  if y then self:setY(y) end
end

function camera:setScale(sx, sy)
  self.sx = sx or self.sx
  self.sy = sy or self.sy
end

function camera:getBounds()
  return unpack(self._bounds)
end

function camera:setBounds(x1, y1, x2, y2)
  self._bounds = { x1 = x1, y1 = y1, x2 = x2, y2 = y2 }
end

function math.clamp(x, min, max)
  return x < min and min or (x > max and max or x)
end

return camera