import QtQuick

import Quickshell
import Quickshell.Hyprland

import qs.theme

Rectangle {
    id: root

    implicitHeight: Theme.cardHeight
    implicitWidth: Math.min(contentRow.implicitWidth + 24, 420)

    radius: Theme.cardRadius
    color: Theme.cardBackground

    property var activeWindow: Hyprland.activeToplevel

    property string appName: {
        if (!activeWindow)
            return "Desktop"

        if (activeWindow.wayland && activeWindow.wayland.appId)
            return formatAppName(activeWindow.wayland.appId)

        return "Unknown"
    }

    property string windowTitle: {
        if (!activeWindow)
            return ""

        if (activeWindow.title)
            return activeWindow.title

        if (activeWindow.wayland && activeWindow.wayland.title)
            return activeWindow.wayland.title

        return ""
    }

    function formatAppName(appId) {
        if (!appId)
            return "Unknown"

        let name = appId

        // org.kde.kate -> kate
        if (name.indexOf(".") !== -1)
            name = name.split(".").pop()

        // firefox-nightly -> firefox nightly
        name = name.replace(/[-_]/g, " ")

        return name
            .split(" ")
            .map(word =>
                word.length > 0
                    ? word.charAt(0).toUpperCase() + word.slice(1)
                    : word
            )
            .join(" ")
    }

    Row {
        id: contentRow

        anchors.centerIn: parent
        spacing: 8

        Text {
            text: root.appName

            color: Theme.primaryText
            font.pixelSize: Theme.normalFontSize
            font.bold: true
        }

        Text {
            visible: root.windowTitle.length > 0

            text: "·"

            color: Theme.secondaryText
            font.pixelSize: Theme.normalFontSize
        }

        Text {
            visible: root.windowTitle.length > 0

            text: root.windowTitle

            color: Theme.secondaryText
            font.pixelSize: Theme.normalFontSize

            elide: Text.ElideRight
            maximumLineCount: 1
            width: Math.min(implicitWidth, 260)
        }
    }
}
