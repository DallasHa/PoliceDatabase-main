import Foundation
import SQLite

final class BylawViolationRowMapper {
    
    static func violation(row: Statement.Element) -> BylawViolation? {
        
        if
            let id = row[0] as? Int64,
            let code = row[1] as? String,
            let description = row[2] as? String,
            let type = row[3] as? String
        {
            return BylawViolation(
                id: Int(id),
                code: code,
                description: description,
                type: type)
        }
        return nil
    }
    
}
