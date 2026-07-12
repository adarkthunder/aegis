import QtQuick
import Quickshell
import qs.theme

Rectangle {
    implicitWidth: timeText.implicitWidth + Theme.horizontalPadding * 2
    implicitHeight: Theme.cardHeight

    radius: Theme.cardRadius
    color: Theme.cardBackground

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }

    Text {
        id: timeText
        anchors.centerIn: parent

        text: Qt.formatDateTime(
            clock.date,
            "ddd, MMM d   h:mm:ss AP"
        )

        color: Theme.primaryText
        font.pixelSize: Theme.normalFontSize
    }
}
