import QtQuick 2.4
import Ubuntu.Components 1.2
import Ubuntu.Components.ListItems 1.0 as ListItem

Page {
    Column {
        width: parent.width
        Repeater {
            model: mainDbObj.highScores.contents.scores.length
            ListItem.Empty {
                removable: true
                onItemRemoved: {
                    mainDbObj.removeScore(index)
                }

                Label {
                    id: frst
                    anchors {
                        verticalCenter: parent.verticalCenter
                        left: parent.left
                        margins: __contentsMargins
                    }
                    text: index+1 + ":"
                }

                Label {
                    id: scnd
                    anchors {
                        verticalCenter: parent.verticalCenter
                        left: frst.right
                        margins: __contentsMargins
                    }
                    text: mainDbObj.highScores.contents.scores[index].name
                }

                Label {
                    id: lst
                    anchors {
                        verticalCenter: parent.verticalCenter
                        right: parent.right
                        margins: __contentsMargins
                    }
                    text: mainDbObj.highScores.contents.scores[index].score
                }
            }
        }
    }
}
