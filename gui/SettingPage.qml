import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem
import "../logic/game.js" as Game

Page {
    signal init
    Column {
        width: parent.width
        ListItem.Header {
            text: i18n.tr("New game settings")
        }
        ListItem.Caption {
            text: i18n.tr("Begin level:")
        }
        TextField {
            id: startingLevel
            enabled: !values.started
            placeholderText:  "1-15"
            width: parent.width
            validator: IntValidator{bottom: 1; top: 15;}
        }
        Binding {
            target: values
            property: "startingLevel"
            value: parseInt(startingLevel.text)?parseInt(startingLevel.text):1
        }
        ListItem.Caption {
            text: i18n.tr("Drop sencitivity:")
        }
        Slider {
            id: sencitivity
            width: parent.width
            live: false
            value: 5
            minimumValue: 1
            maximumValue: 9
        }
        Binding {
            target: values
            property: "sencitivity"
            value: sencitivity.value
        }
    }
}
