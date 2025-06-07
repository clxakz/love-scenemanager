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

function MainMenu.load()
  self.text = "Main Menu"
end

function MainMenu.update()

end

function MainMenu.draw()
  love.graphics.print(self.text, 100, 100)
end

return MainMenu
```

**Loading Scenes**
```lua
function love.load()
  --scenemanager loads scenes based on their filename, e.g. A MainMenu scene should be called mainmenu.lua
  scenemanager:loadScene("mainmenu")
end
```
