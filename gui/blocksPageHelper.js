// Some values
// # columns is 10
var maxColumn = 10
// # rows is 20
var maxRow = 20
// # rows of the blockInfo
var blockInfoColmun = 5

var maxIndex = maxColumn * maxRow

var down = new Array

function calcBlockSize() {
    blocksPage.blockSize = Math.min(
                (gameRow.width - gameContainer.anchors.margins * 2
                 - gameCanvasPlain.anchors.margins * 2) / (maxColumn + blockInfoColmun),
                (gameContainer.height - gameCanvasPlain.anchors.margins * 2) / maxRow)
    print(blockSize)
}

function keyPressed(key) {
    if(Game.debug)
        print("blocksPageHelper::keyPressed"+key)
    if(!isKnownKey(key))
        return false
    if (down.indexOf(key) == -1) {
        down.push(key)
        if(!keyTimer.running)
            keyTimer.start()
    }
    return true
}

function keyReleased(key) {
    if(Game.debug)
        print("blocksPageHelper::keyReleased"+key)
    if(!isKnownKey(key))
        return false
    var index = down.indexOf(key)
    if (index != -1) {
        down.splice(index, 1)
    }
    if(down.length==0)
        keyTimer.stop()
    return true
}

function handelKey(key) {
    if(Game.debug)
        print("blocksPageHelper::handelKey"+key)
    if (key == Qt.Key_Right) {
        Game.moveX(1)
    } else if (key == Qt.Key_Left) {
        Game.moveX(-1)
    } else if (key == Qt.Key_Down) {
        Game.moveY(1)
    } else if (key == Qt.Key_Up) {
        Game.rotateCW()
    } else if (key == Qt.Key_Space) {
        Game.hardDrop()
    } else if (key == Qt.Key_F) {
        Game.storeCurrent()
    }
}

function isKnownKey(key) {
    if (key == Qt.Key_Right) {
        return true;
    } else if (key == Qt.Key_Left) {
        return true;
    } else if (key == Qt.Key_Down) {
        return true;
    } else if (key == Qt.Key_Up) {
        return true;
    } else if (key == Qt.Key_Space) {
        return true;
    } else if (key == Qt.Key_F) {
        return true;
    }
    return false;
}

function keyRepeat() {
    if(Game.debug)
        print("blocksPageHelper::keyRepeat"+down)
    for(var iii=0;iii<down.length;iii++) {
        handelKey(down[iii])
    }
}

function stopRunning() {
    if(Game.debug)
        print("blocksPageHelper::stopRunning")
    down = new Array
    keyTimer.stop()
}
