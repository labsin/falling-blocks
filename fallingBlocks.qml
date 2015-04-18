import QtQuick 2.2
import Ubuntu.Components 1.1
import QtMultimedia 5.0
import "gui"
import "logic/game.js" as Game

MainView {
    width: units.gu(50)
    height: units.gu(80)

    headerColor: UbuntuColors.darkAubergine
    backgroundColor: UbuntuColors.midAubergine
    footerColor: UbuntuColors.warmGrey

    focus: true

    applicationName: "com.ubuntu.developer.labsin.fallingblocks"

    automaticOrientation: false
    useDeprecatedToolbar: false

    QtValues {
        id: values
        onGameOverChanged: {
            if(gameOver) {

            }
        }
    }

    Connections {
        target: mainDbObj
        onHighScoreChanged: {
            if(values.debug)
                print("HighscoreChanged"+mainDbObj.highScore.score)
            values.highscore = mainDbObj.highScore.score
        }
    }

    Database {
        id:mainDbObj
    }

    PageStack {
        id: stack
        Component.onCompleted: push(tabs)

        Tabs {
            id: tabs
            visible: false

            Tab {
                title: i18n.tr("FallingBlocks")
                page: BlocksPage {
                    id: gamePage
                }
            }

            Tab {
                title: i18n.tr("Highscores")
                page: HighscorePage {
                    id: highscorePage
                }
            }

            onCurrentPageChanged: {
                if(currentPage!=1 && values.running==true) {
                    values.paused = true;
                }
            }

        }

        SettingPage {
            id: settingPage
            title: i18n.tr("Settings")
            visible: false
        }

    }

    Connections {
        target: Qt.application
        onActiveChanged:
            if(!Qt.application.active && values.running) {
                values.paused = true
            }
    }

    Component.onCompleted: {

        Game.valuesObject = values;

        gamePage.init()

        Keys.forwardTo = values.gameCanvas

        Game.init();
    }
}
