 mon = peripheral.wrap("monitor_0")
batt = peripheral.wrap("powah:energy_cell_1")
monX, monY = mon.getSize()

function checkFE()
    -- god has cursed me for my hubris --
    maxFE = batt.getEnergyCapacity()
    currFE = batt.getEnergy()
    perFE = 0 + math.floor((currFE / maxFE) * 100)
end

function startMonitor()
    mon.setBackgroundColor(colors.black)
    mon.clear()
    mon.setCursorPos(1,1)
end
    
function printCenter(text, line, backColor, txtColor)
    mon.setBackgroundColor(backColor)
    mon.setTextColor(txtColor)
    length = string.len(text)
    dif = math.floor(monX - length)
    finalX =  math.ceil(dif / 2)
    mon.setCursorPos(finalX, line)
    mon.write(text)
end

function printBar(per, line, backColor, frontColor)
    
    backLength = 13
    printCenter(string.rep(" ", backLength), line, backColor, backColor)
   
    barLength = math.floor(per * backLength / 100  )
    barX = math.ceil ((monX-backLength) / 2)
    bar = string.rep(" ", barLength)
    mon.setCursorPos(barX, line)
    mon.setBackgroundColor(frontColor)
    mon.write(bar)       
end

function checkPer(per)
    if per > 90 then redstone.setOutput("top", true) end
    if per < 11 then redstone.setOutput("top", false) end
end

while true do  
checkFE()
checkPer(perFE) 
startMonitor()

printCenter((" Power: "..perFE.." % "), 1, colors.lightBlue, colors.gray ) 
printBar(perFE, 3, colors.blue, colors.red) 
end
