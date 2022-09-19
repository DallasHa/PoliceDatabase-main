import SwiftUI

struct PoliceAnalyticsView: View {
   
    @EnvironmentObject var service: PoliceService
    
    @State var analytic: AnalyticRequest
    
    var body: some View {
        
        VStack {
            
            List {
                ForEach(service.getAnalyticData(analytic: analytic), id: \.self) { r in
                    HStack {
                        
                        ForEach(analytic.columns.sorted(by: {$0.order < $1.order}), id: \.self) { column in
                            Text("\(r[column.name] ?? "")")
                        }
                        
                        Spacer()
                    }
                }
            }.listStyle(GroupedListStyle())
            
            Spacer()
            
        }.navigationTitle(analytic.title)
        
    }
    
}

struct PoliceAnalyticsView_Previews: PreviewProvider {
    static var previews: some View {
        PoliceAnalyticsView(analytic:
                                AnalyticRequest(title: "", sql: "", columns: [AnalyticColumn]()))
                .environmentObject(PoliceService())
    }
}
