-- choose_point_scene.lua

local composer = require("composer")
local scene = composer.newScene()

-- Variables to store user inputs
local x1Field, y1Field, kField

-- Function to handle "Choose" button tap event
local function onChooseButtonTap(event)
    -- Retrieve user inputs for x, y coordinates and k value
    local x1 = tonumber(x1Field.text) or 0
    local y1 = tonumber(y1Field.text) or 0
    local k = tonumber(kField.text) or 1
    
    -- Navigate to the next scene
    composer.gotoScene("choose_metrics_scene", {
        effect = "slideLeft",
        time = 500,
        params = {
            x1 = x1,
            y1 = y1,
            k = k
        }
    })
end

-- Function to handle "Back" button tap event
local function onBackButtonTap(event)
    composer.gotoScene("graph_scene", { effect = "slideRight", time = 500 })
end

function scene:create(event)
    local sceneGroup = self.view

    -- Background
    local background = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    background:setFillColor(0.7, 0.7, 1)
    sceneGroup:insert(background)

    -- Title
    local title = display.newText {
        text = "Choose Point to Test",
        x = display.contentCenterX,
        y = 50,
        fontSize = 18,
        font = native.systemFontBold
    }
    title:setFillColor(1)
    sceneGroup:insert(title)

    -- Text fields for x, y coordinates and k value
    x1Field = native.newTextField(display.contentCenterX, 140, 60, 30)
    x1Field.placeholder = "x1"
    sceneGroup:insert(x1Field)

    y1Field = native.newTextField(display.contentCenterX, 190, 60, 30)
    y1Field.placeholder = "y1"
    sceneGroup:insert(y1Field)

    kField = native.newTextField(display.contentCenterX, 240, 80, 30)
    kField.placeholder = "k"
    sceneGroup:insert(kField)

    -- "Choose" button
    local buttonWidth = 150
    local buttonHeight = 30
    local chooseButton = display.newRoundedRect(
        sceneGroup,
        display.contentCenterX,
        display.contentHeight - 130,
        buttonWidth,
        buttonHeight,
        8
    )
    chooseButton:setFillColor(0.5, 0.5, 0.5)
    local chooseButtonText = display.newText {
        text = "Choose",
        x = display.contentCenterX,
        y = display.contentHeight - 130,
        fontSize = 18,
        font = native.systemFont
    }
    chooseButtonText:setFillColor(1)
    sceneGroup:insert(chooseButtonText)

    -- "Back" button
    local backButton = display.newRect(display.contentWidth - 160, display.contentHeight - 35, 60, 30)
    backButton:setFillColor(0.5, 0.5, 0.5)
    sceneGroup:insert(backButton)

    local backButtonText = display.newText {
        text = "Back",
        x = backButton.x,
        y = backButton.y,
        fontSize = 14,
        font = native.systemFont
    }
    sceneGroup:insert(backButtonText)

    -- Add event listeners
    backButton:addEventListener("tap", onBackButtonTap)
    chooseButton:addEventListener("tap", onChooseButtonTap)
end

scene:addEventListener("create", scene)

return scene
