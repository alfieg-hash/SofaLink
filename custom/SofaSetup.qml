// SPDX-License-Identifier: AGPL-3.0-only
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import org.streetpea.chiaking

Pane {
    id: page
    padding: 28
    Material.theme: Material.Dark
    Material.accent: "#68e2ba"
    property int step: 0
    readonly property var titles: ["Connect your DualShock 4", "Prepare your PS4", "Register and play", "Play from Steam"]
    readonly property var instructions: [
        "USB: connect your controller to this computer with a data-capable cable.\n\nBluetooth: hold SHARE + PS until the light flashes, then open SteamOS Bluetooth settings and pair Wireless Controller.\n\nA PlayStation controller should appear in the status below. If Steam Input presents it as a virtual controller, disable Steam Input for SofaLink to use the touchpad and motion controls directly.",
        "On your PS4, open Settings > Remote Play Connection Settings and enable Remote Play.\n\nOpen Settings > Account Management > Activate as Your Primary PS4.\n\nFor waking from rest mode, enable Stay Connected to the Internet and Enable Turning on PS4 from Network under Power Save Settings > Set Features Available in Rest Mode.\n\nKeep your PS4 and this computer on the same home network for initial setup.",
        "Return to the home screen and select your discovered PS4. If it is missing, use Add PS4 and enter its local IP address.\n\nFor manual registration, use your PSN account ID (not your online name) and the temporary PIN shown under PS4 Settings > Remote Play Connection Settings > Add Device. The registration screen includes an account-ID lookup option.\n\nStart with 720p and 60 fps in the PS4 video settings. Connect the PS4 by Ethernet if possible. Select the registered console to start streaming.",
        "In SteamOS Desktop Mode, open Steam > Games > Add a Non-Steam Game, then select SofaLink.\n\nIn its Steam controller properties, select your connected DualShock 4 and disable Steam Input for SofaLink. Reopen the app and check that a PlayStation controller is detected.\n\nIn the home screen: D-pad selects a console; Cross connects; Triangle wakes; Options opens settings; L3 opens this guide; R3 adds a console.\n\nWhile streaming, use the configured stream-menu shortcut to disconnect. You can configure it in Settings."
    ]
    readonly property int nativePads: {
        let count = 0;
        for (let pad of Chiaki.controllers)
            if (pad.playStation) ++count;
        return count;
    }
    StackView.onActivated: page.forceActiveFocus()
    Keys.onEscapePressed: root.closeDialog()
    Keys.onLeftPressed: step = Math.max(0, step - 1)
    Keys.onRightPressed: step = Math.min(3, step + 1)
    Keys.onReturnPressed: { if (step < 3) step++; else root.closeDialog(); }
    Keys.onUpPressed: scroll.contentItem.contentY = Math.max(0, scroll.contentItem.contentY - 60)
    Keys.onDownPressed: scroll.contentItem.contentY = Math.min(Math.max(0, scroll.contentItem.contentHeight - scroll.height), scroll.contentItem.contentY + 60)

    background: Rectangle { color: "#101820" }
    ColumnLayout {
        anchors.fill: parent
        spacing: 18
        RowLayout {
            Layout.fillWidth: true
            Label { text: "SOFALINK  /  QUICK START"; color: "#68e2ba"; font.pixelSize: 18; font.bold: true }
            Item { Layout.fillWidth: true }
            Button { text: "Close  /  Circle"; focusPolicy: Qt.NoFocus; onClicked: root.closeDialog() }
        }
        Label { text: (step + 1) + " / 4    " + titles[step]; font.pixelSize: 30; font.bold: true; Layout.fillWidth: true; wrapMode: Text.WordWrap }
        Rectangle { Layout.fillWidth: true; height: 3; color: "#243744"; Rectangle { width: parent.width * (step + 1) / 4; height: 3; color: "#68e2ba" } }
        ScrollView {
            id: scroll
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            contentWidth: availableWidth
            Label { width: scroll.availableWidth; text: instructions[step]; wrapMode: Text.WordWrap; font.pixelSize: 21; lineHeight: 1.2; color: "#dae5ed" }
        }
        Label {
            Layout.fillWidth: true
            wrapMode: Text.WordWrap
            font.pixelSize: 17
            color: nativePads > 0 ? "#68e2ba" : "#f0c579"
            text: nativePads > 0 ? "PlayStation controller detected — ready for input" : Chiaki.controllers.length > 0 ? "Controller detected — direct PlayStation input not detected" : "No controller detected — connect USB or pair Bluetooth"
        }
        RowLayout {
            Layout.fillWidth: true
            Button { text: "Previous  /  Left"; enabled: step > 0; focusPolicy: Qt.NoFocus; onClicked: step-- }
            Item { Layout.fillWidth: true }
            Label { text: "D-pad up/down to scroll"; color: "#92a9b8"; font.pixelSize: 15 }
            Item { Layout.fillWidth: true }
            Button { text: step < 3 ? "Next  /  Cross" : "Done  /  Cross"; focusPolicy: Qt.NoFocus; onClicked: { if (step < 3) step++; else root.closeDialog(); } }
        }
    }
    onStepChanged: scroll.contentItem.contentY = 0
}
