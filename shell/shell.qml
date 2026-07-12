import Quickshell
import qs.windows

ShellRoot {
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
        }
    }
}
