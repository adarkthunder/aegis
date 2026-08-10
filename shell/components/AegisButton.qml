import QtQuick
import Quickshell
import Quickshell.Io
import qs.theme

Rectangle {
    implicitWidth: label.implicitWidth + Theme.horizontalPadding * 2
    implicitHeight: Theme.cardHeight

    radius: Theme.cardRadius
    color: Theme.cardBackground

    Process {
        id: rofiProcess
        command: ["rofi", "-show", "drun"]
    }

    Text {
        id: label
        anchors.centerIn: parent

        text: "Aegis"
        color: Theme.primaryText
        font.bold: true
        font.pixelSize: Theme.titleFontSize
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor

        onClicked: {
            rofiProcess.startDetached()
        }
    }
}
