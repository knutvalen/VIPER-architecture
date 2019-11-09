protocol WebServiceType {
    func request<Response>(
        path: String,
        method: String,
        completion: @escaping (Result<Response, ErrorResponse>) -> Void)
        where
        Response: Decodable
}
