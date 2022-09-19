import SwiftUI

struct ByLawDetailView: View {
    
    @State var ticket: BylawTicket
    @State var violation: BylawViolation?
    @State var offcier: BylawOfficer?
    
    
    var body: some View {
        
        Form {
            
            HStack() {
                Spacer()
                Text("The \(ticket.getDay()) at \(ticket.getTime())")
                    .bold()
                Spacer()
            }
            
            HStack() {
                Text(" on \(ticket.street)")
                Spacer()
            }
            
            
            
            Section("Violation") {
                if let v = violation {
                    Text("Code: \(v.code)")
                    Text("Description:\n \(v.description)")
                    Text("Type: \(v.type)")
                }
            }
            
            Section("Officer") {
                if let o = offcier {
                    Text("Badge: \(o.badge)")
                    Text("Agency:\n \(o.agency)")
                }
            }
            
            Section("Vehicule") {
                Text("State: \(ticket.licenceState ?? "")")
                Text("Expiry: \(ticket.licenceExpiryDate ?? "")")
            }
            
            Section("Fine") {
                if let price = ticket.fine {
                    Text("$ \(price).00")
                } else {
                    Text("no price in the database")
                        .font(.footnote)
                }
            }
        }
    }
}

struct ByLawDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ByLawDetailView(ticket: BylawTicket(id: 1,
                                            date: "2018-04-30T01:31:00",
                                            violation: 12,
                                            street: "Street name",
                                            licenceState: "ON",
                                           fine: 50),
        violation: BylawViolation(id: 12, code: "(1984)-11440 SECTION 5", description: "PARK VEHICLE IN DISABLED PARKING SPACE - PERMIT NOT PROPERLY DISPLAYED", type: "(2002)-11440"),
        offcier: BylawOfficer(id: 1, badge: "1013", agency: "GUELPH POLICE"))
    }
}
