import QtQuick 2.0
import Ubuntu.Components 0.1

UbuntuShape {
    color: "black"
    gradientColor: UbuntuColors.coolGrey
    opacity: 0.91
    z: 100
    Label {
        anchors.centerIn: parent
        text: i18n.tr("Paused")
        color: "white"
        fontSize: "large"
    }
}
