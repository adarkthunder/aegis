import QtQuick
import qs.theme

Rectangle {
    id: root

    required property var service
    signal clicked()

    implicitWidth: Math.max(40, content.implicitWidth + 12)
    implicitHeight: Theme.cardHeight

    radius: Theme.cardRadius
    color: Theme.cardBackground

    Text {
        anchors.centerIn: parent

        text: root.service.notifications.length > 0
            ? "󰂚 " + root.service.notifications.length
            : "󰂜"

        color: Theme.primaryText
        font.pixelSize: Theme.normalFontSize
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }
}
