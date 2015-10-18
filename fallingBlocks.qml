import QtQuick 2.4
import Ubuntu.Components 1.2
import QtMultimedia 5.4
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

    QtValues {
        id: values
        onGameOverChanged: {
            if(gameOver) {

            }
        }
    }

    property var musicFiles: ["01.mp3", "02.mp3", "03.mp3"]

    Audio {
        id: soundtrack
        autoPlay: true
        property int current: Math.floor((Math.random() * musicFiles.length) + 1);
        onCurrentChanged: if(current> musicFiles.length) current = 1
        source: "music/"+musicFiles[current-1]
        onStatusChanged: {
            if(status == Audio.EndOfMedia) {
                current+=1
            }
        }
        volume: values.musicVolume/10
    }
    Item {
        id: fx

        property var clear4: SoundEffect {
            id: clear4Fx
            source: "fx/clear.wav"
            volume: values.fxVolume/10
        }

        property var clear1: SoundEffect {
            id: clear1Fx
            source: "fx/clear1.wav"
            volume: values.fxVolume/10
        }

        property var alert: SoundEffect {
            id: alertFx
            source: "fx/alert.wav"
            volume: values.fxVolume/10
        }

        property var fastdrop: SoundEffect {
            id: fastDropFx
            source: "fx/fastdrop.wav"
            volume: values.fxVolume/10
        }

        property var laser: SoundEffect {
            id: laserFx
            source: "fx/laser.wav"
            volume: values.fxVolume/10
        }

        property var powerup: SoundEffect {
            id: powerUpFx
            source: "fx/powerup.wav"
            volume: values.fxVolume/10
        }

        property var shutdown: SoundEffect {
            id: shutdownFx
            source: "fx/shutdown.wav"
            volume: values.fxVolume/10
        }

        property var turn: SoundEffect {
            id: turnFx
            source: "fx/turn.wav"
            volume: values.fxVolume/10
        }

        property var blip: SoundEffect {
            id: turn2Fx
            source: "fx/blip.wav"
            volume: values.fxVolume/10
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
        onCurrentPageChanged: {
            if(currentPage!=1 && values.running==true) {
                values.paused = true;
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
        Game.fx = fx

        gamePage.init()

        Keys.forwardTo = values.gameCanvas

        Game.init();
    }
}
