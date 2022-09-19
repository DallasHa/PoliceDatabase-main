import SwiftUI

struct PoliceInsertView: View {
    
    @EnvironmentObject var service: PoliceService
    
    @State var dispatchType: PoliceDispatch?
    @State var occurrenceType: PoliceOccurrence?
    @State var city = ""
    @State var address = ""
    
    @State var reported = Date()
    @State var division = ""
    @State var disposition = ""
    
    @State var received = Date()
    @State var dispatched = Date()
    @State var arrived = Date()
    @State var cleared = Date()
    
    @State var delay = ""
    @State var travel = ""
    @State var onscene = ""
    @State var response = ""
    
    @State var related = ""
    

    @State private var showingAlert = false
    @State private var inserted = true
    
    @State var fine = 0
    
    var body: some View {
        
        Form {
            
            DatePicker(
                "Reported",
                selection: $reported,
                displayedComponents: [.date, .hourAndMinute]
            )
            .datePickerStyle(.automatic)
            
            Group {
                TextField("Street", text: $address)
                TextField("City", text: $city)
                
                TextField("Division", text: $division)
                TextField("Disposition", text: $disposition)
            }
            
        
            Section("Dispatch Type") {
                
                NavigationLink("Chose Dispatch Type", destination: PoliceSelectDispatchTypeView(dispatchSelected: $dispatchType))
                
                if dispatchType != nil {
                    Text("\(dispatchType?.dispatch ?? "")")
                    Button("Remove dispatch") {
                        dispatchType = nil
                    }
                }
            }
            
            Section("Occurrence Type") {
                
                NavigationLink("Chose Occurrence Type", destination: PoliceSelectOccurrenceTypeView(occurrenceSelected: $occurrenceType))
                
                if occurrenceType != nil {
                    Text("\(occurrenceType?.occurrence ?? "")")
                    Button("Remove occurrence") {
                        occurrenceType = nil
                    }
                }
            }
            
            Section("Timeline") {
                
                DatePicker(
                    "Received",
                    selection: $received,
                    displayedComponents: [.date, .hourAndMinute]
                )
                .datePickerStyle(.automatic)
                
                DatePicker(
                    "Dispatched",
                    selection: $dispatched,
                    displayedComponents: [.date, .hourAndMinute]
                )
                .datePickerStyle(.automatic)
                
                DatePicker(
                    "Arrived",
                    selection: $arrived,
                    displayedComponents: [.date, .hourAndMinute]
                )
                .datePickerStyle(.automatic)
                
                DatePicker(
                    "Cleared",
                    selection: $cleared,
                    displayedComponents: [.date, .hourAndMinute]
                )
                .datePickerStyle(.automatic)
            }
            
            Section("Duration") {
                
                TextField("Delay", text: $delay)
                TextField("Travel", text: $travel)
                TextField("OnScene", text: $onscene)
                TextField("Response", text: $response)
            }
           
            TextField("Related with:", text: $related)
           
        }
        .navigationBarItems(trailing: Button("Save") {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:00"
            
            let intervention = PoliceIntervention(id: UUID().hashValue,
                                                  interventionId: "",
                                                  city: city,
                                                  address: address,
                                                  reported: dateFormatter.string(from: reported).replacingOccurrences(of: " ", with: "T"),
                                                  division: division,
                                                  dispatchType: (dispatchType == nil) ? nil : Int64(dispatchType!.id),
                                                  occurrenceType: (occurrenceType == nil) ? nil : Int64(occurrenceType!.id),
                                                  disposition: disposition,
                                                  received: dateFormatter.string(from: received).replacingOccurrences(of: " ", with: "T"),
                                                  dispatched: dateFormatter.string(from: dispatched).replacingOccurrences(of: " ", with: "T"),
                                                  arrived: dateFormatter.string(from: arrived).replacingOccurrences(of: " ", with: "T"),
                                                  cleared: dateFormatter.string(from: cleared).replacingOccurrences(of: " ", with: "T"),
                                                  delay: delay,
                                                  travel: travel,
                                                  onscene: onscene,
                                                  response: response,
                                                  related: related)
            
            inserted = service.insertIntervention(intervention: intervention)
            showingAlert.toggle()
            
        })
        .alert((inserted) ? "Intervention Inserted" : "Error inserting the intervention", isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}

struct PoliceInsertView_Previews: PreviewProvider {
    static var previews: some View {
        PoliceInsertView()
    }
}
