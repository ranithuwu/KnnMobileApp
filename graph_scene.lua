local composer = require("composer")

local scene = composer.newScene()

local function readCSV(filename)
    local coordinates = {}

    local path = system.pathForFile(filename, system.ResourceDirectory)

    local file, errorString = io.open(path, "r")

    if not file then
        print("File error: " .. errorString)
    else
        print("File open: ")
        for line in file:lines() do
            local coordinate_x, coordinate_y, coordinate_name = line:match("(%d+),(%d+),(%a+)")
            if coordinate_x and coordinate_y and coordinate_name then
                coordinate_x = math.min(math.max(0, tonumber(coordinate_x)), 10)
                coordinate_y = math.min(math.max(0, tonumber(coordinate_y)), 10)
                coordinates[#coordinates+1] = { coordinate_name = coordinate_name, coordinate_x = tonumber(coordinate_x), coordinate_y = tonumber(coordinate_y) }
            else
                print("Error parsing line:", line)
            end
        end
        io.close(file)
    end

    return coordinates
end

local function calculateDistance(x1, y1, x2, y2)
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end

local function plotGraph(coordinates, testPoint)
    local graphGroup = display.newGroup()

    local screenWidth = display.contentWidth
    local screenHeight = display.contentHeight
    local graphWidth = screenWidth - 130  
    local graphHeight = screenHeight - 100  
    local marginLeft = 65   
    local marginTop = 25    

    local scaleX, scaleY
    if #coordinates > 0 then
        scaleX = graphWidth / 10
        scaleY = graphHeight / 10
    else
        print("No coordinates found, cannot plot graph.")
        return
    end

    local xAxis = display.newLine(graphGroup, marginLeft, marginTop + graphHeight, marginLeft + graphWidth, marginTop + graphHeight)
    local yAxis = display.newLine(graphGroup, marginLeft, marginTop, marginLeft, marginTop + graphHeight)

    for i = 1, 9 do
        local x = marginLeft + i * scaleX
        local y = marginTop + i * scaleY

        local xGridLine = display.newLine(graphGroup, x, marginTop, x, marginTop + graphHeight)
        xGridLine:setStrokeColor(0.5)
        xGridLine.strokeWidth = 2

        local yGridLine = display.newLine(graphGroup, marginLeft, y, marginLeft + graphWidth, y)
        yGridLine:setStrokeColor(0.5) 
        yGridLine.strokeWidth = 2
    end

    for i = 0, 10, 5 do
        local tickX = marginLeft + i * scaleX
        local tickY = marginTop + (10 - i) * scaleY

        local tick = display.newLine(graphGroup, tickX, marginTop + graphHeight - 5, tickX, marginTop + graphHeight + 5)
        tick:setStrokeColor(0)
        tick.strokeWidth = 2

        local labelX = display.newText(graphGroup, tostring(i), tickX, marginTop + graphHeight + 10, native.systemFont, 10)
        labelX.anchorY = 0
        labelX:setFillColor(0)

        local labelY = display.newText(graphGroup, tostring(i), marginLeft - 10, tickY, native.systemFont, 10)
        labelY.anchorX = 1
        labelY:setFillColor(0)
    end

    local distances = {}
    for _, coordinate in pairs(coordinates) do
        local distance = calculateDistance(coordinate.coordinate_x, coordinate.coordinate_y, testPoint[1], testPoint[2])
        table.insert(distances, {distance = distance, class = coordinate.coordinate_name})
    end

    table.sort(distances, function(a, b) return a.distance < b.distance end)

    local nearestNeighbors = {}
    for i = 1, math.min(3, #distances) do
        table.insert(nearestNeighbors, distances[i].class)
    end

    local classCounts = {a = 0, b = 0, c = 0}
    for _, class in ipairs(nearestNeighbors) do
        classCounts[class] = classCounts[class] + 1
    end

    local majorityClass
    local maxCount = 0
    for class, count in pairs(classCounts) do
        if count > maxCount then
            majorityClass = class
            maxCount = count
        end
    end

    local color
    if majorityClass == "a" then
        color = "(Blue)"
    elseif majorityClass == "b" then
        color = "(Red)"
    else
        color = "(Yellow)"
    end

 

    for _, coordinate in pairs(coordinates) do
        local classColor
        if coordinate.coordinate_name == "a" then
            classColor = {0, 0, 1} 
        elseif coordinate.coordinate_name == "b" then
            classColor = {1, 0, 0} 
        else
            classColor = {1, 1, 2} 
        end
        local circle = display.newCircle(graphGroup, marginLeft + coordinate.coordinate_x * scaleX, marginTop + (10 - coordinate.coordinate_y) * scaleY, 5)
        circle:setFillColor(unpack(classColor))
    end

    scene.view:insert(graphGroup)
end

function scene:create(event)
    local sceneGroup = self.view

    local background = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    background:setFillColor(0.7, 0.7, 1) 
    sceneGroup:insert(background)

    local coordinates = readCSV("knn.csv") 

    if #coordinates == 0 then
        print("The table is empty, there is no valid data in the file.")
    else
        for _, coordinate in pairs(coordinates) do
            print(coordinate.coordinate_name, coordinate.coordinate_x, coordinate.coordinate_y)
        end
    end

    local testPoint = {6, 5}  -- Test point [6,5]

    plotGraph(coordinates, testPoint)

    local buttonWidth = 150
    local buttonHeight = 30
    local button = display.newRoundedRect(
        sceneGroup,
        display.contentCenterX,
        display.contentHeight - 30,
        buttonWidth,
        buttonHeight,
        8
    )

    -- Create a button to choose a point
    local choosePointButton = display.newText(sceneGroup, "Choose a Point", display.contentCenterX, display.contentHeight - 30, native.systemFont, 16)
    choosePointButton:setFillColor(0)
    
    local function onChoosePointButtonTap(event)
        composer.gotoScene("choose_point_scene", {effect = "slideLeft", time = 500})
    end
    
    -- Inside the scene:create function
    choosePointButton:addEventListener("tap", onChoosePointButtonTap)
end -- Close scene:create function

scene:addEventListener("create", scene)

return scene
