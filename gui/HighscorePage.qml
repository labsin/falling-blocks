import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem

Page {
    Column {
        width: parent.width
        ListItem.Header {
            text: i18n.tr("Highscores")
        }
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
                    text: mainDbObj.highScores.contents.scores[index][0]
                }

                Label {
                    id: lst
                    anchors {
                        verticalCenter: parent.verticalCenter
                        right: parent.right
                        margins: __contentsMargins
                    }
                    text: mainDbObj.highScores.contents.scores[index][1]
                }
            }
        }
    }
}
