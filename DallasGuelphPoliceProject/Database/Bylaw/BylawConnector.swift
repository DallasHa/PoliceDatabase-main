import Foundation
import SQLite

enum dbError: Error {
    case dbNotFind
}

final class BylawConnector: DbConnectorProtocol {
    
    let ticketTable = "BYLAW_Ticket"
    let violationTable = "BYLAW_Violation"
    let officerTable = "BYLAW_Officer"
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
            let sql = "select min(date) as md from \(ticketTable)"
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
            let sql = "select max(date) as md from \(ticketTable)"
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
    
    // MARK: Search
    
    func getViolations() -> [BylawViolation] {
        
        print("Start get bylaw violation")
        
        var violations = [BylawViolation]()
        
        do {
            let sql = "select id, code, description, type from \(violationTable)"
            print("SQL = \(sql)")
            
            let stmt = try connection.prepare(sql)
            
            for row in stmt {
                if let violation = BylawViolationRowMapper.violation(row: row) {
                    violations.append(violation)
                } else {
                    print("Issue creating violation from db record")
                }
            }
            
            
            
        } catch {
            print("Error getting all bylaw violations: \(error)")
        }
        
        print("Violations loaded = \(violations.count)")
        return violations
    }
    
    func getOfficers() -> [BylawOfficer] {
        
        print("Start get bylaw officers")
        
        var values = [BylawOfficer]()
        
        do {
            let sql = "select id, badge, agency from \(officerTable)"
            print("SQL = \(sql)")
            
            let stmt = try connection.prepare(sql)
            
            for row in stmt {
                if let value = BylawOfficerRowMapper.officer(row: row) {
                    values.append(value)
                } else {
                    print("Issue creating officer from db record")
                }
            }
            
        } catch {
            print("Error getting all bylaw officers: \(error)")
        }
        
        print("Officers loaded = \(values.count)")
        return values
    }
    
    func getBylawTicketsBetween(min: Date, max: Date) -> [BylawTicket] {
        
        print("Start get bylaw tickets between date")
        
        var tickets = [BylawTicket]()
        
        do {
            
            let sql = "select * from \(ticketTable) where date(date) > '\(min)' and date(date) < '\(max)' order by date limit \(rowLimit)"
            print("SQL = \(sql)")
            
            let stmt = try connection.prepare(sql)
            
            for row in stmt {
                if let ticket = BylawTicketRowMapper.ticket(row: row) {
                    tickets.append(ticket)
                } else {
                    print("Issue creating ticket from db record")
                }
            }
            
        } catch {
            print("Error getting all bylaw tickets: \(error)")
        }
        
        print("tickets count = \(tickets.count)")
        return tickets
    }
    
    // MARK: Insert
    
    func insertTicket(ticket: BylawTicket) -> Bool {
        
        print("Start inserting ticket")
        
        do {
            
            var sql = "insert into \(ticketTable)(date, officer, violation, street, licence_state, licence_expiry_date, fine) values (";
            sql.append("'\(ticket.date)',")
            if ticket.officer != nil {
                sql.append("\(ticket.officer!),")
            } else {
                sql.append("null,")
            }
            if ticket.violation != nil {
                sql.append("\(ticket.violation!),")
            } else {
                sql.append("null,")
            }
            sql.append("'\(ticket.street)',")
            sql.append("'\(ticket.licenceState ?? "")',")
            sql.append("'\(ticket.licenceExpiryDate ?? "")',")
            sql.append("\(ticket.fine ?? 0)")
            sql.append(")")
            
            print("SQL = \(sql)")
            
            try connection.execute(sql)
            
        } catch {
            print("Error inserting ticket: \(error)")
            return false
        }
        
        print("tickets inserted")
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
