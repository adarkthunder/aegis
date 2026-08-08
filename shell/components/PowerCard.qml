import QtQuick
import qs.theme

Rectangle {
    id: root

    signal clicked()

    implicitWidth: 34
    implicitHeight: Theme.cardHeight

    radius: Theme.cardRadius
    color: Theme.cardBackground

    Text {
        anchors.centerIn: parent

        text: ""
        color: Theme.primaryText
        font.pixelSize: Theme.normalFontSize + 1
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor

        onClicked: root.clicked()
    }
}
