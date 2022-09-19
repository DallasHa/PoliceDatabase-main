import Foundation
import SQLite

final class PoliceInterventionRowMapper {
    
    static func intervention(row: Statement.Element) -> PoliceIntervention? {
        
        if
            let id = row[0] as? Int64,
            let occurrence = row[1] as? String,
            let city = row[2] as? String?,
            let address = row[3] as? String?,
            let reported = row[4] as? String,
            let division = row[5] as? String?,
            let dispatchType = row[6] as? Int64?,
            let occurrenceType = row[7] as? Int64?,
            let disposition = row[8] as? String?,
            let received = row[9] as? String?,
            let dispatched = row[10] as? String?,
            let arrived = row[11] as? String?,
            let cleared = row[12] as? String?,
            let delay = row[13] as? String?,
            let travel = row[14] as? String?,
            let onscene = row[15] as? String?,
            let response = row[16] as? String?,
            let related = row[17] as? String?

        {
            let row = PoliceIntervention(
                id: Int(id),
                interventionId: occurrence,
                city: city ?? "",
                address: address ?? "",
                reported: reported,
                division: division ?? "",
                dispatchType: dispatchType,
                occurrenceType: occurrenceType,
                disposition: disposition ?? "",
                received: received ?? "",
                dispatched: dispatched ?? "",
                arrived: arrived ?? "",
                cleared: cleared ?? "",
                delay: delay ?? "",
                travel: travel ?? "",
                onscene: onscene ?? "",
                response: response ?? "",
                related: related ?? ""
            )
            return row
        }
        return nil
    }
    
}
