import Foundation

struct AnalyticColumn: Hashable {
    
    let name: String
    let order: Int
}

struct AnalyticRequest: Hashable {
    
    let title: String
    let sql: String
    let columns: [AnalyticColumn]
}
