import QtQuick
import Quickshell
import Quickshell.Io

import qs.components
import qs.theme

Scope {
    id: root

    required property var screen
    required property var layout

    readonly property real barWidth: content.implicitWidth

    property bool popupVisible: false
    
    Process {
        id: lockProcess
        command: ["hyprlock"]
    }

    Process {
        id: logoutProcess
        command: ["hyprctl", "dispatch", "hl.dsp.exit()"]
    }

    Process {
        id: suspendProcess
        command: ["systemctl", "suspend"]
    }

    Process {
        id: rebootProcess
        command: ["systemctl", "reboot"]
    }

    Process {
        id: shutdownProcess
        command: ["systemctl", "poweroff"]
    }

    PanelWindow {
        id: indicator

        screen: root.screen

        anchors {
            top: true
            right: true
        }

        margins {
            top: Theme.topMargin
            right: root.layout.powerOffset
        }

        exclusiveZone: 0

        implicitWidth: content.implicitWidth
        implicitHeight: content.implicitHeight

        color: "transparent"

        PowerCard {
            id: content

            onClicked:
                root.popupVisible = !root.popupVisible
        }
    }

    PanelWindow {
        id: popup

        screen: root.screen

        visible: root.popupVisible

        anchors {
            top: true
            right: true
        }

        margins {
            top: Theme.topMargin + Theme.cardHeight + 8
            right: 0
        }

        implicitWidth: 220
        implicitHeight: menu.implicitHeight + 20

        color: Theme.cardBackground

        Column {
            id: menu

            anchors.fill: parent
            anchors.margins: 10

            spacing: 6

            PowerButton {
                glyph: "󰌾"
                text: "Lock"

                onClicked: {
                    root.popupVisible = false
                    lockProcess.running = true
                }
            }

            PowerButton {
                glyph: "󰍃"
                text: "Logout"

                onClicked: {
                    root.popupVisible = false
                    logoutProcess.running = true
                }
            }

            PowerButton {
                glyph: "󰤄"
                text: "Suspend"

                onClicked: {
                    root.popupVisible = false
                    suspendProcess.running = true
                }
            }

            PowerButton {
                glyph: "󰜉"
                text: "Reboot"

                onClicked: {
                    root.popupVisible = false
                    rebootProcess.running = true
                }
            }

            PowerButton {
                glyph: ""
                text: "Shutdown"

                onClicked: {
                    root.popupVisible = false
                    shutdownProcess.running = true
                }
            }
        }
        
    }
}
