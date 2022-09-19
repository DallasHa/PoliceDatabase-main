import Foundation

final class PoliceService: ObservableObject {
    
    typealias T = PoliceIntervention
    
    let dbConnector = try! PoliceConnector(dbFile: policeDbFile)
    
    @Published var interventions:[T] = [T]()
    
    @Published var dispatches = [PoliceDispatch]()
    @Published var occurrences = [PoliceOccurrence]()
    
    init() {
        
        dispatches = dbConnector.getDispatches()
        occurrences = dbConnector.getOccurrences()
    }
    
    // MARK: MIN / MAX Dates for Search
    
    func getMinDate() -> Date? {
        
        return try? Date(dbConnector.getMinimumDate(), strategy: dateStrategyShort)
    }
    
    func getMaxDate() -> Date? {
        
        return try? Date(dbConnector.getMaximumDate(), strategy: dateStrategyShort)
    }
    
    // MARK: Search
    
    func searchDispatches(with: String) -> [PoliceDispatch] {
        
        if with.isEmpty {
            return dispatches
        }
        
        return dispatches.filter({$0.dispatch.uppercased().contains(with.uppercased())})
    }
    
    func searchOccurrences(with: String) -> [PoliceOccurrence] {
        
        if with.isEmpty {
            return occurrences
        }
        
        return occurrences.filter({$0.occurrence.uppercased().contains(with.uppercased())})
    }
    
    func getInterventionBetween(min: Date, max: Date) {
        
        interventions = dbConnector.getPoliceInterventionsBetween(min: min, max: max)
        print("Service: interventions between = \(interventions.count)")
    }
    
    func getDispatch(id: Int) -> PoliceDispatch? {
        
        return dispatches.first(where: {$0.id == id})
    }
    
    func getOccurrence(id: Int) -> PoliceOccurrence? {
        
        return occurrences.first(where: {$0.id == id})
    }
    
    // MARK: Insert
    
    func insertIntervention(intervention: PoliceIntervention) -> Bool {
        
        return dbConnector.insertIntervention(intervention: intervention)
    }
    
    // MARK: Analytics
    
    func getAnalyticData(analytic: AnalyticRequest) -> [[String:String]] {
        
        return dbConnector.getAnalyticsTicketsByStreet(analytic: analytic);
    }
    
}
