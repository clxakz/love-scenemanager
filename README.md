# LÖVE2D Basic Scene Manager

**Instalation**
```
git clone https://github.com/clxakz/love-scenemanager
```

**Setup**
```lua
function love.load()
  local SceneManager = require("scenemanager")
  scenemanager = SceneManager:new()
end

function love.update(dt)
  scenemanager:update(dt)
end

function love.draw()
  scenemanager:draw()
end
```

**Creating Scenes**
> [!IMPORTANT]
> Create a scenes folder in your root folder, that's where your scenes will be located at.

*A basic scene setup example*
```lua
-- ./scenes/mainmenu.lua
MainMenu = {}

function MainMenu:load()
  self.text = "Main Menu"
end

function MainMenu:update() -- Not required

end

function MainMenu:draw() -- Not required
  love.graphics.print(self.text, 100, 100)
end

return MainMenu
```

**Loading Scenes**
```lua
function love.load()
  -- scenemanager loads scenes based on their filename,
  -- e.g. A MainMenu scene should be called mainmenu.lua
  scenemanager:loadScene("mainmenu")
end
```

*You can also pass variables between scenes*
```lua
-- mainmenu.lua
function MainMenu:load()
  self.score = 100
end

function love.keypressed(key)
  if key == "space" then
    scenemanager:loadScene("game", "love2d", self.score)
  end
end


-- game.lua
function Game:load(text, score)
  print(text .. score) -- "love2d100"
end
```

**SceneManager can pass key and mouse events by default**

```lua
-- main.lua
function love.load()
  local SceneManager = require("scenemanager")
  scenemanager = SceneManager:new()
end


function love.keypressed(key)
  scenemanager:keypressed(key)
end


function love.mousepressed(x, y, button)
  scenemanager:mousepressed(key)
end


-- custom event
function love.keyreleased(key)
  if scenemanager.current_scene and type(scenemanager.current_scene.keyreleased) == "function" then
    scenemanager.current_scene:keyreleased(key) 
  end
end

-- game.lua
function Game:keypressed(key)
  print(key)
end
```
