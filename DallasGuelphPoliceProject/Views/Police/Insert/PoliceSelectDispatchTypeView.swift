import SwiftUI

struct PoliceSelectDispatchTypeView: View {
    
    @EnvironmentObject var service: PoliceService
    
    @Binding var dispatchSelected: PoliceDispatch?
    
    @State var search = ""
    
    var body: some View {
        
        VStack {
            
            List(service.searchDispatches(with: search),id: \.self, selection: $dispatchSelected) { dispatch in
                VStack (alignment: .leading) {
                    Text("\(dispatch.dispatch)")
                    Spacer()
                }
            }.searchable(text: $search)
            
            
            Spacer()
        }
    }
}

struct PoliceSelectDispatchTypeView_Previews: PreviewProvider {
    static var previews: some View {
        PoliceSelectDispatchTypeView(dispatchSelected: .constant(nil)).environmentObject(PoliceService())
    }
}
