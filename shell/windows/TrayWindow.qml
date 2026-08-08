import Quickshell
import qs.components
import qs.theme

PanelWindow {
    id: root
    
    required property var layout
    readonly property real barWidth: content.implicitWidth

    anchors {
        top: true
        right: true
    }

    margins {
        top: Theme.topMargin
        right: root.layout.trayOffset
    }

    exclusiveZone: 0

    implicitWidth: content.implicitWidth
    implicitHeight: content.implicitHeight

    color: "transparent"

    TrayCard {
        id: content

        window: root

        onOverflowClicked: {
            console.log("Tray overflow clicked")
        }
    }
}
