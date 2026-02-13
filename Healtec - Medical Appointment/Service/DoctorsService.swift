final class DoctorsService {
    
    func getDoctors() async throws -> [DoctorsModel] {
        try await ApiClient.shared.request(
            "https://healtec.onrender.com/doctors"
        )
    }
    
}
