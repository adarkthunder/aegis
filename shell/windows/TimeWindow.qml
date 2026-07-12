import Quickshell
import qs.components
import qs.theme

PanelWindow {
    anchors {
        top: true
        right: true
    }

    margins {
        top: Theme.topMargin
        right: Theme.screenMargin
    }

    exclusiveZone: 0

    implicitWidth: content.implicitWidth
    implicitHeight: content.implicitHeight

    color: "transparent"

    TimeCard {
        id: content
    }
}
