import QtQuick 2.0
import Ubuntu.Components 0.1
import "../logic/game.js" as Game

Item {
    signal init
    height: column.height + column.y

    UbuntuShape {
        anchors.fill: column
        anchors.margins: units.gu(1)

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
