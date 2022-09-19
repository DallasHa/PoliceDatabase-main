import SwiftUI

struct PoliceSelectOccurrenceTypeView: View {
    
    @EnvironmentObject var service: PoliceService
    
    @Binding var occurrenceSelected: PoliceOccurrence?
    
    @State var search = ""
    
    var body: some View {
        
        VStack {
            
            List(service.searchOccurrences(with: search),id: \.self, selection: $occurrenceSelected) { o in
                VStack (alignment: .leading) {
                    Text("\(o.occurrence)")
                    Spacer()
                }
            }.searchable(text: $search)
            
            
            Spacer()
        }
    }
}

struct PoliceSelectOccurrenceTypeView_Previews: PreviewProvider {
    static var previews: some View {
        PoliceSelectOccurrenceTypeView(occurrenceSelected: .constant(nil)).environmentObject(PoliceService())
    }
}
