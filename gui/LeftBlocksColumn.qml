import QtQuick 2.4
import Ubuntu.Components 1.0
import "../logic/game.js" as Game
import "blocksPageHelper.js" as Helper

Item {
    id: topItem
    signal init

    height: column.height + column.y

    UbuntuShape {
        anchors.fill: parent

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

        Label {
            id: nextLabel
            anchors.horizontalCenter: parent.horizontalCenter
            text: i18n.tr("Next block:")
            color: "white"
        }

        UbuntuShape {
            id: nextBlockBG
            height: values.blockSize * 4 + Helper.border * 2
            width: values.blockSize * 4 + Helper.border * 2
            color: UbuntuColors.warmGrey

            anchors.horizontalCenter: parent.horizontalCenter

            UbuntuShape {
                id: nextBlock
                width: values.blockSize * 4
                height: values.blockSize * 4
                color: Qt.lighter(gradientColor,1.45)
                gradientColor: UbuntuColors.orange
                anchors.centerIn: parent

                GridOverlay {
                    rows: 4
                    columns: 4
                    model: rows*columns
                    imgWidth: values.blockSize
                    imgheight: values.blockSize
                    anchors.centerIn: parent
                }

                PauseOverlay {
                    anchors.fill: parent
                    visible: values.paused
                }
            }
        }

        Label {
            id: storeLabel
            anchors.horizontalCenter: parent.horizontalCenter
            text: i18n.tr("Stored:")
            color: "white"
        }

        UbuntuShape {
            id: storedBlockBG
            height: values.blockSize * 4 + Helper.border * 2
            width: values.blockSize * 4 + Helper.border * 2
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

                GridOverlay {
                    rows: 4
                    columns: 4
                    model: rows*columns
                    imgWidth: values.blockSize
                    imgheight: values.blockSize
                    anchors.centerIn: parent
                }

                PauseOverlay {
                    anchors.fill: parent
                    visible: values.paused
                }
            }
        }

        Item {
            height: 0.01
            width: 0.01
        }
    }

    onInit: {
        var qmlObjComponent = Qt.createComponent("blocks/Shape.qml");
        Game.valuesObject.nextPiece = qmlObjComponent.createObject(nextBlock, {
                                                                       isNext: true
                                                                   })
        Game.valuesObject.storedPiece = qmlObjComponent.createObject(
                    storedBlock, {
                        isStored: true
                    })
        Game.valuesObject.currentPiece = qmlObjComponent.createObject(
                    gameCanvasPlain, {
                        isCurrent: true
                    })
    }
}
