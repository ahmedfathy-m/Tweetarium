//
//  Service.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 26/11/2022.
//

import Foundation

class NetworkService {
    // MARK: - SIGNLETON
    static let shared = NetworkService()
    private init() {
        session.configuration.urlCache = URLCache(memoryCapacity: 10485760, diskCapacity: 0)
    }
    
    // MARK: - URL SESSION
    let session = URLSession(configuration: .default)
    
    // MARK: - LOAD AND DECODE JSON DATA
    func loadData<T: Codable>(from route: NetworkingRoute, handler: ActivityHandler? = nil) async -> T? {
        
        // 1. CREATION
        guard let request = try? route.asURLRequest() else {
            handler?.present("Couldn't Construct URLRequest", type: .error)
            return nil
        }
        
        // 2. EXECUTION
        handler?.initLoader()
        let monitor = ServiceMonitor()
        var (data, response) = (Data(), URLResponse())
        
        do {
            (data, response) = try await session.data(for: request, delegate: monitor)
        } catch {
            handler?.present(error.localizedDescription, type: .error)
        }
        let logging = String(data: data, encoding: .utf8)
        handler?.deinitLoader()
//        print(logging)
        
        // 3. VALIDATION
        if let error = validateResponse(response) {
            handler?.present(error.localizedDescription, type: .error)
            return nil
        }
        
        // 4. DECODING
        var decodedData: T? = nil
        
        do {
            decodedData = try decodeData(data)
        } catch {
            handler?.present(error.localizedDescription, type: .error)
        }
        return decodedData
    }
    
    // MARK: - LOAD AND DECODE JSON DATA
    func fetchText(from route: NetworkingRoute, handler: ActivityHandler? = nil) async -> String? {
        
        // 1. CREATION
        guard let request = try? route.asURLRequest() else {
            handler?.present("Couldn't Construct URLRequest", type: .error)
            return nil
        }
        
        // 2. EXECUTION
        handler?.initLoader()
        let monitor = ServiceMonitor()
        var (data, response) = (Data(), URLResponse())
        
        do {
            (data, response) = try await session.data(for: request, delegate: monitor)
        } catch {
            handler?.present(error.localizedDescription, type: .error)
        }
        let logging = String(data: data, encoding: .utf8)
        handler?.deinitLoader()
        print(logging)
        
        // 3. VALIDATION
        if let error = validateResponse(response) {
            handler?.present(error.localizedDescription, type: .error)
            return nil
        }
        
        return logging
    }
    
    // MARK: - LOAD STRING
    func loadString(from route: NetworkingRoute) async throws -> String {
        
        // 1. CREATION
        let request = try route.asURLRequest()
        
        // 2. EXECUTION
        let monitor = ServiceMonitor()
        let (data, response) = try await session.data(for: request, delegate: monitor)
        let logging = String(data: data, encoding: .utf8)
        print(logging)
        
        // 3. VALIDATION
        if let error = validateResponse(response) {
            throw error
        }
        
        // 4. CONVERTING TO STRING
        return String(data: data, encoding: .utf8) ?? ""
    }
    
    // MARK: - HELPER FUNCTIONS
    private func validateResponse(_ response: URLResponse) -> ServiceError? {
        let statusCode = (response as! HTTPURLResponse).statusCode
        switch statusCode {
        case 400...499: return ServiceError.clientError(statusCode)
        case 500...599: return ServiceError.serverError(statusCode)
        default: return nil
        }
    }
    
    private func decodeData<T: Codable>(_ data: Data) throws -> T {
        let decoded = try JSONDecoder().decode(T.self, from: data)
        return decoded
    }
}
