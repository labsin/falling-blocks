import QtQuick 2.2
import U1db 1.0 as U1db

Item {
    property QtObject highScores: highScores
    property QtObject volumes: volumes
    property QtObject settings: setttings
    property QtObject db: mainDb
    property variant highScore

    Component.onCompleted: {
        highScore = emptyScore()
    }

    U1db.Database {
        id: mainDb
        path: "blocksDb"
    }
    U1db.Document {
        id: highScores
        database: mainDb
        docId: 'highScores'
        create: true
        defaults: { "scores": [], }
        onContentsChanged: {
            var tempContents = highScores.contents
            if(typeof tempContents["scores"] != "undefined" && typeof tempContents["scores"][0] != "undefined") {
                highScore = tempContents["scores"][0]
            }
            else {
                highScore = emptyScore()
            }
        }
    }
    U1db.Document {
        id: volumes
        database: mainDb
        docId: 'volumes'
        create: true
        defaults: { "fx": 5, "music": 7 }
    }
    U1db.Document {
        id: setttings
        database: mainDb
        docId: 'settings'
        create: true
        defaults: { "dropsens": 5 }
    }

    Connections {
        target: values
        onMusicVolumeChanged: {
            var tempContents = volumes.contents
            tempContents["music"] = values.musicVolume
            volumes.contents = tempContents
        }
        onFxVolumeChanged: {
            var tempContents = volumes.contents
            tempContents["fx"] = values.fxVolume
            volumes.contents = tempContents

        }
        onSensitivityChanged: {
            var tempContents = settings.contents
            tempContents["dropsens"] = values.sensitivity
            settings.contents = tempContents
        }
    }

    function removeScore(index) {
        print("removeScore::highScrores:"+highScores.contents.scores)
        var tempContents = highScores.contents
        tempContents["scores"].splice(index,1)
        highScores.contents = tempContents
        print("removeScore::highScrores:"+highScores.contents.scores)
    }

    function addScore(name) {
        print("addScore::highScrores:"+highScores.contents.scores)
        var tempContents = highScores.contents
        var score = emptyScore()
        score["score"] = values.score
        score["name"] = name
        score["level"] = values.level
        score["lines"] = values.lines
        score["startingLevel"] = values.startingLevel
        tempContents["scores"].push(score)
        tempContents["scores"].sort(function(a,b){return b.score-a.score});
        highScores.contents = tempContents
    }

    function emptyScore() {
        return {score: 0, name: "", level: 0, lines: 0, startingLevel: 0}
    }
}
