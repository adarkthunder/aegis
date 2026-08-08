import QtQuick

QtObject {
    id: root

    // Width reported by each bar item
    property real trayWidth: 0
    property real audioWidth: 0
    property real notificationWidth: 0
    property real timeWidth: 0
    property real powerWidth: 0

    // Space between cards
    property real spacing: 6

    // Offsets measured from the right edge of the monitor.
    //
    // [Tray] [Audio] [Notification] [Time] [Power]
    //                                           ↑ right edge

    readonly property real powerOffset: 0

    readonly property real timeOffset:
        powerOffset + powerWidth + spacing

    readonly property real notificationOffset:
        timeOffset + timeWidth + spacing

    readonly property real audioOffset:
        notificationOffset + notificationWidth + spacing

    readonly property real trayOffset:
        audioOffset + audioWidth + spacing
}
