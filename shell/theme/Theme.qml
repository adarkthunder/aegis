pragma Singleton

import QtQuick
import Quickshell

Singleton {
    // Card geometry
    readonly property int cardHeight: 40
    readonly property int cardRadius: 12

    // Card content spacing
    readonly property int horizontalPadding: 14
    readonly property int verticalPadding: 8

    // Distance from screen edges
    readonly property int screenMargin: 8
    readonly property int topMargin: 6

    // Distance between related cards
    readonly property int cardSpacing: 8

    // Typography
    readonly property int normalFontSize: 15
    readonly property int titleFontSize: 16

    // Colors
    readonly property color cardBackground: "#181825"
    readonly property color primaryText: "#ffffff"
    readonly property color secondaryText: "#cdd6f4"
}
