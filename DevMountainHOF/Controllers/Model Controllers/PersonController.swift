//
//  PersonController.swift
//  DevMountainHOF
//
//  Created by Devin Singh on 1/23/20.
//  Copyright © 2020 Devin Singh. All rights reserved.
//

import Foundation

class PersonController {
    
    // MARK: - Constants
    
    static private let baseURL = URL(string: "https://ios-api.devmountain.com/api")
    static private let personEndpoint = "person"
    static private let peopleEndpoint = "people"
    static private let contentTypeKey = "Content-Type"
    static private let contentTypeValue = "application/json"
    
    // MARK: - Methods
    
    // POST
    
    static func postPerson(firstName: String, lastName: String, completion: @escaping (Result<Person, NetworkError>) -> Void) {
        // Prepare URL
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        let personURL = baseURL.appendingPathComponent(personEndpoint)
        print(personURL)
        
        // Prepare POST Request
        var request = URLRequest(url: personURL)
        request.httpMethod = "POST"
        // header
        request.addValue(contentTypeValue, forHTTPHeaderField: contentTypeKey)
        // body
        let postedPerson = Person(personID: nil, firstName: firstName, lastName: lastName)
        do {
            let data = try JSONEncoder().encode(postedPerson)
            request.httpBody = data
        } catch {
            print(error, error.localizedDescription)
            completion(.failure(.thrownError(error)))
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData))}
            
            do {
                let person = try JSONDecoder().decode([Person].self, from: data)
                completion(.success(person[0]))
            } catch {
                print(error, error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    
    
    // GET
    
    static func getPeople(completion: @escaping (Result<[Person], NetworkError>) -> Void) {
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL))}
        let peopleURL = baseURL.appendingPathComponent(peopleEndpoint)
        
        print(peopleURL)
        
        URLSession.shared.dataTask(with: peopleURL) { (data, _, error) in
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData))}
            
            do {
                let people = try JSONDecoder().decode([Person].self, from: data)
                return completion(.success(people))
            } catch {
                print(error, error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
}
