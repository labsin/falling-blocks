import QtQuick 2.4
import Ubuntu.Components 1.2
import Ubuntu.Components.Popups 1.0
import Ubuntu.Components.ListItems 1.0 as ListItem
import "../logic/game.js" as Game

Dialog {
    id: dialogue
    title: values.nowHighscore?i18n.tr("New Highscore"):i18n.tr("Game Over")
    text: i18n.tr("You score is:")
          + " " + values.score+"\n"
          + i18n.tr("What's next?")

    Button {
        id: closeButton
        text: i18n.tr("Do Nothing")
        onClicked: PopupUtils.close(dialogue)
        gradient: UbuntuColors.greyGradient
    }

    Button {
        id: saveButton
        text: i18n.tr("Save Score")

        Behavior on height {
            UbuntuNumberAnimation {  }
        }
        signal expand
        signal colapse

        clip: true

        onExpand: {
            height = nameInput.implicitHeight
        }

        onColapse: {
            height = 0
        }

        onClicked: {
            nameInput.expand()
            colapse()
            closeButton.text = i18n.tr("Close")
        }
    }

    ListItem.Standard {
        id: nameInput
        height: 0
        Behavior on height {
            UbuntuNumberAnimation {  }
        }
        signal expand
        signal colapse

        onExpand: {
            height = nameInput.implicitHeight
        }

        onColapse: {
            height = 0
        }

        clip: true
        showDivider: false
        control: TextField {
            width: units.gu(19)
            placeholderText: i18n.tr("Name")
        }
        progression: true
        onClicked: {
            if(control.text) {
                mainDbObj.addScore(control.text)
                nameInput.colapse()
                hightscoreButton.expand()
            }
        }
    }

    Button {
        id: hightscoreButton
        text: i18n.tr("Show Highscores")

        Behavior on height {
            UbuntuNumberAnimation {  }
        }
        signal expand
        signal colapse

        height: 0

        clip: true

        onExpand: {
            height = nameInput.implicitHeight
        }

        onColapse: {
            height = 0
        }

        onClicked: {
            tabs.selectedTabIndex = 1
            PopupUtils.close(dialogue)
        }
    }

    Button {
        text: i18n.tr("Restart")
        onClicked: {
            Game.startNewGame()
            PopupUtils.close(dialogue)
        }
    }
}
