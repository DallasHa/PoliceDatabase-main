import SwiftUI

struct PoliceInterventionDetailView: View {
    
    @State var intervention: PoliceIntervention
    @State var dispatch: PoliceDispatch?
    @State var occurrence: PoliceOccurrence?
    
    var body: some View {
        
        Form {
            
            HStack() {
                Spacer()
                Text("The \(intervention.getDay()) at \(intervention.getTime())")
                    .bold()
                Spacer()
            }
            
            HStack {
                Text("\(intervention.interventionId)")
                    .bold()
            }
            
            HStack() {
                Text(" on \(intervention.address)")
                Text(" in \(intervention.city)")
                if !intervention.disposition.isEmpty {
                    Text("Disposition: \(intervention.disposition)")
                }
                Spacer()
            }
            
            
            Section("Dispatch Type") {
                if let d = dispatch {
                    Text("\(d.dispatch)")
                }
            }
            
            Section("Occurrence Type") {
                if let o = occurrence {
                    Text("\(o.occurrence)")
                }
            }
            
            Section("Timeline") {
                
                PoliceInterventionTimeView(title: "Received", value: "\(intervention.received)")
                PoliceInterventionTimeView(title: "Dispatched", value: "\(intervention.dispatched)")
                PoliceInterventionTimeView(title: "Arrived", value: "\(intervention.arrived)")
                PoliceInterventionTimeView(title: "Cleared", value: "\(intervention.cleared)")
            }
            
            Section("Duration") {
                
                PoliceInterventionTimeView(title: "Delay", value: "\(intervention.delay)")
                PoliceInterventionTimeView(title: "Travel", value: "\(intervention.travel)")
                PoliceInterventionTimeView(title: "OnScene", value: "\(intervention.onscene)")
                PoliceInterventionTimeView(title: "Resonse", value: "\(intervention.response)")
            }
            
            Section("Links") {
                Text("With: \(intervention.related)")
            }
            
        }
    }
    
}

struct PoliceInterventionTimeView: View {
    var title: String
    var value: String
    
    var body: some View {
        
        HStack {
            Text(title)
            Spacer()
            Text(value).padding(.trailing)
        }
    }
}


//struct PoliceInterventionDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        InterventionDetailView()
//    }
//}
