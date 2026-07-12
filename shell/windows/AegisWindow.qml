import Quickshell
import qs.components
import qs.theme

PanelWindow {
    anchors {
        top: true
        left: true
    }

    margins {
        top: Theme.topMargin
        left: Theme.screenMargin
    }

    exclusiveZone: 0

    implicitWidth: content.implicitWidth
    implicitHeight: content.implicitHeight

    color: "transparent"

    AegisButton {
        id: content
    }
}
