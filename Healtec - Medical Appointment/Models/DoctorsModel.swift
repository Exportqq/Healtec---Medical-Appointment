import UIKit

struct DoctorsModel: Decodable {
    let id: Int
    let name: String
    let specialty: String
    let rating: Double
    let photo: String
    let experience: String
    let patientsCount: String
    let reviewsCount: String
    let description: String
    let diseases: [String]
    
    var image: UIImage? {
        guard let imageData = imageData else { return nil }
        return UIImage(data: imageData)
    }
    
    private var imageData: Data? {
        guard let base64String = photo.components(separatedBy: ",").last else {
            return nil
        }
        return Data(base64Encoded: base64String)
    }
}
