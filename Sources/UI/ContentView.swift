import SwiftUI
import Foundation

@_silgen_name("trigger_jit_bridge")
func trigger_jit_bridge()

struct ContentView: View {
    @State private var log = "Titan A18 Pro: Ready\n"
    
    var body: some View {
        VStack {
            Text("TITAN ENGINE").font(.largeTitle).bold().foregroundColor(.orange)
            
            ScrollView {
                Text(log).font(.system(.caption, design: .monospaced))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .background(Color.black).foregroundColor(.green)
            .frame(height: 400).cornerRadius(12)
            
            Button("START ENGINE") {
                launchTitan()
            }
            .buttonStyle(.borderedProminent).tint(.orange).controlSize(.large)
        }.padding()
    }
    
    func launchTitan() {
        log += "🔥 Igniting JIT...\n"
        trigger_jit_bridge()
        
        let bundlePath = Bundle.main.bundlePath
        let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].path
        
        // Path to the binaries we cooked in the workflow
        let box64Path = "\(bundlePath)/bin/box64"
        let winePath = "\(bundlePath)/bin/wine"
        
        log += "🚀 Launching Box64 -> Wine...\n"
        
        let task = Process()
        task.executableURL = URL(fileURLWithPath: box64Path)
        task.arguments = [winePath, "explorer /desktop=Titan,1280x720"]
        task.environment = [
            "DYLD_LIBRARY_PATH": "\(bundlePath)/lib",
            "WINEPREFIX": "\(docs)/.wine",
            "BOX64_LOG": "1"
        ]
        
        do {
            try task.run()
            log += "✅ Engine Running! PID: \(task.processIdentifier)\n"
        } catch {
            log += "❌ Launch Failed: \(error.localizedDescription)\n"
        }
    }
}
