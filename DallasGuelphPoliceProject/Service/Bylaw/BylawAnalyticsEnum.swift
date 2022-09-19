import Foundation

enum BylawAnalyticsEnum: Int, CaseIterable {
    
    case TICKETS_PER_STREET = 1
    
    var info: AnalyticRequest {
        switch self {
        case .TICKETS_PER_STREET:
            return AnalyticRequest(
                title: "Ticket percentage per street",
                sql: """
                        select  street,
                        cast(count(*) as text) as total,
                        cast(round(100.00 * count(*) / (select count(*) from BYLAW_Ticket), 2) as text) || '%' as percentage
                        from BYLAW_Ticket
                        group by street
                        order by count(*) desc
                        limit 30;
                    """,
                columns: [AnalyticColumn(name: "street", order: 3),
                          AnalyticColumn(name: "total", order: 2),
                          AnalyticColumn(name: "percentage", order: 1)
                         ]
            )

        }
    }
}
