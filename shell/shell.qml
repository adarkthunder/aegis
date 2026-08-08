//@ pragma UseQApplication

import QtQuick
import Quickshell
import qs.windows
import qs.services
import qs.layout

ShellRoot {
    NotificationService {
        id: globalNotificationService
    }

    AudioService {
        id: globalAudioService
    }
    
    Variants {
        model: Quickshell.screens

        delegate: Scope {
            required property var modelData

            RightBarLayout {
                id: rightLayout

                trayWidth: trayWindow.barWidth
                audioWidth: audioWindow.barWidth
                notificationWidth: notificationWindow.barWidth
                timeWidth: timeWindow.barWidth
                powerWidth: powerWindow.barWidth
            }

            AegisWindow {
                screen: modelData
            }

            WorkspaceWindow {
                screen: modelData
            }

            TrayWindow {
                id: trayWindow
                screen: modelData
                layout: rightLayout
            }

            AudioWindow {
                id: audioWindow
                screen: modelData
                service: globalAudioService
                layout: rightLayout
            }

            NotificationWindow {
                id: notificationWindow
                screen: modelData
                service: globalNotificationService
                layout: rightLayout
            }

            TimeWindow {
                id: timeWindow
                screen: modelData
                layout: rightLayout
            }

            PowerWindow {
                id: powerWindow
                screen: modelData
            layout: rightLayout
            }
        }
    }
}
