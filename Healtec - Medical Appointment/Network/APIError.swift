enum APIError: Error {
    case invalidURL
    case server(Int)
    case decoding
    case unknown
}
