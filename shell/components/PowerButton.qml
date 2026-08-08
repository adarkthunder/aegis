import QtQuick
import qs.theme

Rectangle {
    id: root

    required property string glyph
    required property string text

    signal clicked()

    implicitWidth: 200
    implicitHeight: 38

    radius: Theme.cardRadius
    color: "transparent"

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        onClicked: root.clicked()

        onEntered: root.color = Qt.rgba(1, 1, 1, 0.06)
        onExited: root.color = "transparent"
    }

    Row {
        anchors.fill: parent
        anchors.leftMargin: 12
        anchors.rightMargin: 12

        spacing: 12

        Text {
            anchors.verticalCenter: parent.verticalCenter

            text: root.glyph
            color: Theme.primaryText
            font.pixelSize: Theme.normalFontSize
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter

            text: root.text
            color: Theme.primaryText
            font.pixelSize: Theme.normalFontSize
        }
    }
}
