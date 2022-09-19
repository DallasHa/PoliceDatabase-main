import Foundation

struct PoliceIntervention: Identifiable, Hashable {
    
    var id: Int
    var interventionId: String
    var city: String
    var address: String
    var reported: String
    var division: String
    var dispatchType: Int64?
    var occurrenceType: Int64?
    var disposition: String
    var received: String
    var dispatched: String
    var arrived: String
    var cleared: String
    var delay: String
    var travel: String
    var onscene: String
    var response: String
    var related: String

    
    func getDay() -> String {
        
        return String(reported.prefix(10))
    }
    
    func getTime() -> String {
        
        return String(reported.suffix(8))
    }
    
}
