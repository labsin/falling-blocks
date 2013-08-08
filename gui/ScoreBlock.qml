import QtQuick 2.0
import Ubuntu.Components 0.1

Item {
    UbuntuShape {
        anchors.fill: scoreBlock
        color: Qt.tint(UbuntuColors.darkAubergine,UbuntuColors.coolGrey)
        gradientColor: UbuntuColors.darkAubergine
        opacity: 0.9
    }

    Row {
        id: scoreBlock
        spacing: units.gu(2)
        width: parent.width
        height: parent.height

        Item {
            width: units.gu(2)
            height: width
        }

        Label {
            id: scoreTextLabel
            text: "Score:"
            color: "white"

            anchors.verticalCenter: parent.verticalCenter
        }

        Label {
            id: scoreLabel

            text: values.score
            color: "white"

            anchors.verticalCenter: parent.verticalCenter
        }

        Label {
            id: linesTextLabel
            text: "Lines:"
            color: "white"

            anchors.verticalCenter: parent.verticalCenter
        }

        Label {
            id: linesLabel

            text: values.lines
            color: "white"

            anchors.verticalCenter: parent.verticalCenter
        }

        Label {
            id: levelTextLabel
            text: "Level:"
            color: "white"

            anchors.verticalCenter: parent.verticalCenter
        }

        Label {
            id: levelLabel

            text: values.level
            color: "white"

            anchors.verticalCenter: parent.verticalCenter
        }

        Item {
            width: units.gu(2)
            height: width
        }
    }
}
