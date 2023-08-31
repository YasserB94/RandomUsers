//
//  UserRepository.swift
//  RandomUsers
//
//  Created by Yasser Bal on 01/09/2023.
//

import Foundation
//MARK: Protocol
protocol UserRepository {
    /// Fetches a single user and calls the completion handler with the result.
    ///
    /// - Parameter completion: A closure to be called when the operation completes, containing the result of the user fetch operation.
    ///
    /// Example:
    /// ```swift
    /// UserRepository.fetchUser { result in
    ///     switch result {
    ///     case .success(let user):
    ///         print("Fetched user: \(user)")
    ///     case .failure(let error):
    ///         print("Error fetching user: \(error)")
    ///     }
    /// }
    /// ```
    static func getUser(completion: @escaping (Result<User, Error>) -> Void)
    
    /// Fetches a single user asynchronously.
    ///
    /// - Returns: An instance of the fetched user.
    /// - Throws: A `NetworkError` if any network or decoding issues occur.
    ///
    /// Example:
    /// ```swift
    /// do {
    ///     let user = try await UserRepository.fetchUserAsync()
    ///     print("Fetched user: \(user)")
    /// } catch {
    ///     print("Error fetching user: \(error)")
    /// }
    /// ```
    static func getUserAsync() async throws -> User
    
    /// Fetches multiple users and calls the completion handler with the result.
    ///
    /// - Parameters:
    ///   - amount: The number of users to fetch.
    ///   - completion: A closure to be called when the operation completes, containing the result of the user fetch operation.
    ///
    /// Example:
    /// ```swift
    /// UserRepository.fetchMultipleUsers(amount: 5) { result in
    ///     switch result {
    ///     case .success(let users):
    ///         print("Fetched users: \(users)")
    ///     case .failure(let error):
    ///         print("Error fetching users: \(error)")
    ///     }
    /// }
    /// ```
    static func getMultipleUsers(amount: Int, completion: @escaping (Result<[User], Error>) -> Void)
    
    /// Fetches multiple users asynchronously.
    ///
    /// - Parameter amount: The number of users to fetch.
    /// - Returns: An array of fetched users.
    /// - Throws: A `NetworkError` if any network or decoding issues occur.
    ///
    /// Example:
    /// ```swift
    /// do {
    ///     let users = try await UserRepository.fetchMultipleUsersAsync(amount: 5)
    ///     print("Fetched users: \(users)")
    /// } catch {
    ///     print("Error fetching users: \(error)")
    /// }
    /// ```
    static func getMultipleUsersAsync(amount: Int) async throws -> [User]
}
//MARK: Repository
struct NetworkUserRepository: UserRepository {
        
    /// Constants related to the network API.
        private struct Constants {
            /// The base URL string for the Random Data API.
            ///
            /// This URL serves as the foundation for constructing API endpoints.
            /// For more information, refer to the [Random Data API Documentation](https://random-data-api.com/documentation).
            static let baseUrlString = "https://random-data-api.com/api/v2/users"
            
            /// The query parameter key for specifying the size of data to fetch.
            ///
            /// This query parameter is used to determine the number of users to retrieve.
            static let queryParamSize = "size"
        }
    
    /// The base URL for the API.
    ///
    /// This URL is used as the foundation for constructing various API endpoints.
    private static var baseUrl: URL {
        guard let baseUrl = URL(string: Constants.baseUrlString) else {
            fatalError("UserRepository - Invalid base URL")
        }
        return baseUrl
    }

    /// Constructs the URL for fetching multiple users with a specified amount.
    ///
    /// - Parameter amount: The number of users to fetch.
    /// - Returns: The URL for fetching users with the specified amount.
    static private func usersUrl(withAmount amount: Int) -> URL {
        var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)
        components?.queryItems = [URLQueryItem(name: Constants.queryParamSize, value: "\(amount)")]
        return components?.url ?? baseUrl
    }
    
  
}
//MARK: GET
extension NetworkUserRepository {
    
    static func getUser(completion: @escaping (Result<User, Error>) -> Void) {
        let url = baseUrl
        
        Task {
            do {
                let user: User = try await NetworkUtility.GET.andDecode(from: url, as: User.self)
                completion(.success(user))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    static func getUserAsync() async throws -> User {
        let user = try await NetworkUtility.GET.andDecode(from: baseUrl, as: User.self)
        return user
    }
    
    static func getMultipleUsers(amount: Int, completion: @escaping (Result<[User], Error>) -> Void) {
        let url = usersUrl(withAmount: amount)

        Task {
            do {
                let users: [User] = try await NetworkUtility.GET.andDecode(from: url, as: [User].self)
                completion(.success(users))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    static func getMultipleUsersAsync(amount: Int) async throws -> [User] {
        let url = usersUrl(withAmount: amount)
        let users = try await NetworkUtility.GET.andDecode(from: url, as: [User].self)
        return users
    }
}

