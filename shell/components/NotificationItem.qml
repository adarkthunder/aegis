import QtQuick
import QtQuick.Layouts
import qs.theme

Rectangle {
    id: root

    required property var notification

    implicitWidth: 300
    implicitHeight: content.implicitHeight + 20

    radius: Theme.cardRadius
    color: Qt.rgba(1, 1, 1, 0.04)

    Column {
        id: content

        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            margins: 10
        }

        spacing: 6

        RowLayout {
            width: parent.width
            spacing: 8

            Text {
                Layout.fillWidth: true

                text: root.notification.appName
                color: Theme.secondaryText
                font.pixelSize: Theme.normalFontSize - 2
                elide: Text.ElideRight
            }

            Text {
                text: "×"
                color: Theme.secondaryText
                font.pixelSize: Theme.normalFontSize + 2

                MouseArea {
                    anchors.fill: parent
                    anchors.margins: -6
                    cursorShape: Qt.PointingHandCursor

                    onClicked: {
                        if (root.notification)
                            root.notification.dismiss()
                    }
                }
            }
        }

        Text {
            width: parent.width

            text: root.notification.summary
            color: Theme.primaryText
            font.pixelSize: Theme.normalFontSize
            font.bold: true

            wrapMode: Text.Wrap
        }

        Text {
            width: parent.width

            text: root.notification.body
            color: Theme.secondaryText
            font.pixelSize: Theme.normalFontSize - 2

            wrapMode: Text.Wrap
            visible: text.length > 0
        }
    }
}
