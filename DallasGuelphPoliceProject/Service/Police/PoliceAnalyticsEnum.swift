import Foundation

enum PoliceAnalyticsEnum: Int, CaseIterable {
    
    case INTERVENTION_PER_STREET = 1
    
    var info: AnalyticRequest {
        switch self {
        case .INTERVENTION_PER_STREET:
            return AnalyticRequest(
                title: "Intervention percentage per street",
                sql: """
                        select  distinct address || ' in ' || city as l,
                                                cast(count(*) as text) as total,
                                                cast(round(100.00 * count(*) / (select count(*) from POLICE_Intervention), 2) as text) || '%' as percentage
                                                from POLICE_Intervention
                                                group by address || ' in ' || city
                                                order by count(*) desc
                                                limit 30;
                    """,
                columns: [AnalyticColumn(name: "l", order: 3),
                          AnalyticColumn(name: "total", order: 2),
                          AnalyticColumn(name: "percentage", order: 1)
                         ]
            )

        }
    }
}
