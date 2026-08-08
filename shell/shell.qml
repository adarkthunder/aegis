//@ pragma UseQApplication

import QtQuick
import Quickshell
import qs.windows
import qs.services

ShellRoot {
    NotificationService {
        id: notificationService
    }

    Variants {
        model: Quickshell.screens

        delegate: Scope {
            required property var modelData

            AegisWindow {
                screen: modelData
            }

            WorkspaceWindow {
                screen: modelData
            }

            TimeWindow {
                screen: modelData
            }

            TrayWindow {
                screen: modelData
            }

            NotificationWindow {
                screen: modelData
                service: notificationService
            }

        }
    }
}
