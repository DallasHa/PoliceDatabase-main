import Foundation

struct BylawTicket: Identifiable, Hashable {
    
    var id: Int
    var date: String
    var officer: Int64?
    var violation: Int64?
    var street: String
    var licenceState: String?
    var licenceExpiryDate: String?
    var fine: Int64?
    
    func getDay() -> String {
        
        return String(date.prefix(10))
    }
    
    func getTime() -> String {
        
        return String(date.suffix(8))
    }
    
}
