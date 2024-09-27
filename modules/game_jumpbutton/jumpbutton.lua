local window = nil
local jumpButton = nil
local moveEvent = nil
local contentSize = nil

local function randomY()
    local lastY = jumpButton:getMarginBottom()
    local y = 0

    repeat
        y = 100 * (math.random(1, 3) - 1)
    until lastY < contentSize.y and y ~= lastY

    jumpButton:setMarginBottom(y)
end

local function moveButton()
    local moveTo = jumpButton:getMarginRight() + 10
    if moveTo > contentSize.x then
        jump()
        return
    end

    jumpButton:setMarginRight(moveTo)
end

function jump()
    jumpButton:setMarginRight(0)
    randomY()
end

function init()
    window = g_ui.loadUI('jumpbutton', g_ui.getRootWidget())
    jumpButton = window:getChildById('jumpButton')
    moveEvent = cycleEvent(moveButton, 100)

    contentSize = {
        x = window:getWidth() - window:getPaddingLeft() - window:getPaddingRight() - jumpButton:getWidth(),
        y = window:getWidth() - window:getPaddingTop() - window:getPaddingBottom() - jumpButton:getHeight()
    }
end

function terminate()
    window:destroy()
    removeEvent(moveEvent)

    window = nil
    jumpButton = nil
end
