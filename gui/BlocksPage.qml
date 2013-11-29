import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.Popups 0.1
import "blocks"
import "../logic/game.js" as Game
import "blocksPageHelper.js" as Helper

Page {
    id: blocksPage

    property real blockSize: units.gu(3)
    property bool running

    signal sizeChanged
    signal init

    Item {
        id: gameRow
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: scoreBlock.top

        LeftBlocksColumn {
            id: blockInfo
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.margins: blockSize/4
            width: blockSize * Helper.blockInfoColmun
        }

        LeftButtonsColumn {
            id: buttonColumn
            width: blockInfo.width

            anchors.top: blockInfo.bottom
            anchors.left: parent.left
            anchors.right: gameContainer.left
            anchors.margins: blockSize/4
            anchors.topMargin: blockSize/2
        }

        Item {
            id: gameContainer
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: blockInfo.right
            anchors.margins: units.gu(1)
            Item {
                id: gameCanvas
                width: blockSize*Helper.maxColumn+gameCanvasPlain.anchors.margins*2
                height: blockSize*Helper.maxRow+gameCanvasPlain.anchors.margins*2

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom

                UbuntuShape {
                    id: gameCanvasBorder
                    anchors.fill: parent
                    color: UbuntuColors.warmGrey
                }
                UbuntuShape {
                    id: gameCanvasPlain
                    anchors.fill: parent
                    anchors.margins: units.gu(0.5)
                    color: Qt.lighter(gradientColor,1.45)
                    gradientColor: UbuntuColors.orange
                    PauseOverlay {
                        id: overlay
                        anchors.fill: parent
                        visible: values.paused
                    }

                    Mouse {
                        enabled: running
                        id: currentPieceMouse
                    }

                    GridOverlay {
                        anchors.fill: parent
                        rows: Helper.maxRow
                        columns: Helper.maxColumn
                        model: rows*columns
                        imgWidth: blockSize
                        imgheight: blockSize
                    }

                    Keys.enabled: running

                    Keys.onReleased: {
                        if(Game.debug)
                            print("BlocksPage::Keys.onReleased:"+event.key)
                        if(Helper.keyReleased(event.key))
                            event.accepted = true
                    }

                    Keys.onPressed: {
                        if(Game.debug)
                            print("BlocksPage::Keys.onPressed:"+event.key)
                        if(Helper.keyPressed(event.key))
                            event.accepted = true
                    }

                    Timer {
                        id: keyTimer
                        interval: 150
                        repeat: true
                        triggeredOnStart: true
                        onTriggered: {
                            Helper.keyRepeat()
                        }
                    }
                }
            }
        }
    }

    ScoreBlock {
        id: scoreBlock
        anchors.bottom: parent.bottom

        width: parent.width
        height: units.gu(5)
    }

    tools: ToolbarItems {
        // reference to an action:
        ToolbarButton {
            action: actionNew
        }
    }
    onWidthChanged: sizeChanged()
    onHeightChanged: sizeChanged()

    onSizeChanged: {
        if(Game.debug)
            print("BlocksPage::sizeChanged")
        if(Game.valuesObject && Game.valuesObject.initiated)
            Helper.calcBlockSize()
    }

    states: [
        State {
            name: "GameOver"
            when: values.gameOver
            StateChangeScript {
                script: {
                    if(values.gameOver) {
                        delay.start()
                    }
                }
            }
        }
    ]
    Timer {
        id: delay
        interval: 2000
        onTriggered: {
            if(values.gameOver)
                PopupUtils.open(Qt.resolvedUrl("GameOverDialog.qml"))
        }
    }

    Action {
        id: actionNew
        text: "New Game"
        onTriggered: Game.startNewGame()
    }

    onRunningChanged: {
        if(!running) {
            Helper.stopRunning()
        }
    }

    onInit: {
        if(Game.debug)
            print("BlocksPage::onInit")
        Helper.calcBlockSize()
        Game.valuesObject.gameCanvas = gameCanvasPlain;
        blockInfo.init()
        blocksPage.running = Qt.binding(function() {return Game.valuesObject.running})
        Game.valuesObject.blockSize = Qt.binding(function () {return blocksPage.blockSize})
    }
}
