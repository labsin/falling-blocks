import QtQuick 2.0
import "../logic/game.js" as Game

MouseArea {
    property int clickedX
    property int clickedY
    property variant clickedTime
    property int blocksPerMsHardDrop: 10 * values.sensitivity

    property int lastX
    property int lastY

    anchors.fill: parent

    id: mouseArea

    onPressed: {
        clickedX = mouse.x
        clickedY = mouse.y
        lastX = clickedX
        lastY = clickedY
        clickedTime = Date.now()
    }
    onReleased: {
        if(Game.debug)
            print("Mouse::released: " + Date.now() + "/" + clickedTime)
        if((mouse.y - clickedY)>blockSize*2 && ((mouse.y - lastY)/blockSize/(Date.now()-clickedTime)) > 1/blocksPerMsHardDrop) {
            if(Game.debug)
                print("Mouse::released:hardDrop")
            Game.hardDrop();
        }
        else if((Date.now()-clickedTime)<150 && (mouse.y - clickedY) < blockSize &&  (mouse.x - clickedX) < blockSize) {
            if(Game.debug)
                print("Mouse::released:rotateCW")
            Game.rotateCW();
        }
        clickedTime = 0
    }

    onPositionChanged: {
        if(Math.abs(mouse.x - lastX)>blockSize && ((mouse.y - lastY)/blockSize/(Date.now()-clickedTime)) < 1/blocksPerMsHardDrop) {
            if(Game.debug)
                print("Mouse::onPositionChanged:moveX:x:" + mouse.x + "/y:" + mouse.y)
            Game.moveX(Math.round((mouse.x - lastX)/blockSize))
            lastX = mouse.x
        }
        if((mouse.y - lastY)>blockSize && ((mouse.y - lastY)/blockSize/(Date.now()-clickedTime)) < 1/blocksPerMsHardDrop) {
            if(Game.debug)
                print("Mouse::onPositionChanged:softDrop:x:" + mouse.x + "/y:" + mouse.y)
            Game.softDrop(Math.round((mouse.y - lastY)/blockSize))
            lastY = mouse.y
        }
    }
}
