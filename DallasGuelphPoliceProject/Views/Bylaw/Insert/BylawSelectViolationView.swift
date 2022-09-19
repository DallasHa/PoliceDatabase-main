import SwiftUI

struct BylawSelectViolationView: View {
    
    @EnvironmentObject var bylawService: BylawService
    
    @Binding var violationSelected: BylawViolation?
    
    @State var search = ""
    
    var body: some View {
        
        VStack {
            
            List(bylawService.searchViolations(with: search),id: \.self, selection: $violationSelected) { violation in
                VStack (alignment: .leading) {
                    Text("\(violation.code)")
                    Text("\(violation.description)")
                    Text("\(violation.type)")
                    Spacer()
                }
            }.searchable(text: $search)
            
            
            Spacer()
        }
    }
    
}

struct BylawSelectViolationView_Previews: PreviewProvider {
    static var previews: some View {
        BylawSelectViolationView(violationSelected: .constant(nil)).environmentObject(BylawService())
    }
}
