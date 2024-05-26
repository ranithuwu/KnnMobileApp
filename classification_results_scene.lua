local composer = require("composer")
local scene = composer.newScene()

-- Function to handle "Back" button tap event
local function onBackButtonTap(event)
    composer.gotoScene("choose_metrics_scene", { effect = "slideRight", time = 500 })
end

function scene:create(event)
    local sceneGroup = self.view

    -- Background
    local background = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    background:setFillColor(0.7, 0.7, 1)
    sceneGroup:insert(background)

    -- Retrieve the classification result from the parameters
    local classificationResult = event.params.classificationResult

 
    local resultLabel = display.newText {
        text = "Classification Result: " .. classificationResult,
        x = display.contentCenterX,
        y = display.contentCenterY,
        fontSize = 15,
        font = native.systemFontBold
    }
    sceneGroup:insert(resultLabel)

    -- Back button
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

    backButton:addEventListener("tap", onBackButtonTap)
end

scene:addEventListener("create", scene)

return scene
