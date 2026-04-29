import SwiftUI
import AppKit

struct ContentView: View {
    @State private var isRunning = false
    @State private var status = "Ready to repair macOS application icons."
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""

    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(nsColor: .windowBackgroundColor), Color(nsColor: .controlBackgroundColor)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack(spacing: 22) {
                Image(nsImage: NSApp.applicationIconImage)
                    .resizable()
                    .frame(width: 96, height: 96)
                    .shadow(radius: 12)

                VStack(spacing: 8) {
                    Text("IconFix")
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                    Text("Repair missing, broken, or stale macOS app icons.")
                        .font(.system(size: 15))
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }

                VStack(alignment: .leading, spacing: 10) {
                    Label("Clears the macOS icon services cache", systemImage: "sparkles")
                    Label("Restarts Dock and Finder", systemImage: "dock.rectangle")
                    Label("Requires administrator approval", systemImage: "lock.shield")
                }
                .font(.system(size: 14))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))

                Text(status)
                    .font(.system(size: 13))
                    .foregroundStyle(.secondary)
                    .frame(height: 24)

                HStack(spacing: 12) {
                    Button("Quit") { NSApplication.shared.terminate(nil) }
                        .keyboardShortcut(.cancelAction)

                    Button(action: runRepair) {
                        HStack {
                            if isRunning { ProgressView().controlSize(.small) }
                            Text(isRunning ? "Running..." : "Run IconFix")
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .keyboardShortcut(.defaultAction)
                    .disabled(isRunning)
                }
            }
            .padding(32)
        }
        .alert(alertTitle, isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
    }

    private func runRepair() {
        let confirm = NSAlert()
        confirm.messageText = "Run IconFix?"
        confirm.informativeText = "This will clear the macOS icon cache and restart Dock and Finder. Open Finder windows may refresh."
        confirm.alertStyle = .warning
        confirm.addButton(withTitle: "Run IconFix")
        confirm.addButton(withTitle: "Cancel")

        guard confirm.runModal() == .alertFirstButtonReturn else { return }

        isRunning = true
        status = "Requesting administrator approval..."

        DispatchQueue.global(qos: .userInitiated).async {
            let script = "do shell script \"rm -rfv /Library/Caches/com.apple.iconservices.store; killall Dock; killall Finder\" with administrator privileges"
            var errorInfo: NSDictionary?
            let appleScript = NSAppleScript(source: script)
            appleScript?.executeAndReturnError(&errorInfo)

            DispatchQueue.main.async {
                isRunning = false
                if let errorInfo = errorInfo {
                    let message = errorInfo[NSAppleScript.errorMessage] as? String ?? "Unknown error."
                    status = "IconFix did not complete."
                    alertTitle = "IconFix Could Not Complete"
                    alertMessage = message
                } else {
                    status = "Icon cache reset complete."
                    alertTitle = "IconFix Complete"
                    alertMessage = "Dock and Finder have been restarted. Icons should refresh shortly."
                }
                showAlert = true
            }
        }
    }
}
