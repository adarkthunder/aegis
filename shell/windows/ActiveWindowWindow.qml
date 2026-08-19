import QtQuick
import Quickshell

import qs.components
import qs.theme

Scope {
    id: root

    required property var screen
    required property var layout

    readonly property real barWidth: content.implicitWidth

    PanelWindow {
        id: indicatorWindow

        screen: root.screen

        anchors {
            top: true
            right: true
        }

        margins {
            top: Theme.topMargin
            right: root.layout.activeWindowOffset
        }

        exclusiveZone: 0

        implicitWidth: content.implicitWidth
        implicitHeight: content.implicitHeight

        color: "transparent"

        ActiveWindowCard {
            id: content
        }
    }
}
