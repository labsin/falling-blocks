import QtQuick 2.0
import U1db 1.0 as U1db

Item {
    property QtObject highScores: highScores
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
