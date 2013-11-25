import QtQuick 2.0
import Ubuntu.Components 0.1
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

        spacing: units.gu(2)

        Item {
            height: units.gu(1)
            width: units.gu(1)
        }

        Button {
            id: startButton
            text: "Start"
            anchors.horizontalCenter: parent.horizontalCenter
            width: values.blockSize * (4 + (Helper.blockInfoColmun - 4)/4)
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
            id: pauzeButton
            enabled: values.started
            text: "Pauze"
            anchors.horizontalCenter: parent.horizontalCenter
            width: values.blockSize * (4 + (Helper.blockInfoColmun - 4)/4)
            onClicked: {
                values.pauzed = !values.pauzed
            }
            Binding {
                target: pauzeButton
                property: "text"
                value: values.pauzed?"Resume":"Pauze"
            }
        }

        Item {
            height: units.gu(1)
            width: units.gu(1)
        }
    }
}
