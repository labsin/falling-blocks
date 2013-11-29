import QtQuick 2.0
import Ubuntu.Components 0.1
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

    QtValues {
        id: values
        onGameOverChanged: {
            if(gameOver) {

            }
        }
    }

    Database {
        id:mainDbObj
    }

    Tabs {
        id: tabs
        Tab {
            title: i18n.tr("Settings")
            page: SettingPage {
                id: settingPage
            }
        }
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

    Component.onCompleted: {
        Game.valuesObject = values;

        gamePage.init()

        Keys.forwardTo = Game.valuesObject.gameCanvas

        Game.init();
    }
}
