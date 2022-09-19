import SwiftUI

struct BylawAnalyticsView: View {
    
    @EnvironmentObject var bylawService: BylawService
    
    @State var analytic: AnalyticRequest
    
    var body: some View {
        
        VStack {
            
            List {
                ForEach(bylawService.getAnalyticData(analytic: analytic), id: \.self) { r in
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

struct BylawAnalyticsView_Previews: PreviewProvider {
    static var previews: some View {
        BylawAnalyticsView(analytic:
                            AnalyticRequest(title: "", sql: "", columns: [AnalyticColumn]()))
            .environmentObject(BylawService())
    }
}
