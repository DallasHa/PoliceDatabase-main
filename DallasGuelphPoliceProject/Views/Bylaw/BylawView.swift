import SwiftUI

struct BylawView: View {
    
    var body: some View {
        
        VStack(alignment: .listRowSeparatorLeading) {
                        
            Spacer()
            
            NavigationLink("View Predefined Analytics", destination: BylawAnalyticsListView(analytics: BylawAnalyticsEnum.allCases.map({$0.info})))
                .foregroundColor(.blue)
                .buttonStyle(.bordered)
                .font(.title)
            
            Spacer()
            
            NavigationLink("Search", destination: BylawSearchView())
                .foregroundColor(.blue)
                .buttonStyle(.bordered)
                .font(.title)
            
            Spacer()

            NavigationLink("File Report", destination: BylawInsertView())
                .foregroundColor(.blue)
                .buttonStyle(.bordered)
                .font(.title)
            
            
            Spacer()
            
        }.navigationTitle("BYLAW")
    }
}

struct BylawView_Previews: PreviewProvider {
    static var previews: some View {
        BylawView()
    }
}
