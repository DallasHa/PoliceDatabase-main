import Foundation
import SQLite

final class SqliteHelper {
    
    func getConnection(dbFile: String) -> Connection? {
        
        do {
            let connection = try Connection(dbFile)
            print("We opened the DB")
            return connection
        } catch {
            print("Error opening the db: \(error)")
        }
        return nil
    }
}
