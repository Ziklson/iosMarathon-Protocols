import Foundation

protocol Hotel {
    var roomCount: Int { get }
    
    init(roomCount: Int)
}

class HotelAlfa: Hotel {
    var roomCount: Int
    
    required init(roomCount: Int) {
        self.roomCount = roomCount
    }
}