import Quickshell
import qs.components
import qs.theme

PanelWindow {
    id: root

    required property var layout
    readonly property real barWidth: implicitWidth

    anchors {
        top: true
        right: true
    }

    margins {
        top: Theme.topMargin
        right: root.layout.timeOffset
    }

    exclusiveZone: 0

    implicitWidth: content.implicitWidth
    implicitHeight: content.implicitHeight

    color: "transparent"

    TimeCard {
        id: content
    }
}
