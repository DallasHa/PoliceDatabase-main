import SwiftUI

@main
struct PoliceProjectApp: App {
    
    @StateObject var bylaw = BylawService()
    @StateObject var police = PoliceService()
    
    var body: some Scene {
        
        WindowGroup {
            ContentView()
                .environmentObject(bylaw)
                .environmentObject(police)
        }
    }
}
