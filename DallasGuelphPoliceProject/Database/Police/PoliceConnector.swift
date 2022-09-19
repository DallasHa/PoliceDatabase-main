import Foundation
import SQLite


final class PoliceConnector/*: DbConnectorProtocol*/ {
    
    let interventionTable = "POLICE_Intervention"
    let dispatchTable = "POLICE_Dispatch"
    let occurenceTable = "POLICE_Occurrence"
    let rowLimit = 100
    
    var connection: Connection
    
    init(dbFile: String) throws {
        
        guard let conn = SqliteHelper().getConnection(dbFile: dbFile) else {
            throw dbError.dbNotFind
        }
        connection = conn
    }

    // MARK: MIN / MAX Dates for Search
    
    func getMinimumDate() -> String {
        
        do {
            let sql = "select min(reported) as md from \(interventionTable)"
            print(sql)
            let md = Expression<String>("md")
            let stmt = try connection.prepare(sql)
            let dates = try stmt.prepareRowIterator().map({ $0[md] })
            return dates[0]
        } catch {
            print("Error getting the minimum Date")
        }
        
        return ""
    }
    
    func getMaximumDate() -> String {
        
        do {
            let sql = "select max(reported) as md from \(interventionTable)"
            print(sql)
            let md = Expression<String>("md")
            let stmt = try connection.prepare(sql)
            let dates = try stmt.prepareRowIterator().map({ $0[md] })
            return dates[0]
        } catch {
            print("Error getting the maximum Date")
        }
        
        return ""
    }
    
    private func getMaximumOccurrence() -> String {
        
        do {
            let sql = "select max(occurrence) as mo from \(interventionTable)"
            print(sql)
            let mo = Expression<String>("mo")
            let stmt = try connection.prepare(sql)
            let results = try stmt.prepareRowIterator().map({ $0[mo] })
            return results[0]
        } catch {
            print("Error getting the maximum occurence")
        }
        
        return ""
    }
    
    
    // MARK: Search
    
    func getDispatches() -> [PoliceDispatch] {
        
        print("Start get police dispatches")
        
        var dispatches = [PoliceDispatch]()
        
        do {
            let sql = "select id, dispatch from \(dispatchTable)"
            print("SQL = \(sql)")
            
            let stmt = try connection.prepare(sql)
            
            for row in stmt {
                if let dispatch = PoliceDispatchRowMapper.dispatch(row: row) {
                    dispatches.append(dispatch)
                } else {
                    print("Issue creating dispatch from db record")
                }
            }
            
            
            
        } catch {
            print("Error getting all police dispatch: \(error)")
        }
        
        print("Dispatches loaded = \(dispatches.count)")
        return dispatches
    }
    
    func getOccurrences() -> [PoliceOccurrence] {
        
        print("Start get police occurrences")
        
        var occurrences = [PoliceOccurrence]()
        
        do {
            let sql = "select id, occurrence from \(occurenceTable)"
            print("SQL = \(sql)")
            
            let stmt = try connection.prepare(sql)
            
            for row in stmt {
                if let occurrence = PoliceOccurrenceRowMapper.occurrence(row: row) {
                    occurrences.append(occurrence)
                } else {
                    print("Issue creating occurrence from db record")
                }
            }
            
            
            
        } catch {
            print("Error getting all police occurrences: \(error)")
        }
        
        print("Occurrences loaded = \(occurrences.count)")
        return occurrences
    }
    
    func getPoliceInterventionsBetween(min: Date, max: Date) -> [PoliceIntervention] {
        
        print("Start get police interventions between date")
        
        var results = [PoliceIntervention]()
        
        do {
            
            let sql = "select * from \(interventionTable) where date(reported) > '\(min)' and date(reported) < '\(max)' order by reported limit \(rowLimit)"
            print("SQL = \(sql)")
            
            let stmt = try connection.prepare(sql)
            
            for row in stmt {
                if let result = PoliceInterventionRowMapper.intervention(row: row) {
                    results.append(result)
                } else {
                    print("Issue creating intervention from db record")
                }
            }
            
        } catch {
            print("Error getting all police interventions: \(error)")
        }
        
        print("Interventions count = \(results.count)")
        return results
    }
    
    // MARK: Insert
    
    func insertIntervention(intervention: PoliceIntervention) -> Bool {
        
        print("Start inserting intervention")
        
        // We need the max occurrence
        let maxOccurrence = getMaximumOccurrence()

        if let number = Int(maxOccurrence.suffix(6)) {
            
            let nextOccurrence = "GU" + intervention.reported.prefix(4).suffix(2) + String(format: "%06d", (number + 1))
            
            do {
                
                var sql = "insert into \(interventionTable)(occurrence, city, address, reported, division, dispatch_type, occurrence_type, disposition, received, dispatched, arrived, cleared, delay, travel, onscene, response, related) values (";
                sql.append("'\(nextOccurrence)',")
                sql.append("'\(intervention.city)',")
                sql.append("'\(intervention.address)',")
                sql.append("'\(intervention.reported)',")
                sql.append("'\(intervention.division)',")
                
                if intervention.dispatchType != nil {
                    sql.append("\(intervention.dispatchType!),")
                } else {
                    sql.append("null,")
                }
                
                if intervention.occurrenceType != nil {
                    sql.append("\(intervention.occurrenceType!),")
                } else {
                    sql.append("null,")
                }
                
                sql.append("'\(intervention.disposition)',")
                
                sql.append("'\(intervention.received)',")
                sql.append("'\(intervention.dispatched)',")
                sql.append("'\(intervention.arrived)',")
                sql.append("'\(intervention.cleared)',")
                
                sql.append("'\(intervention.delay)',")
                sql.append("'\(intervention.travel)',")
                sql.append("'\(intervention.onscene)',")
                sql.append("'\(intervention.response)',")
                
                sql.append("'\(intervention.related)'")
                
                sql.append(")")
                
                print("SQL = \(sql)")
                
                try connection.execute(sql)
                
            } catch {
                print("Error inserting intervention: \(error)")
                return false
            }
        }
        print("intervention inserted")
        return true
    }
    
    
    // MARK: Analytics
    
    func getAnalyticsTicketsByStreet(analytic: AnalyticRequest) -> [[String: String]] {
        
        do {
            
            let stmt = try connection.prepare(analytic.sql)
            
            return try stmt.prepareRowIterator().map({
                
                var r = [String:String]()
                
                for column in analytic.columns {
                    r[column.name] = $0[Expression<String>(column.name)]
                }
                
                return r
                
            })
            
        } catch {
            print("Error retrieving tickets per year: \(error)")
        }
        
        return [[String:String]]()
    }
    
    
}
