import QtQuick
import qs.theme

Rectangle {
    implicitWidth: label.implicitWidth + Theme.horizontalPadding * 2
    implicitHeight: Theme.cardHeight

    radius: Theme.cardRadius
    color: Theme.cardBackground

    Text {
        id: label
        anchors.centerIn: parent

        text: "Aegis"
        color: Theme.primaryText
        font.bold: true
        font.pixelSize: Theme.titleFontSize
    }
}
