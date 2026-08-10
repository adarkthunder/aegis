import QtQuick
import Quickshell
import qs.components
import qs.theme

Scope {
    id: root

    required property var screen
    required property var service
    required property var layout
    readonly property real barWidth: content.implicitWidth

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
            right: root.layout.notificationOffset
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
        implicitHeight: 360

        color: Theme.cardBackground

            Column {
                anchors.fill: parent
                anchors.margins: 16
                spacing: 12

                Text {
                    id: notificationTitle

                    text: "Notifications"
                    color: Theme.primaryText
                    font.pixelSize: Theme.normalFontSize
                    font.bold: true
                }

                ListView {
                    width: parent.width
                    height: parent.height
                            - notificationTitle.height
                            - parent.spacing

                    clip: true
                    spacing: 8
                    boundsBehavior: Flickable.StopAtBounds

                    model: root.service.notifications

                    delegate: NotificationItem {
                        required property var modelData

                        width: ListView.view.width
                        notification: modelData
                    }
                }
            }
    }
}
