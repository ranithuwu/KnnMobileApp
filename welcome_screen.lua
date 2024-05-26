local composer = require("composer")
local widget = require("widget")

local scene = composer.newScene()

local function onStartButtonPress(event)
    composer.gotoScene("graph_scene", { effect = "slideLeft", time = 500 })
end

function scene:create(event)
    local sceneGroup = self.view

    local background = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    background:setFillColor(0.7, 0.7, 1) 
    sceneGroup:insert(background)

    local welcomeImage = display.newImage("kNN_pic2.png") 
    welcomeImage.width = 200 
    welcomeImage.height = 200 
    welcomeImage.x = display.contentCenterX
    welcomeImage.y = display.contentCenterY - 25
    sceneGroup:insert(welcomeImage)

    local titleLabel = display.newText {
        text = "kNN Classification App",
        x = display.contentCenterX,
        y = display.contentCenterY - 170,
        fontSize = 18,
        font = native.systemFontBold,
        shadow = { x = 2, y = 2, blur = 3, color = { 0, 0, 0, 0.6 } } 
    }
    titleLabel:setFillColor(0)
    sceneGroup:insert(titleLabel)

    local startButton = widget.newButton({
        width = 200,
        height = 60,
        shape = "roundedRect",
        cornerRadius = 10,
        label = "START!!!",
        fontSize = 20,
        fillColor = { default={0.5, 0.5, 0.5}, over={0.8, 0.8, 0.8} }, 
        labelColor = { default={1, 1, 1} }, 
        onPress = onStartButtonPress
    })
    startButton.x = display.contentCenterX
    startButton.y = display.contentCenterY + 160
    sceneGroup:insert(startButton)
end

scene:addEventListener("create", scene)

return scene
