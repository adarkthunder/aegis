import QtQuick
import qs.theme

Rectangle {
    id: root

    required property var service

    signal clicked()

    implicitWidth: content.implicitWidth + 16
    implicitHeight: Theme.cardHeight

    radius: Theme.cardRadius
    color: Theme.cardBackground

    Row {
        id: content
        anchors.centerIn: parent
        spacing: 6

        Text {
            text: root.service.muted
                ? "󰖁"
                : root.service.volume >= 60
                    ? "󰕾"
                    : root.service.volume > 0
                        ? "󰖀"
                        : "󰕿"

            color: Theme.primaryText
            font.pixelSize: Theme.normalFontSize
        }

        Text {
            text: root.service.volume + "%"
            color: Theme.primaryText
            font.pixelSize: Theme.normalFontSize
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton | Qt.MiddleButton

        onClicked: mouse => {
            if (mouse.button === Qt.MiddleButton)
                root.service.toggleMute()
            else
                root.clicked()
        }

        onWheel: wheel => {
            if (wheel.angleDelta.y > 0)
                root.service.changeVolume(5)
            else if (wheel.angleDelta.y < 0)
                root.service.changeVolume(-5)
        }
    }
}
