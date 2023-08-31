//
//  NetworkError.swift
//  RandomUsers
//
//  Created by Yasser Bal on 31/08/2023.
//

import Foundation
/// Possible errors that can occur during network operations.
///
/// This enumeration defines various network-related errors that might arise during network requests and responses.
///
/// - Note: Developers can obtain more detailed information about each error by accessing the `description` property available on each enum case.
enum NetworkError: Error {
    /// The network request itself failed.
    case requestFailed(httpStatusCode: Int)
    /// The response from the server was invalid.
    case invalidResponse
    /// Decoding of the response data into the desired type failed.
    case decodingFailed
    /// The server returned a redirection response.
    case redirection(httpStatusCode: Int)
    /// The request requires authentication or the provided credentials are invalid.
    case unauthorized
    /// The client does not have permission to access the requested resource.
    case forbidden
    /// The requested resource was not found on the server.
    case notFound
    /// The client has sent too many requests in a given amount of time.
    case tooManyRequests
    /// An internal server error occurred on the server.
    case internalServerError
    /// The server is currently unavailable.
    case serviceUnavailable
    /// An unknown error occurred with the given HTTP status code.
    case unknown(httpStatusCode: Int)
    
    /// Returns a descriptive error message for the network error.
    ///
    /// This property can be accessed to obtain a more informative description of the network error.
    /// The description provides additional context about the error and the HTTP status code, if applicable.
    ///
    /// Example usage:
    /// ```
    /// do {
    ///     // Make a network request using NetworkUtility
    ///     // ...
    /// } catch let networkError as NetworkError {
    ///     print("Network Error: \(networkError.description)")
    /// } catch {
    ///     print("An unexpected error occurred: \(error)")
    /// }
    ///
    var description: String {
        switch self {
        case .requestFailed(let httpStatusCode):
            return "Network request failed with HTTP status code: \(httpStatusCode)"
        case .invalidResponse:
            return "Invalid response from the server"
        case .decodingFailed:
            return "Failed to decode the response data"
        case .redirection(let httpStatusCode):
            return "Redirection response received with HTTP status code: \(httpStatusCode)"
        case .unauthorized:
            return "Authentication required or credentials are invalid"
        case .forbidden:
            return "Permission denied for accessing the resource"
        case .notFound:
            return "Requested resource not found"
        case .tooManyRequests:
            return "Too many requests sent to the server"
        case .internalServerError:
            return "Internal server error"
        case .serviceUnavailable:
            return "Service is currently unavailable"
        case .unknown(let httpStatusCode):
            return "Unknown error occurred with HTTP status code: \(httpStatusCode)"
        }
    }
}
