import Foundation
import SQLite

final class BylawOfficerRowMapper {
    
    static func officer(row: Statement.Element) -> BylawOfficer? {
        
        if
            let id = row[0] as? Int64,
            let badge = row[1] as? String?,
            let agency = row[2] as? String?
        {
            return BylawOfficer(id: Int(id), badge: badge ?? "", agency: agency ?? "")
        }
        
        return nil
    }
    
}
