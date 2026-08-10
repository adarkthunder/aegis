import QtQuick
import Quickshell

import qs.theme

Rectangle {
    id: root

    signal clicked()

    implicitHeight: Theme.cardHeight
    implicitWidth: row.implicitWidth + 24

    radius: Theme.cardRadius
    color: Theme.cardBackground

    Row {
        id: row

        anchors.centerIn: parent
        spacing: 0

        Text {
            text: Qt.formatDateTime(clock.date, "MMM d")
            color: Theme.primaryText
            font.pixelSize: Theme.normalFontSize
        }

        Item {
            width: 24
            height: 1
        }

        Text {
            text: Qt.formatDateTime(clock.date, "h:mm:ss AP")
            color: Theme.primaryText
            font.pixelSize: Theme.normalFontSize
        }
    }

    MouseArea {
        anchors.fill: parent

        cursorShape: Qt.PointingHandCursor

        onClicked: root.clicked()
    }

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
}
