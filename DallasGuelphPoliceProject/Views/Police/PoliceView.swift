import SwiftUI

struct PoliceView: View {
    var body: some View {
        
        VStack(alignment: .listRowSeparatorLeading) {
                        
            Spacer()
            
            NavigationLink("View Predefined Analytics", destination: PoliceAnalyticsListView(analytics: PoliceAnalyticsEnum.allCases.map({$0.info})))
                .foregroundColor(.blue)
                .buttonStyle(.bordered)
                .font(.title)
            
            Spacer()
            
            NavigationLink("Search", destination: PoliceSearchView())
                .foregroundColor(.blue)
                .buttonStyle(.bordered)
                .font(.title)

            Spacer()

            NavigationLink("File Report", destination: PoliceInsertView())
                .foregroundColor(.blue)
                .buttonStyle(.bordered)
                .font(.title)
                        
            Spacer()
            
        }.navigationTitle("POLICE")
    }
}

struct PoliceView_Previews: PreviewProvider {
    static var previews: some View {
        PoliceView()
    }
}
