import SwiftUI

struct BylawSelectOfficerView: View {
    
    @EnvironmentObject var bylawService: BylawService
    
    @Binding var officerSelected: BylawOfficer?
    
    @State var search = ""
    
    var body: some View {
        
        VStack {
            
            List(bylawService.searchOfficers(with: search),id: \.self, selection: $officerSelected) { officer in
                VStack (alignment: .leading) {
                    Text("\(officer.badge)")
                    Text("\(officer.agency)")
                    Spacer()
                }
            }.searchable(text: $search)
            
            Spacer()
        }
    }
}

struct BylawSelectOfficerView_Previews: PreviewProvider {
    static var previews: some View {
        BylawSelectOfficerView(officerSelected: .constant(nil)).environmentObject(BylawService())
    }
}
