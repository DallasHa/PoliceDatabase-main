import SwiftUI

struct BylawTicketCellView: View {
    
    @EnvironmentObject var bylawService: BylawService
    
    @State var ticket: BylawTicket
    
    var body: some View {
        
        VStack {
            
            HStack {
                Text("The \(ticket.getDay()) at \(ticket.getTime())")
                    .bold()
            }
            
            VStack {
                HStack {
                    Text("Street")
                    Spacer()
                }
                HStack {
                    Spacer()
                    Text("\(ticket.street)")
                    Spacer()
                }
            }
            
            if let violationId = ticket.violation,
               let violation =  bylawService.getViolation(id: Int(violationId)) {
                VStack {
                    HStack {
                        Text("Violation")
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text("\(violation.description)")
                        Spacer()
                    }
                }
            }
            
            if let fine = ticket.fine {
                VStack {
                    HStack {
                        Text("Fine")
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text("$\(fine).00")
                        Spacer()
                    }
                }
            }
            
            Spacer()
        }
    }
}

struct BylawTicketCell_Previews: PreviewProvider {
    static var previews: some View {
        BylawTicketCellView(ticket:
                            BylawTicket(id: 1,
                                        date: "2018-04-30T01:31:00",
                                        violation: 12,
                                        street: "Street name",
                                       fine: 50))
        .environmentObject(BylawService())
    }
}
