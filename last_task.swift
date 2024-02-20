protocol Coding {
    var time: Int { get set }
    
    var code: Int { get set }
    
    func writeCode(platform: Platform, numberOfSpecialist: Int)
}

protocol Stopping {
    func stopCoding()
}

enum Platform {
    case ios, android, web
}

class Company: Coding, Stopping {
    var time: Int
    var code: Int
    var programmers: Int
    var specializations: [Platform]
    
    init(programmers: Int, specializations: [Platform]) {
        self.programmers = programmers
        self.specializations = specializations
        self.time = 0
        self.code = 0
    }
    
    func writeCode(platform: Platform, numberOfSpecialist: Int) {
        guard specializations.contains(platform) else {
            print("No specialists in \(platform)")
            return
        }
        
        guard numberOfSpecialist <= programmers else {
            print("There are not enough programmers")
            return
        }
        
        switch platform {
        case .ios:
            time += 10 * numberOfSpecialist
            code += 100 * numberOfSpecialist
        case .android:
            time += 15 * numberOfSpecialist
            code += 80 * numberOfSpecialist
        case .web:
            time += 5 * numberOfSpecialist
            code += 120 * numberOfSpecialist
        }
        
        print("Development has begun. Writing code \(platform)")
    }
    
    func stopCoding() {
        print("Development is complete. Sending for testing")
        
        print("Time spent: \(time) minutes")
        print("There's a \(code) lines code writting")
    }
}
var platforms = [Platform]()
platforms.append(Platform.ios)
platforms.append(Platform.android)
platforms.append(Platform.web)
print("-------------------------------------------------")
let vibeLab=Company(programmers: 15, specializations: platforms)
vibeLab.writeCode(platform: Platform.ios, numberOfSpecialist: 5)
vibeLab.stopCoding()
print("-------------------------------------------------")
vibeLab.writeCode(platform: Platform.android, numberOfSpecialist: 3)
vibeLab.stopCoding()
print("-------------------------------------------------")
vibeLab.writeCode(platform: Platform.web, numberOfSpecialist: 7)
vibeLab.stopCoding()