

import Foundation

class Event : Decodable{
    var name: String
    var date: Double
    
    
    init(json: [String: Any]) {
    name = json["name"] as? String ?? ""
    date = json["date"] as? Double ?? 0
        
    }
}
