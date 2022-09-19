import Foundation
import SQLite

final class PoliceOccurrenceRowMapper {
    
    static func occurrence(row: Statement.Element) -> PoliceOccurrence? {
        
        if
            let id = row[0] as? Int64,
            let occurrence = row[1] as? String?
        {
            return PoliceOccurrence(id: Int(id), occurrence: occurrence ?? "")
        }
        
        return nil
    }
    
}
