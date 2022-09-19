import SwiftUI

struct BylawInsertView: View {
    
    @EnvironmentObject var bylawService: BylawService
    
    @State var date = Date()
    @State var violation: BylawViolation?
    @State var officer: BylawOfficer?
    @State var street = ""
    @State var licenseState = ""
    @State var setLicenceExpiry = false
    @State var licenseExpiry = Date()
    
    @State private var showingAlert = false
    @State private var inserted = true
    
    @State var fine = 0
    
    var body: some View {
        
        Form {
            
            DatePicker(
                "Date",
                selection: $date,
                displayedComponents: [.date, .hourAndMinute]
            )
            .datePickerStyle(.automatic)
            
            TextField("Street", text: $street)
            
            Section("Violation") {
                
                NavigationLink("Chose violation", destination: BylawSelectViolationView(violationSelected: $violation))
                
                if violation != nil {
                    Text("\(violation?.description ?? "")")
                    Button("Remove violation") {
                        violation = nil
                    }
                }
            }
            
            Section("Officer") {
                
                NavigationLink("Chose officer", destination: BylawSelectOfficerView(officerSelected: $officer))
                
                if officer != nil {
                    Text("\(officer?.badge ?? "") from \(officer?.agency ?? "")")
                    Button("Remove officer") {
                        officer = nil
                    }
                }
            }
            
            Section("Vehicule") {
                
                TextField("License State", text: $licenseState)
                
                Toggle("Set Licence Expiry", isOn: $setLicenceExpiry)
                
                if setLicenceExpiry {
                    
                    DatePicker(
                        "Licence Expiry",
                        selection: $licenseExpiry,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.automatic)
                }
            }
            
            Section("Fine") {
                TextField("Fine", value: $fine, formatter: NumberFormatter())
            }
            
        }
        .navigationBarItems(trailing: Button("Save") {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:00"
            
            let dateFormatter2 = DateFormatter()
            dateFormatter2.dateFormat = "YYYY-MM-dd"
            
            let ticket = BylawTicket(id: UUID().hashValue,
                                     date: dateFormatter.string(from: date).replacingOccurrences(of: " ", with: "T"),
                                     officer: (officer == nil) ? nil : Int64(officer!.id),
                                     violation: (violation == nil) ? nil : Int64(violation!.id),
                                     street: street,
                                     licenceState: licenseState,
                                     licenceExpiryDate: (setLicenceExpiry) ? dateFormatter2.string(from: licenseExpiry) : "",
                                     fine: Int64(fine))
            
            inserted = bylawService.insertTicket(ticket: ticket)
            showingAlert.toggle()
        })
        .alert((inserted) ? "Ticket Inserted" : "Error inserting the ticket", isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}

struct BylawInsertView_Previews: PreviewProvider {
    static var previews: some View {
        BylawInsertView().environmentObject(BylawService())
    }
}
