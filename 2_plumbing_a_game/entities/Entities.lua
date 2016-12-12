-- Represents a collection of drawable entities.  Each gamestate holds one of these.

local Entities = {
	active = true,
	map = nil,
	world = nil,
	entityList = {}
}

function Entities:enter()
	self:clear()
end

function Entities:add(entity)
	table.insert(self.entityList, entity)
end

function Entities:remove(entity)
	for i, e in ipairs(self.entityList) do
		if e == entity then
			table.remove(self.entityList, i)
			return
		end
	end
end

function Entities:removeAt(index)
	table.remove(self.entityList, index)
end

function Entities:clear()
	self.map = nil
	self.world = nil
	self.entityList = {}
end

function Entities:draw()
	if self.map ~= nil then
		local camWorldWidth = love.graphics.getWidth() / cam.scale
		local camWorldHeight = love.graphics.getHeight() / cam.scale
		local camWorldX = cam.x - (camWorldWidth / 2)
		local camWorldY = cam.y - (camWorldHeight / 2)
		self.map:setDrawRange(camWorldX, camWorldY, love.graphics.getWidth(), love.graphics.getHeight())
		self.map:draw()
	end

	for i, e in ipairs(self.entityList) do
		e:draw(i)
	end
end

function Entities:update(dt)
	if self.world ~= nil then
		self.world:update(dt)
	end

	for i, e in ipairs(self.entityList) do
		e:update(dt, i)
	end
end

return Entities