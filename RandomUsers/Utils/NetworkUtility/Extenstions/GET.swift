//
//  Get.swift
//  RandomUsers
//
//  Created by Yasser Bal on 31/08/2023.
//

import Foundation

extension NetworkUtility{
    /// A utility struct for performing asynchronous network GET requests and handling responses.
    struct GET{
        /// Performs a network GET request asynchronously and returns the raw JSON data.
        /// - Parameters:
        ///   - url: The URL to make the GET request to.
        /// - Returns: Raw JSON data.
        /// - Throws: A `NetworkError` if any issues occur during the network request.
        ///
        /// Example usage:
        /// ```
        /// let url = URL(string: "https://api.example.com/data")!
        /// do {
        ///     let rawData: Data = try await NetworkUtility.GET.getRawJSON(from: url)
        ///     // Handle the raw JSON data
        /// } catch {
        ///     // Handle errors
        /// }
        /// ```
        static func getRawJSON(from url: URL) async throws -> Data {
            let request = URLRequest(url: url)
            var statusCode = -1
            
            do {
                let (data, response) = try await URLSession.shared.data(for: request)
                statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
                try validateHTTPResponseStatusCode(response, data: data)
                return data
            } catch let error as NetworkError {
                throw error
            } catch {
                // The network request itself failed.
                throw NetworkError.requestFailed(httpStatusCode: statusCode)
            }
        }
        
        /// Performs a network GET request asynchronously and decodes the response into the specified type.
        /// - Parameters:
        ///   - url: The URL to make the GET request to.
        ///   - type: The type to decode the response into.
        /// - Returns: An instance of the decoded type.
        /// - Throws: A `NetworkError` if any issues occur during the network request or decoding.
        ///
        /// Example usage:
        /// ```
        /// let url = URL(string: "https://api.example.com/data")!
        /// do {
        ///     let data: MyModel = try await NetworkUtility.getAsync(from: url, as: MyModel.self)
        ///     // Handle the retrieved data
        /// } catch {
        ///     // Handle errors
        /// }
        /// ```
        static func andDecode<T: Decodable>(from url: URL, as type: T.Type) async throws -> T {
            let request = URLRequest(url: url)
            var statusCode = -1

            do {
                let (data, response) = try await URLSession.shared.data(for: request)
                statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0

                try validateHTTPResponseStatusCode(response, data: data)
                
                let result = try JSONDecoder().decode(T.self, from: data)
                return result
            } catch is DecodingError {
                // Handle decoding error
                throw NetworkError.decodingFailed
            } catch {
                // Handle other errors, including network request failures
                throw NetworkError.requestFailed(httpStatusCode: statusCode)
            }
        }

        
        /// Performs an asynchronous network GET request and decodes the response into the specified type.
        /// - Parameters:
        ///   - url: The URL to make the GET request to.
        ///   - type: The type to decode the response into.
        ///   - completion: The completion handler called with the result or error.
        ///
        /// Example usage:
        /// ```
        /// let url = URL(string: "https://api.example.com/data")!
        /// NetworkUtility.getAsync(from: url, as: MyModel.self) { result in
        ///     switch result {
        ///     case .success(let data):
        ///         // Handle the retrieved data
        ///     case .failure(let error):
        ///         // Handle errors
        ///     }
        /// }
        /// ```
        static func andDecode<T: Decodable>(
            from url: URL,
            as type: T.Type,
            completion: @escaping (Result<T, NetworkError>) -> Void
        ) {
            let request = URLRequest(url: url)

            Task {
                do {
                    let (data, response) = try await URLSession.shared.data(for: request)

                    try validateHTTPResponseStatusCode(response, data: data)
                    
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(result))
                } catch is DecodingError {
                    // Handle decoding error
                    completion(.failure(NetworkError.decodingFailed))
                } catch let networkError as NetworkError {
                    // Handle network error
                    completion(.failure(networkError))
                } catch {
                    // Handle other errors
                    completion(.failure(.requestFailed(httpStatusCode: 0)))
                }
            }
        }
    }
    
}
