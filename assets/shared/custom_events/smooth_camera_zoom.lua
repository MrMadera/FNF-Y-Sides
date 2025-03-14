function onEvent(name, value1, value2, strumTime)
    local value_2 = stringSplit(value2, ",")
    doTweenZoom('zoomTween', 'game', value1, value_2[1], value_2[2]);
end