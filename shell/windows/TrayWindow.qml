import Quickshell
import qs.components
import qs.theme

PanelWindow {
    id: root

    anchors {
        top: true
        right: true
    }

    margins {
        top: Theme.topMargin
        right: 205
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
