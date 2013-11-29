import QtQuick 2.0
import Ubuntu.Components 0.1
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

        spacing: units.gu(0.5)

        Item {
            height: units.gu(1)
            width: units.gu(1)
        }

        Label {
            id: nextLabel
            anchors.horizontalCenter: parent.horizontalCenter
            text: i18n.tr("Next block:")
            color: "white"
        }

        UbuntuShape {
            id: nextBlockBG
            height: values.blockSize * (4 + (Helper.blockInfoColmun - 4)/4)
            width: values.blockSize * (4 + (Helper.blockInfoColmun - 4)/4)
            color: UbuntuColors.warmGrey

            anchors.horizontalCenter: parent.horizontalCenter

            UbuntuShape {
                id: nextBlock
                width: values.blockSize * 4
                height: values.blockSize * 4
                color: Qt.lighter(gradientColor,1.45)
                gradientColor: UbuntuColors.orange
                anchors.centerIn: parent

                PauseOverlay {
                    anchors.fill: parent
                    visible: values.paused
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
            text: i18n.tr("Stored:")
            color: "white"
        }

        UbuntuShape {
            id: storedBlockBG
            height: values.blockSize * (4 + (Helper.blockInfoColmun - 4)/4)
            width: values.blockSize * (4 + (Helper.blockInfoColmun - 4)/4)
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

                PauseOverlay {
                    anchors.fill: parent
                    visible: values.paused
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
                        isStored: true
                    })
        Game.valuesObject.currentPiece = qmlObjComponent.createObject(
                    gameCanvasPlain, {
                        isCurrent: true
                    })
    }
}
