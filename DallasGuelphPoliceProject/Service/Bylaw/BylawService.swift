import Foundation

final class BylawService: ObservableObject {
    
    typealias T = BylawTicket
    
    let dbConnector = try! BylawConnector(dbFile: bylawDbFile)
    
    @Published var tickets:[T] = [T]()
    
    @Published var violations = [BylawViolation]()
    @Published var officers = [BylawOfficer]()
    
    init() {
        
        violations = dbConnector.getViolations()
        officers = dbConnector.getOfficers()
    }
    
    // MARK: MIN / MAX Dates for Search
    
    func getMinDate() -> Date? {
        
        return try? Date(dbConnector.getMinimumDate(), strategy: dateStrategyShort)
    }
    
    func getMaxDate() -> Date? {
        
        return try? Date(dbConnector.getMaximumDate(), strategy: dateStrategyShort)
    }
    
    // MARK: Search
    
    func getTicketsBetween(min: Date, max: Date) {
        
        tickets = dbConnector.getBylawTicketsBetween(min: min, max: max)
        print("Service: tickets between = \(tickets.count)")
    }
    
    func searchViolations(with: String) -> [BylawViolation] {
        
        if with.isEmpty {
            return violations
        }
        
        return violations.filter({$0.description.uppercased().contains(with.uppercased())})
    }
    
    func getViolation(id: Int) -> BylawViolation? {
        
        return violations.first(where: {$0.id == id})
    }
    
    func searchOfficers(with: String) -> [BylawOfficer] {
        
        if with.isEmpty {
            return officers
        }
        
        return officers.filter({$0.badge.uppercased().contains(with.uppercased()) || $0.agency.uppercased().contains(with.uppercased())})
    }
    
    func getOfficer(id: Int) -> BylawOfficer? {
        
        return officers.first(where: {$0.id == id})
    }
    
    // MARK: Insert
    
    func insertTicket(ticket: BylawTicket) -> Bool {
        
        return dbConnector.insertTicket(ticket: ticket)
    }
    
    // MARK: Analytics
    
    func getAnalyticData(analytic: AnalyticRequest) -> [[String:String]] {
        
        return dbConnector.getAnalyticsTicketsByStreet(analytic: analytic);
    }
    
}
