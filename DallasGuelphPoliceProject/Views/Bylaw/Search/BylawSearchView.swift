import SwiftUI

struct BylawSearchView: View {
    
    @EnvironmentObject var bylawService: BylawService
    
    @State private var minDate = Date()
    @State private var maxDate = Date()
    
    var body: some View {
        
        VStack {
            
            VStack {
                VStack {
                    DatePicker(
                        "Chose Minimum Date",
                        selection: $minDate,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.automatic)
                    
                    DatePicker(
                        "Chose Maximum Date",
                        selection: $maxDate,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.automatic)
                }.padding(.horizontal)
            }
            
            Divider()
            
            // Result
            VStack {
                List {
                    ForEach(bylawService.tickets, id: \.self) { ticket in
                        NavigationLink(
                            destination:
                                ByLawDetailView(ticket: ticket,
                                                violation: bylawService.getViolation(id: Int(ticket.violation ?? -1)),
                                                offcier: bylawService.getOfficer(id: Int(ticket.officer ?? -1)))) {
                            BylawTicketCellView(ticket: ticket)
                        }
                    }
                }.listStyle(GroupedListStyle())
            }
            
            Spacer()
            
            // Count
            Group {
                Text("Result: \(bylawService.tickets.count) Limited to 100")
            }.padding(.bottom)
            
            // Button
            Button("Lauch search") {
                bylawService.getTicketsBetween(min: minDate, max: maxDate)
            }
            .disabled(maxDate < minDate)
            .buttonStyle(.bordered)
            
            
        }
        .navigationTitle("Bylaw Search")
        .onAppear() {
            minDate = bylawService.getMinDate() ?? Date()
            maxDate = bylawService.getMaxDate() ?? Date()
        }
    }
}

struct BylawViewAnalytics_Previews: PreviewProvider {
    static var previews: some View {
        BylawSearchView().environmentObject(BylawService())
    }
}
