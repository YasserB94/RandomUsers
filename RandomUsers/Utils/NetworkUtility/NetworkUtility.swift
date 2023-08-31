//
//  NetworkUtility.swift
//  RandomUsers
//
//  Created by Yasser Bal on 31/08/2023.
//

import Foundation


/// This utility struct provides methods for handling various types of network requests and responses.
///
/// This struct contains sub-structs for different HTTP methods:
///
/// - `GET`: A collection of methods for performing asynchronous network GET requests and handling responses.
/// - `POST`: (To be implemented) A collection of methods for performing asynchronous network POST requests and handling responses.
/// - `PUT`: (To be implemented) A collection of methods for performing asynchronous network PUT requests and handling responses.
/// - `PATCH`: (To be implemented) A collection of methods for performing asynchronous network PATCH requests and handling responses.
/// - `DELETE`: (To be implemented) A collection of methods for performing asynchronous network DELETE requests and handling responses.
///
/// Refer to the respective sub-structs below for details on the available methods and their usage.
///
struct NetworkUtility {

    // MARK: - Internal Helper Function

    /// Validates the HTTP response status code and throws an error if necessary.
    ///
    /// - Parameters:
    ///   - response: The URL response to validate.
    ///   - data: The response data.
    ///
    /// - Throws: A `NetworkError` if the response status code indicates an error.
    internal static func validateHTTPResponseStatusCode(_ response: URLResponse?, data: Data) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        let statusCode = httpResponse.statusCode
        switch statusCode {
            case 200...299:
                // Success
                return
            case 300...399:
                throw NetworkError.redirection(httpStatusCode: statusCode)
            case 401:
                throw NetworkError.unauthorized
            case 403:
                throw NetworkError.forbidden
            case 404:
                throw NetworkError.notFound
            case 429:
                throw NetworkError.tooManyRequests
            case 500:
                throw NetworkError.internalServerError
            case 503:
                throw NetworkError.serviceUnavailable
            default:
                throw NetworkError.unknown(httpStatusCode: statusCode)
        }
    }
    
}
