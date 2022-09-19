import SwiftUI

struct PoliceSearchView: View {
    
    @EnvironmentObject var service: PoliceService
    
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
                    ForEach(service.interventions, id: \.self) { intervention in
                        NavigationLink(
                            destination:
                                PoliceInterventionDetailView(intervention: intervention,
                                                             dispatch: service.getDispatch(id: Int(intervention.dispatchType ?? -1)),
                                                             occurrence: service.getOccurrence(id: Int(intervention.occurrenceType ?? -1)))) {
                                                                 PoliceInterventionCellView(intervention: intervention)
                                                             }
                        
                    }
                }.listStyle(GroupedListStyle())
            }
            
            Spacer()
            
            // Count
            Group {
                Text("Result: \(service.interventions.count) Limited to 100")
            }.padding(.bottom)
            
            // Button
            Button("Lauch search") {
                service.getInterventionBetween(min: minDate, max: maxDate)
            }
            .disabled(maxDate < minDate)
            .buttonStyle(.bordered)
            
            
        }
        .navigationTitle("Police Search")
        .onAppear() {
            minDate = service.getMinDate() ?? Date()
            maxDate = service.getMaxDate() ?? Date()
        }
    }
}

struct PoliceSearchView_Previews: PreviewProvider {
    static var previews: some View {
        PoliceSearchView().environmentObject(PoliceService())
    }
}
