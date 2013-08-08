import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.Popups 0.1
import "../logic/game.js" as Game

Dialog {
    id: dialogue
    title: "Game Over"
    text: "You score is: "+values.score+"\nWhat's next?"
    Button {
        text: "nothing"
        onClicked: PopupUtils.close(dialogue)
        gradient: UbuntuColors.greyGradient
    }
    Button {
        text: "Settings"
        onClicked: {
            tabs.selectedTabIndex=0
            PopupUtils.close(dialogue)
        }
    }
    Button {
        text: "Restart"
        onClicked: {
            Game.startNewGame()
            PopupUtils.close(dialogue)
        }
    }
}
