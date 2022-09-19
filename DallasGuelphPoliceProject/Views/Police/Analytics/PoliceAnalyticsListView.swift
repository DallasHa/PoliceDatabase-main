import SwiftUI

struct PoliceAnalyticsListView: View {
    
    @State var analytics: [AnalyticRequest]
    
    var body: some View {
        
        VStack {
            
            List {
                
                ForEach(analytics, id: \.self) { analytic in
                    NavigationLink(analytic.title, destination: PoliceAnalyticsView(analytic: analytic))
                    .buttonStyle(.borderedProminent)
                }
                
            }.listStyle(GroupedListStyle())
        }.navigationTitle("Predefined Analytics")
    }
}

struct PoliceAnalyticsListView_Previews: PreviewProvider {
    static var previews: some View {
        PoliceAnalyticsListView(analytics: [AnalyticRequest]())
    }
}
