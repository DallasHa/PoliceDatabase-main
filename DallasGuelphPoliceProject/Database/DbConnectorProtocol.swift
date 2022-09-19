import Foundation

protocol DbConnectorProtocol {
    
    func getMinimumDate() -> String
    func getMaximumDate() -> String
}
