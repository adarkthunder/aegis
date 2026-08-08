import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import qs.theme

Rectangle {
    id: root

    required property var screen

    readonly property var hyprMonitor: Hyprland.monitorFor(screen)

    // Your fixed layout:
    // monitor 1 => workspaces 6-9
    // monitor 2 => workspaces 1-5
    readonly property var workspaceIds: {
        if (!hyprMonitor)
            return []

        return hyprMonitor.id === 0
            ? [6, 7, 8, 9]
            : [1, 2, 3, 4, 5]
    }

    implicitWidth: workspaceRow.implicitWidth + Theme.horizontalPadding * 2
    implicitHeight: Theme.cardHeight

    radius: Theme.cardRadius
    color: Theme.cardBackground

    RowLayout {
        id: workspaceRow

        anchors.centerIn: parent
        spacing: 8

        Repeater {
            model: root.workspaceIds

            delegate: Rectangle {
                required property int modelData

                readonly property var workspace: {
                    for (let i = 0; i < Hyprland.workspaces.values.length; ++i) {
                        const ws = Hyprland.workspaces.values[i]

                        if (ws.id === modelData)
                            return ws
                    }

                    return null
                }

                readonly property bool active:
                    workspace !== null && workspace.active

                readonly property bool occupied:
                    workspace !== null &&
                    workspace.toplevels.values.length > 0

                implicitWidth: 28
                implicitHeight: 28

                radius: 8

                color: active
                    ? Theme.primaryText
                    : mouseArea.containsMouse
                        ? "#313244"
                        : "transparent"

                Text {
                    anchors.centerIn: parent

                    text: modelData

                    color: active
                        ? Theme.cardBackground
                        : occupied
                            ? Theme.primaryText
                            : Theme.secondaryText

                    font.pixelSize: Theme.normalFontSize
                }

                MouseArea {
                    id: mouseArea

                    anchors.fill: parent
                    hoverEnabled: true

                    onClicked: {
                        if (workspace)
                            workspace.activate()
                        else
                            Hyprland.dispatch("workspace " + modelData)
                    }
                }
            }
        }
    }
}
