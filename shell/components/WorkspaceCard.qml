import QtQuick
import qs.theme

Rectangle {
    implicitWidth: workspaceText.implicitWidth + Theme.horizontalPadding * 2
    implicitHeight: Theme.cardHeight

    radius: Theme.cardRadius
    color: Theme.cardBackground

    Text {
        id: workspaceText
        anchors.centerIn: parent

        text: "1  2  3  4  5  6"
        color: Theme.primaryText
        font.pixelSize: Theme.normalFontSize
    }
}
