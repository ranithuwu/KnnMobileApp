local composer = require("composer")
local widget = require("widget")
local scene = composer.newScene()

local selectedMetric = "Euclidean" 
local useHarmonicWeighting = false 

local function onMetricRadioButtonTap(event)
    selectedMetric = event.target.id
    print("Selected Metric:", selectedMetric)
end

local function onHarmonicWeightingCheckboxTap(event)
    useHarmonicWeighting = event.target.isOn
    print("Use Harmonic Weighting:", useHarmonicWeighting)
end

local function calculateClassificationResult()
    local classes = {"Class A", "Class B"} 
    local randomIndex = math.random(1, #classes)
    return classes[randomIndex] 
end

local function onBackButtonTap(event)
    composer.gotoScene("choose_point_scene", { effect = "slideRight", time = 500 })
end

local function onNextButtonTap(event)
    composer.gotoScene("classification_results_scene", {
        effect = "slideLeft",
        time = 500,
        params = { classificationResult = calculateClassificationResult() }
    })
end

function scene:create(event)
    local sceneGroup = self.view

    local background = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    background:setFillColor(0.7, 0.7, 1)
    sceneGroup:insert(background)

    local title = display.newText {
        text = "Choose Metrics",
        x = display.contentCenterX,
        y = 50,
        fontSize = 18,
        font = native.systemFontBold
    }
    title:setFillColor(1)
    sceneGroup:insert(title)

    local metricOption1 = widget.newSwitch {
        id = "Euclidean",
        style = "radio",
        left = display.contentCenterX - 90,
        top = 106,
        initialSwitchState = true,
        onPress = onMetricRadioButtonTap
    }
    sceneGroup:insert(metricOption1)

    local option1Label = display.newText {
        text = "Euclidean",
        x = display.contentCenterX - 18,
        y = 120,
        fontSize = 16,
        align = "left"
    }
    sceneGroup:insert(option1Label)

    local metricOption2 = widget.newSwitch {
        id = "Manhattan",
        style = "radio",
        left = display.contentCenterX - 90,
        top = 145,
        initialSwitchState = false,
        onPress = onMetricRadioButtonTap
    }
    sceneGroup:insert(metricOption2)

    local option2Label = display.newText {
        text = "Manhattan",
        x = display.contentCenterX - 17,
        y = 160,
        fontSize = 16,
        align = "left"
    }
    sceneGroup:insert(option2Label)

    local harmonicWeightingCheckbox = widget.newSwitch {
        x = display.contentCenterX - 78,
        y = 200,
        style = "checkbox",
        id = "HarmonicWeightingCheckbox",
        onPress = onHarmonicWeightingCheckboxTap
    }
    sceneGroup:insert(harmonicWeightingCheckbox)

    local checkboxLabel = display.newText {
        text = "       Harmonic Weighting",
        x = display.contentCenterX - 0.1,
        y = 200,
        fontSize = 16,
        align = "right"
    }
    sceneGroup:insert(checkboxLabel)

    local buttonWidth = 150
    local buttonHeight = 30
    local button = display.newRoundedRect(
        sceneGroup,
        display.contentCenterX,
        display.contentHeight - 230,
        buttonWidth,
        buttonHeight,
        8
    )

    local nextButton = widget.newButton {
        label = "Next",
        x = display.contentCenterX,
        y = 250,
        width = 150,
        height = 40,
        fontSize = 16,
        onRelease = onNextButtonTap
    }
    sceneGroup:insert(nextButton)

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
