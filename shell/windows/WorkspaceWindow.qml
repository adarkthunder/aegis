import Quickshell
import qs.components
import qs.theme

PanelWindow {
    anchors {
        top: true
    }

    margins {
        top: Theme.topMargin
    }

    exclusiveZone: 0

    implicitWidth: content.implicitWidth
    implicitHeight: content.implicitHeight

    color: "transparent"

    WorkspaceCard {
        id: content
    }
}
