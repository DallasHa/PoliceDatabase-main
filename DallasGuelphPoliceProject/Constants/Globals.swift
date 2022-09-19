import Foundation

// MARK: DB FILE
let bylawDbFile = "/Users/Dallas/policeProject.db"

let policeDbFile = "/Users/Dallas/policeProject.db"

// MARK: DATE STRATEGIES
let dateStrategyShort = Date.ParseStrategy(format: "\(year: .defaultDigits)-\(month: .twoDigits)-\(day: .twoDigits)", timeZone: .current)
