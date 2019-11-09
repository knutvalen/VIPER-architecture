enum ErrorResponse: Error {
    case invalidResponse
    case decodeError(Error)
}
