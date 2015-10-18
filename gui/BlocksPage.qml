import QtQuick 2.4
import Ubuntu.Components 1.2
import Ubuntu.Components.Popups 1.0
import "blocks"
import "../logic/game.js" as Game
import "blocksPageHelper.js" as Helper

Page {
    id: blocksPage

    property real blockSize: units.gu(3)
    property bool running

    signal sizeChanged
    signal init

    onWidthChanged: sizeChanged()
    onHeightChanged: sizeChanged()

    onSizeChanged: {
        if(values.debug)
            print("BlocksPage::sizeChanged")
        if(Game.valuesObject && Game.valuesObject.initiated)
            Helper.calcBlockSize()
    }

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
            anchors.margins: Helper.spacing
            width: blockSize * Helper.blockInfoColmun + 2 * Helper.spacing + 2 * Helper.border
        }

        LeftButtonsColumn {
            id: buttonColumn
            width: blockInfo.width

            anchors.top: blockInfo.bottom
            anchors.left: parent.left
            anchors.margins: Helper.spacing
        }

        Item {
            id: gameContainer
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: blockInfo.right
            anchors.margins: Helper.spacing
            Item {
                id: gameCanvas

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                width: blockSize*Helper.maxColumn+Helper.border*2
                height: blockSize*Helper.maxRow+Helper.border*2

                UbuntuShape {
                    id: gameCanvasBorder
                    anchors.fill: gameCanvasPlain
                    anchors.margins: -Helper.border
                    color: UbuntuColors.warmGrey
                }
                UbuntuShape {
                    id: gameCanvasPlain
                    anchors.centerIn: parent
                    width: blockSize*Helper.maxColumn
                    height: blockSize*Helper.maxRow
                    color: Qt.lighter(gradientColor,1.45)
                    gradientColor: UbuntuColors.orange
                    PauseOverlay {
                        id: overlay
                        anchors.fill: parent
                        visible: values.paused
                    }

                    MouseObj {
                        enabled: blocksPage.running
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
                        if(values.debug)
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

    onRunningChanged: {
        if(!running) {
            Helper.stopRunning()
        }
    }

    onInit: {
        if(values.debug)
            print("BlocksPage::onInit")
        Helper.calcBlockSize()
        Game.valuesObject.gameCanvas = gameCanvasPlain;
        blockInfo.init()
        blocksPage.running = Qt.binding(function() {return Game.valuesObject.running})
        Game.valuesObject.blockSize = Qt.binding(function () {return blocksPage.blockSize})
    }

    head.actions: [
        Action {
            iconName: "settings"
            text: i18n.tr("Settings")
            onTriggered: {
                // Launch settings
                pageStack.push(settingPage)
            }
        }
    ]
}
