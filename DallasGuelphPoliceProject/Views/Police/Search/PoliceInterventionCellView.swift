import SwiftUI

struct PoliceInterventionCellView: View {
   
    @EnvironmentObject var service: PoliceService
    
    @State var intervention: PoliceIntervention
    
    var body: some View {
        
        VStack {
            
            HStack {
                Text("The \(intervention.getDay()) at \(intervention.getTime())")
                    .bold()
            }
            
            HStack {
                Text("\(intervention.interventionId)")
                    .bold()
            }
            
            VStack {
                HStack {
                    Text("Street")
                    Spacer()
                }
                HStack {
                    Spacer()
                    Text("\(intervention.address)")
                    Text(" in \(intervention.city)")
                    Spacer()
                }
            }
            
            if let dispatchId = intervention.dispatchType,
               let dispatch =  service.getDispatch(id: Int(dispatchId)) {
                VStack {
                    HStack {
                        Text("Dispatch")
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text("\(dispatch.dispatch)")
                        Spacer()
                    }
                }
            }
            
            if let occurrenceId = intervention.occurrenceType,
               let occurrence =  service.getOccurrence(id: Int(occurrenceId)) {
                VStack {
                    HStack {
                        Text("Occurrence")
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text("\(occurrence.occurrence)")
                        Spacer()
                    }
                }
            }
            
            Spacer()
        }
    }
    
}

struct PoliceInterventionCellView_Previews: PreviewProvider {
    static var previews: some View {
        PoliceInterventionCellView(intervention:
                                    PoliceIntervention(id: 1,
                                                       interventionId: "GU22000012",
                                                       city: "GUELPH",
                                                       address: "Street Name",
                                                       reported: "2018-04-30T01:31:00",
                                                       division: "61",
                                                      disposition: "",
                                                      received: "",
                                                      dispatched: "",
                                                      arrived: "",
                                                      cleared: "",
                                                      delay: "",
                                                      travel: "",
                                                      onscene: "",
                                                      response: "",
                                                      related: ""))
    }
}
