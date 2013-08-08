import QtQuick 2.0
import "gui/blocks"


QtObject {

    property double blockSize
    property bool initiated: false
    property bool running: !pauzed && started && !gameOver && !waiting
    property bool pauzed: false
    property bool waiting: false
    property bool started: false
    property bool gameOver: false
    property int score: 0
    property int lines: 0
    property int level: 0
    property int deltaTime: 1000
    property int comboScore: 0

    property int startingLevel: 1
    property int sencitivity: 5

    property Item gameCanvas

    property Shape currentPiece: Shape
    property Shape nextPiece: Shape
    property Shape storedPiece: Shape

    signal run(bool running)
    signal init()

    onRunningChanged: {
        print("QtValues::onRunningChanged():"+running)
        if(running) {

        }
        run(running)
    }

    onPauzedChanged: {
        print("QtValues::onPauzedChanged():"+pauzed)
        if(pauzed) {

        }
    }

    onWaitingChanged: {
        print("QtValues::onWaitingChanged():"+waiting)
        if(waiting) {

        }
    }

    onStartedChanged: {
        print("QtValues::onStartedChanged():"+started)
        if(started) {
            gameOver = false
        }
    }

    onGameOverChanged: {
        print("QtValues::onGameOverChanged():"+gameOver)
        if(gameOver) {
            pauzed = false;
            started = false;
        }
    }

    onInit: {
        pauzed = false
        waiting = false
        started = false
        gameOver = false
        score = 0
        lines = 0
        level = 0
        deltaTime = 1000
        initiated = true
    }
}
