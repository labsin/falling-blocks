import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.Popups 0.1
import "../logic/game.js" as Game

Dialog {
    id: dialogue
    title: i18n.tr("Game Over")
    text: i18n.tr("You score is:")+" "+values.score+"\n"+i18n.tr("What's next?")
    Button {
        text: i18n.tr("nothing")
        onClicked: PopupUtils.close(dialogue)
        gradient: UbuntuColors.greyGradient
    }
    Button {
        text: i18n.tr("Settings")
        onClicked: {
            tabs.selectedTabIndex=0
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
