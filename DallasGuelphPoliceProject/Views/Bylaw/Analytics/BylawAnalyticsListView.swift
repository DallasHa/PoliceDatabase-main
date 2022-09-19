import SwiftUI

struct BylawAnalyticsListView: View {
    
    @State var analytics: [AnalyticRequest]
    
    var body: some View {
        
        VStack {
            
            List {
                
                ForEach(analytics, id: \.self) { analytic in
                    NavigationLink(analytic.title, destination: BylawAnalyticsView(analytic: analytic))
                    .buttonStyle(.borderedProminent)
                }
                
            }.listStyle(GroupedListStyle())
        }.navigationTitle("Predefined Analytics")
    }

}

struct BylawAnalyticsListView_Previews: PreviewProvider {
    static var previews: some View {
        BylawAnalyticsListView(analytics: [AnalyticRequest]())
    }
}
