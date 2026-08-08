import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray
import qs.theme

Rectangle {
    id: root
    required property var window
    signal overflowClicked()

    implicitWidth: trayRow.implicitWidth + Theme.horizontalPadding * 2
    implicitHeight: Theme.cardHeight

    radius: Theme.cardRadius
    color: Theme.cardBackground

    RowLayout {
        id: trayRow

        anchors.centerIn: parent
        spacing: 8

        Repeater {
            model: SystemTray.items

            delegate: Item {
                required property var modelData

                implicitWidth: 22
                implicitHeight: 22

                Image {
                    anchors.centerIn: parent

                    width: 18
                    height: 18

                    source: modelData.icon
                    fillMode: Image.PreserveAspectFit
                }

                MouseArea {
                    id: mouseArea
                    anchors.fill: parent

                    acceptedButtons: Qt.LeftButton | Qt.RightButton

                    onClicked: mouse => {
                        if (mouse.button === Qt.LeftButton) {
                            if (modelData.onlyMenu && modelData.hasMenu)
                                modelData.display(root.window, mouseArea.x, mouseArea.y + mouseArea.height + 6)
                            else
                                modelData.activate()
                        } else if (mouse.button === Qt.RightButton && modelData.hasMenu) {
                            modelData.display(root.window, mouseArea.x, mouseArea.y + mouseArea.height + 6)
                        }
                    }
                }
            }
        }

        Rectangle {
            implicitWidth: 24
            implicitHeight: 24

            radius: 6
            color: overflowMouse.containsMouse
                ? Theme.hoverBackground
                : "transparent"

            Text {
                anchors.centerIn: parent
                text: "⌃"
                color: Theme.primaryText
                font.pixelSize: Theme.normalFontSize
            }

            MouseArea {
                id: overflowMouse

                anchors.fill: parent
                hoverEnabled: true

                onClicked: root.overflowClicked()
            }
        }
    }
}
