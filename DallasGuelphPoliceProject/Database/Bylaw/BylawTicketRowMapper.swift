import Foundation
import SQLite

final class BylawTicketRowMapper {
    
    static func ticket(row: Statement.Element) -> BylawTicket? {
        
        if
            let id = row[0] as? Int64,
            let date = row[1] as? String,
            let officer = row[2] as? Int64?,
            let violation = row[3] as? Int64?,
            let street = row[4] as? String,
            let ls = row[5] as? String?,
            let le = row[6] as? String?,
            let fine = row[7] as? Int64?
        {
            
            
            
            let t = BylawTicket(
                id: Int(id),
                date: date,
                officer: officer,
                violation: violation,
                street: street,
                licenceState: ls,
                licenceExpiryDate: le,
                fine: fine
            
            )
            
            return t
            
        }
        
        return nil
        
    }
    
}
