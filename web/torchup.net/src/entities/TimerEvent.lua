local class = require("./lib/middleclass/middleclass")

local TimerEvent = class('TimerEvent')

function TimerEvent:initialize(time, fn)
    self.lifetime = time
    self.timerCallback = fn
end

function TimerEvent:onLifeover()
    self.timerCallback()
end

return TimerEvent
