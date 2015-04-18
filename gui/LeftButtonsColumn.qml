import QtQuick 2.2
import Ubuntu.Components 1.1
import "../logic/game.js" as Game
import "blocksPageHelper.js" as Helper

Item {
    signal init
    height: column.height + column.y

    UbuntuShape {
        anchors.fill: column

        color: UbuntuColors.coolGrey
        gradientColor: Qt.lighter(color,2)
        opacity: 0.9
    }

    Column {
        id: column
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        spacing: Helper.spacing

        Item {
            height: 0.01
            width: 0.01
        }

        Button {
            id: startButton
            text: "Start"
            anchors.horizontalCenter: parent.horizontalCenter
            width: values.blockSize * 4 + Helper.spacing
            onClicked: {
                if(values.started) {
                    Game.gameOver()
                }
                else {
                    Game.startNewGame()
                }
            }
            Binding {
                target: startButton
                property: "text"
                value: values.started?"Stop":"Start"
            }
        }

        Button {
            id: pauseButton
            enabled: values.started
            text: "Pause"
            anchors.horizontalCenter: parent.horizontalCenter
            width: values.blockSize * 4 + Helper.spacing
            onClicked: {
                values.paused = !values.paused
            }
            Binding {
                target: pauseButton
                property: "text"
                value: values.paused?"Resume":"Pause"
            }
        }

        Item {
            height: 0.01
            width: 0.01
        }
    }
}
