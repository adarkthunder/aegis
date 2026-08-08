import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

Scope {
    id: root

    readonly property var sink: Pipewire.defaultAudioSink

    readonly property int volume:
        sink && sink.audio
            ? Math.round(sink.audio.volume * 100)
            : 0

    readonly property bool muted:
        sink && sink.audio
            ? sink.audio.muted
            : false

    PwObjectTracker {
        objects: [root.sink]
    }

    function setVolume(value) {
        if (!root.sink || !root.sink.audio)
            return

        root.sink.audio.volume =
            Math.max(0, Math.min(1, value / 100))
    }

    function changeVolume(delta) {
        root.setVolume(root.volume + delta)
    }

    function toggleMute() {
        if (root.sink && root.sink.audio)
            root.sink.audio.muted = !root.sink.audio.muted
    }
}
