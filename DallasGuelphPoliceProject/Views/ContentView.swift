import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var bylawService: BylawService
    
    @EnvironmentObject var policeService: PoliceService
    
    var body: some View {
        
        NavigationStack {
            VStack {

                Spacer()
                
                NavigationLink(destination: BylawView()) {
                    VStack {
                        Text("BYLAW")
                        Image("bylaw")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
                
                Spacer()
                
                NavigationLink(destination: PoliceView()) {
                    VStack {
                        Text("POLICE")
                        Image("police")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
                
                Spacer()

            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
