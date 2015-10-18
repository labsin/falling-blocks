import QtQuick 2.4
import Ubuntu.Components 1.2
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
            text: values.started?"Stop":"Start"
            anchors.horizontalCenter: parent.horizontalCenter
            width: values.blockSize * 4 + Helper.spacing
            color: values.started?UbuntuColors.red:UbuntuColors.green
            onClicked: {
                if(values.started) {
                    Game.gameOver()
                }
                else {
                    Game.startNewGame()
                }
            }
//            Binding {
//                target: startButton
//                property: "text"
//                value: values.started?"Stop":"Start"
//            }
        }

        Button {
            id: pauseButton
            enabled: values.started
            text: values.paused?"Resume":"Pause"
            anchors.horizontalCenter: parent.horizontalCenter
            width: values.blockSize * 4 + Helper.spacing
            onClicked: {
                values.paused = !values.paused
            }
//            Binding {
//                target: pauseButton
//                property: "text"
//                value: values.paused?"Resume":"Pause"
//            }
            color: !values.started?"black":(values.paused?UbuntuColors.lightAubergine:UbuntuColors.darkAubergine)
        }

        Item {
            height: 0.01
            width: 0.01
        }
    }
}
