import QtQuick
import Quickshell

import qs.components
import qs.theme

Scope {
    id: root

    required property var screen
    required property var layout

    readonly property real barWidth: content.implicitWidth

    property bool popupVisible: false

    property date shownMonth: new Date()

    readonly property var weekdayNames: [
        "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"
    ]

    function resetToCurrentMonth() {
        const now = currentClock.date

        shownMonth = new Date(
            now.getFullYear(),
            now.getMonth(),
            1
        )
    }

    function moveMonth(offset) {
        shownMonth = new Date(
            shownMonth.getFullYear(),
            shownMonth.getMonth() + offset,
            1
        )
    }

    function firstWeekday() {
        return new Date(
            shownMonth.getFullYear(),
            shownMonth.getMonth(),
            1
        ).getDay()
    }

    function daysInShownMonth() {
        return new Date(
            shownMonth.getFullYear(),
            shownMonth.getMonth() + 1,
            0
        ).getDate()
    }

    function dayForCell(cellIndex) {
        return cellIndex - firstWeekday() + 1
    }

    function isToday(day) {
        const today = currentClock.date

        return day === today.getDate()
            && shownMonth.getMonth() === today.getMonth()
            && shownMonth.getFullYear() === today.getFullYear()
    }

    SystemClock {
        id: currentClock
        precision: SystemClock.Minutes
    }

    //
    // Top-bar clock
    //

    PanelWindow {
        id: indicatorWindow

        screen: root.screen

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

            onClicked: {
                root.popupVisible = !root.popupVisible

                if (root.popupVisible)
                    root.resetToCurrentMonth()
            }
        }
    }

    //
    // Calendar popup
    //

    PanelWindow {
        id: calendarWindow

        screen: root.screen
        visible: root.popupVisible

        anchors {
            top: true
            right: true
        }

        margins {
            top: Theme.topMargin + Theme.cardHeight + 8
            right: root.layout.timeOffset
        }

        exclusiveZone: 0

        implicitWidth: 340
        implicitHeight: 330

        color: "transparent"

        Rectangle {
            anchors.fill: parent

            radius: Theme.cardRadius
            color: Theme.cardBackground

            Column {
                anchors.fill: parent
                anchors.margins: 16

                spacing: 12

                //
                // Month navigation
                //

                Row {
                    width: parent.width
                    height: 32

                    Item {
                        width: 32
                        height: parent.height

                        Text {
                            anchors.centerIn: parent

                            text: "‹"
                            color: Theme.primaryText
                            font.pixelSize: 24
                        }

                        MouseArea {
                            anchors.fill: parent

                            cursorShape: Qt.PointingHandCursor

                            onClicked: root.moveMonth(-1)
                        }
                    }

                    Text {
                        width: parent.width - 64
                        height: parent.height

                        text: Qt.formatDate(
                            root.shownMonth,
                            "MMMM yyyy"
                        )

                        color: Theme.primaryText
                        font.pixelSize: Theme.titleFontSize
                        font.bold: true

                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    Item {
                        width: 32
                        height: parent.height

                        Text {
                            anchors.centerIn: parent

                            text: "›"
                            color: Theme.primaryText
                            font.pixelSize: 24
                        }

                        MouseArea {
                            anchors.fill: parent

                            cursorShape: Qt.PointingHandCursor

                            onClicked: root.moveMonth(1)
                        }
                    }
                }

                //
                // Weekday headings
                //

                Grid {
                    id: weekdayGrid

                    width: parent.width

                    columns: 7
                    spacing: 0

                    Repeater {
                        model: root.weekdayNames

                        delegate: Item {
                            required property string modelData

                            width: weekdayGrid.width / 7
                            height: 24

                            Text {
                                anchors.centerIn: parent

                                text: modelData
                                color: Theme.secondaryText
                                font.pixelSize: 12
                            }
                        }
                    }
                }

                //
                // Calendar days
                //

                Grid {
                    id: dayGrid

                    width: parent.width

                    columns: 7
                    spacing: 0

                    Repeater {
                        model: 42

                        delegate: Rectangle {
                            id: dayCell

                            property int dayNumber:
                                root.dayForCell(index)

                            property bool validDay:
                                dayNumber >= 1
                                && dayNumber <= root.daysInShownMonth()

                            width: dayGrid.width / 7
                            height: 34

                            radius: 8

                            color: "transparent"

                            border.width:
                                validDay
                                && root.isToday(dayNumber)
                                ? 1
                                : 0

                            border.color: Theme.secondaryText

                            Text {
                                anchors.centerIn: parent

                                text: dayCell.validDay
                                      ? dayCell.dayNumber
                                      : ""

                                color: root.isToday(dayCell.dayNumber)
                                       ? Theme.primaryText
                                       : Theme.secondaryText

                                font.pixelSize: Theme.normalFontSize

                                font.bold:
                                    dayCell.validDay
                                    && root.isToday(dayCell.dayNumber)
                            }
                        }
                    }
                }

                //
                // Return to current month
                //

                Text {
                    width: parent.width

                    text: "Today"
                    color: Theme.secondaryText
                    font.pixelSize: 12

                    horizontalAlignment: Text.AlignHCenter

                    MouseArea {
                        anchors.fill: parent

                        cursorShape: Qt.PointingHandCursor
                        onClicked: root.resetToCurrentMonth()
                    }
                }
            }
        }
    }
}
