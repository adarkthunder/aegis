import QtQuick
import Quickshell
import Quickshell.Services.Notifications

Scope {
    id: root

    property var notifications: []

    function removeNotification(notification) {
        root.notifications = root.notifications.filter(
            item => item !== null && item !== notification
        )
    }

    NotificationServer {
        id: server

        actionsSupported: true
        persistenceSupported: true
        bodySupported: true

        onNotification: notification => {
            notification.tracked = true

            root.notifications =
                [notification].concat(root.notifications)

            notification.closed.connect(reason => {
                root.removeNotification(notification)
            })

            console.log(
                "Notification:",
                notification.appName,
                notification.summary,
                notification.body
            )
        }
    }
}
