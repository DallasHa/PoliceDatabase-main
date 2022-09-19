import Foundation
import SQLite

final class PoliceDispatchRowMapper {
    
    static func dispatch(row: Statement.Element) -> PoliceDispatch? {
        
        if
            let id = row[0] as? Int64,
            let dispatch = row[1] as? String?
        {
            return PoliceDispatch(id: Int(id), dispatch: dispatch ?? "")
        }
        
        return nil
    }
    
}
