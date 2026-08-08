import QtQuick
import QtQuick.Controls
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
            right: root.layout.audioOffset   // temporary until we refactor right-side spacing
        }

        exclusiveZone: 0

        implicitWidth: content.implicitWidth
        implicitHeight: content.implicitHeight

        color: "transparent"

        AudioCard {
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
        implicitHeight: 160

        color: Theme.cardBackground

        Column {
            id: audioMenu

            anchors.fill: parent
            anchors.margins: 16

            spacing: 12

            Text {
                text: "Audio"
                color: Theme.primaryText
                font.pixelSize: Theme.normalFontSize
                font.bold: true
            }

            Text {
                width: parent.width

                text: root.service.sink
                    ? root.service.sink.description
                    : "No output device"

                color: Theme.secondaryText
                font.pixelSize: Theme.normalFontSize - 2
                elide: Text.ElideRight
            }

            Row {
                width: parent.width
                spacing: 10

                Text {
                    anchors.verticalCenter: parent.verticalCenter

                    text: root.service.muted
                        ? "󰖁"
                        : root.service.volume >= 60
                            ? "󰕾"
                            : root.service.volume > 0
                                ? "󰖀"
                                : "󰕿"

                    color: Theme.primaryText
                    font.pixelSize: Theme.normalFontSize + 2

                    MouseArea {
                        anchors.fill: parent
                        anchors.margins: -6
                        cursorShape: Qt.PointingHandCursor

                        onClicked: root.service.toggleMute()
                    }
                }

                Slider {
                    id: volumeSlider

                    width: 210

                    from: 0
                    to: 100
                    value: root.service.volume

                    onMoved: {
                        console.log("Audio slider moved:", value)
                        root.service.setVolume(value)
                    }
                }

                Text {
                    anchors.verticalCenter: parent.verticalCenter

                    text: root.service.volume + "%"
                    color: Theme.primaryText
                    font.pixelSize: Theme.normalFontSize

                    width: 42
                }
            }

            Text {
                text: root.service.muted ? "Muted" : "Output volume"
                color: Theme.secondaryText
                font.pixelSize: Theme.normalFontSize - 2
            }
        }
    }
}
