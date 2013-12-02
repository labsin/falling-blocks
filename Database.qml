import QtQuick 2.0
import U1db 1.0 as U1db

Item {
    property QtObject highScores: highScores
    property QtObject db: mainDb
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
        Component.onCompleted: {
            print("highScrores::"+highScores.contents.scores)
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
        tempContents["scores"].push({score: values.score, name: name, level: values.level, lines: values.lines, startingLevel: values.startingLevel})
        highScores.contents = tempContents
    }
}
