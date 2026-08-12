import QtQuick
import Quickshell.Services.UPower
import qs.Common
import qs.Services
import qs.Widgets
import qs.Modules.Plugins

PluginComponent {
    id: root

    function profileIcon(profile) {
        switch (profile) {
        case PowerProfile.PowerSaver:
            return "psychiatry"
        case PowerProfile.Balanced:
            return "balance"
        case PowerProfile.Performance:
            return "electric_bolt"
        }
    }

    function nextProfile() {
        if (!PowerProfileWatcher.available)
            return

        const current = PowerProfileWatcher.currentProfile

        if (current === PowerProfile.PowerSaver) {
            PowerProfileWatcher.applyProfile(PowerProfile.Balanced)
        } else if (current === PowerProfile.Balanced) {
            PowerProfileWatcher.applyProfile(PowerProfile.Performance)
        } else {
            PowerProfileWatcher.applyProfile(PowerProfile.PowerSaver)
        }
    }

    pillClickAction: function() {
        root.nextProfile()
    }

    horizontalBarPill: Component {
        Item {
            implicitWidth: icon.width
            implicitHeight: icon.height

            DankIcon {
                id: icon
                anchors.centerIn: parent
                name: root.profileIcon(PowerProfileWatcher.currentProfile)
                size: root.iconSize
                color: Theme.primary
            }
        }
    }

    verticalBarPill: Component {
        Item {
            implicitWidth: icon.width
            implicitHeight: icon.height

            DankIcon {
                id: icon
                anchors.centerIn: parent
                name: root.profileIcon(PowerProfileWatcher.currentProfile)
                size: root.iconSize
                color: Theme.primary
            }
        }
    }
}
