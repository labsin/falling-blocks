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

        spacing: units.gu(0.5)

        Item {
            height: units.gu(1)
            width: units.gu(1)
        }

        Label {
            id: nextLabel
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Next block:"
            color: "white"
        }

        UbuntuShape {
            id: nextBlockBG
            height: values.blockSize * 4 + units.gu(1)
            width: values.blockSize * 4 + units.gu(1)
            color: UbuntuColors.warmGrey

            anchors.horizontalCenter: parent.horizontalCenter

            UbuntuShape {
                id: nextBlock
                width: values.blockSize * 4
                height: values.blockSize * 4
                color: Qt.lighter(gradientColor,1.45)
                gradientColor: UbuntuColors.orange
                anchors.centerIn: parent

                PauzeOverlay {
                    anchors.fill: parent
                    visible: values.pauzed
                }
            }

            GridOverlay {
                rows: 4
                columns: 4
                model: rows*columns
                imgWidth: values.blockSize
                imgheight: values.blockSize
                anchors.centerIn: parent
            }
        }

        Label {
            id: storeLabel
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Storred:"
            color: "white"
        }

        UbuntuShape {
            id: storedBlockBG
            height: values.blockSize * 4 + units.gu(1)
            width: values.blockSize * 4 + units.gu(1)
            color: UbuntuColors.warmGrey

            anchors.horizontalCenter: parent.horizontalCenter

            UbuntuShape {
                id: storedBlock
                width: values.blockSize * 4
                height: values.blockSize * 4
                color: Qt.lighter(gradientColor,1.45)
                gradientColor: UbuntuColors.orange
                anchors.centerIn: parent

                MouseArea {
                    enabled: running
                    anchors.fill: parent
                    onClicked: {
                        Game.storeCurrent()
                    }
                }

                PauzeOverlay {
                    anchors.fill: parent
                    visible: values.pauzed
                }

                GridOverlay {
                    rows: 4
                    columns: 4
                    model: rows*columns
                    imgWidth: values.blockSize
                    imgheight: values.blockSize
                    anchors.centerIn: parent
                }
            }
        }

        Item {
            height: units.gu(1)
            width: units.gu(1)
        }
    }

    onInit: {
        var qmlObjComponent = Qt.createComponent("blocks/Shape.qml");
        Game.valuesObject.nextPiece = qmlObjComponent.createObject(nextBlock, {
                                                                       isNext: true
                                                                   })
        Game.valuesObject.storedPiece = qmlObjComponent.createObject(
                    storedBlock, {
                        isStorred: true
                    })
        Game.valuesObject.currentPiece = qmlObjComponent.createObject(
                    gameCanvasPlain, {
                        isCurrent: true
                    })
    }
}
