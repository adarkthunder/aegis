import QtQuick
import Quickshell
import qs.components
import qs.theme

Scope {
    id: root

    required property var screen
    required property var service

    property bool popupVisible: false

    PanelWindow {
        id: indicatorWindow

        screen: root.screen

        anchors {
            top: true
            right: true
        }

        margins {
            top: Theme.topMargin
            right: 185
        }

        exclusiveZone: 0

        implicitWidth: content.implicitWidth
        implicitHeight: content.implicitHeight

        color: "transparent"

        NotificationCard {
            id: content
            service: root.service

            onClicked: {
                root.popupVisible = !root.popupVisible
            }
        }
    }

    PanelWindow {
       id: popupWindow
    
        screen: root.screen
        visible: root.popupVisible

        anchors {
           top: true
           right: true
        }
    
        margins {
            top: Theme.topMargin + Theme.cardHeight + 8
            right: 20
        }

        exclusiveZone: 0

        implicitWidth: 320
        implicitHeight: 200

        color: Theme.cardBackground

        Column {
            anchors.fill: parent
            anchors.margins: 16
            spacing: 12

            Text {
                text: "Notifications"
                color: Theme.primaryText
                font.pixelSize: Theme.normalFontSize
                font.bold: true
            }

            Repeater {
                model: root.service.notifications
    
                delegate: NotificationItem {
                    required property var modelData

                    width: parent.width
                    notification: modelData
                }
            }
        }
    }
}
