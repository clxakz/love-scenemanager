local SceneManager = {}
SceneManager.__index = SceneManager

function SceneManager:new()
    local self = setmetatable({}, SceneManager)

    self.current_scene = nil
    self.next_scene = nil
    self.opacity = 0
    self.transitioning = false
    self.fadingOut = false
    self.args = {}
    self.timer = 0

    return self
end


function SceneManager:loadScene(scene, ...)
    local ok, scene_import = pcall(require, "scenes." .. scene)

    if ok then
        self.next_scene = scene_import
        self.args = {...}
        
        self.transitioning = true
    else
        print("Scene " .. scene .. " not found.")
    end
end


function switchScene(self)
    self.current_scene = self.next_scene
    self.next_scene = "" 

    if type(self.current_scene.load) == "function" then
        self.current_scene:load(unpack(self.args or {}))
    end

    self.args = {}
end


function transition(self, dt)
    if self.transitioning then
        self.timer = self.timer + dt

        if self.timer >= 0.02 then
            self.timer = 0

            if self.opacity < 1 and not self.fadingOut then
                self.opacity = math.min(self.opacity + 0.05, 1)
                if self.opacity == 1 then
                    self.fadingOut = true
                    switchScene(self)
                end
            elseif self.opacity > 0 and self.fadingOut then
                self.opacity = math.max(self.opacity - 0.05, 0)
                if self.opacity == 0 then
                    self.transitioning = false
                    self.fadingOut = false
                end
            end
        end
    end
end


function SceneManager:update(dt, ...)
    if self.current_scene and type(self.current_scene.update) == "function" then
        self.current_scene:update(dt, ...)
    end

    transition(self, dt)
end


function SceneManager:keypressed(key, scancode, isrepeat, ...)
    if self.current_scene and type(self.current_scene.keypressed) == "function" then
        self.current_scene:keypressed(key, scancode, isrepeat, ...)
    end
end


function SceneManager:mousepressed(x, y, button, istouch, presses, ...)
    if self.current_scene and type(self.current_scene.mousepressed) == "function" then
        self.current_scene:mousepressed(x, y, button, istouch, presses, ...)
    end
end


function SceneManager:draw(...)
    if self.current_scene and type(self.current_scene.draw) == "function" then
        self.current_scene:draw(...)
    end

    if self.transitioning then
        love.graphics.setColor(0,0,0,self.opacity)
        local w, h = love.graphics.getDimensions()
        love.graphics.rectangle("fill", 0, 0, w, h)
        love.graphics.rectangle("fill", 0, 0, w, h)
        love.graphics.setColor(1,1,1)
    end
end

return SceneManager