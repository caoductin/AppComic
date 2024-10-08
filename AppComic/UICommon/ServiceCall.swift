//
//  ServiceCall.swift
//  AppComic
//
//  Created by cao duc tin  on 25/9/24.
//

import SwiftUI

import SwiftUI
import UIKit

class ServiceCall {
    
    class func post(parameter: [String: Any], path: String, isToken: Bool = false,withSuccess: @escaping ( (_ responseObj: AnyObject?) ->() ), failure: @escaping ( (_ error: Error?) ->() ) ) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            // Prepare request
            guard let url = URL(string: path) else {
                DispatchQueue.main.async {
                    failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil))
                }
                return
            }

            // Serialize parameters as JSON
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: []) else {
                DispatchQueue.main.async {
                    failure(NSError(domain: "Invalid request body", code: 400, userInfo: nil))
                }
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 20)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.httpBody = httpBody
            
            // Add the token to the Authorization header if isToken is true
            if isToken, let accessToken = UserDefaults.standard.string(forKey: "access_token") {
                print("Access Token: \(accessToken)")
                request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            }

            // Make the network request
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
              
                if let error = error {
                    DispatchQueue.main.async {
                        failure(error)
                    }
                    return
                }

                guard let data = data else {
                    DispatchQueue.main.async {
                        failure(NSError(domain: "No data received", code: 400, userInfo: nil))
                    }
                    return
                }
                
                do {
                    // Parse the response as JSON
                    if let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                        // Handle cookies from the response
                        
                                             if let httpResponse = response as? HTTPURLResponse {
                                                 let cookies = HTTPCookie.cookies(withResponseHeaderFields: httpResponse.allHeaderFields as? [String: String] ?? [:], for: url)
                                                 for cookie in cookies {
                                                     if cookie.name == "access_token" {
                                                         // Access the access_token cookie here
                                                         UserDefaults.standard.setValue(cookie.value, forKey: "access_token")
//                                                         if let accessToken = UserDefaults.standard.string(forKey: "access_token") {
//                                                             print("Saved Access Token: \(accessToken)")
//                                                         }
//
//                                                         print("Access Token: \(cookie.value)")
                                                     }
                                                 }
                                             }
                        
                        DispatchQueue.main.async {
                            withSuccess(jsonDictionary)
                        }
                    } else {
                        DispatchQueue.main.async {
                            failure(NSError(domain: "Invalid response format", code: 400, userInfo: nil))
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        failure(error)
                    }
                }
            }

            task.resume()
        }
    }
    class func get(parameter: [String: Any], path: String, isToken: Bool = false, withSuccess: @escaping ( (_ responseObj: AnyObject?) ->() ), failure: @escaping ( (_ error: Error?) ->() )) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            // Build URL with query parameters
            var urlComponents = URLComponents(string: path)
            var queryItems: [URLQueryItem] = []
            
            for (key, value) in parameter {
                queryItems.append(URLQueryItem(name: key, value: "\(value)"))
            }
            urlComponents?.queryItems = queryItems

            guard let url = urlComponents?.url else {
                DispatchQueue.main.async {
                    failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil))
                }
                return
            }

            var request = URLRequest(url: url, timeoutInterval: 20)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            


            // Make the network request
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
              
                if let error = error {
                    DispatchQueue.main.async {
                        failure(error)
                    }
                    return
                }

                guard let data = data else {
                    DispatchQueue.main.async {
                        failure(NSError(domain: "No data received", code: 400, userInfo: nil))
                    }
                    return
                }
                
                do {
                    // Parse the response as JSON
                    if let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                        // Handle cookies from the response
                        
                        if let httpResponse = response as? HTTPURLResponse {
                            let cookies = HTTPCookie.cookies(withResponseHeaderFields: httpResponse.allHeaderFields as? [String: String] ?? [:], for: url)
                            for cookie in cookies {
                                if cookie.name == "access_token" {
                                    UserDefaults.standard.setValue(cookie.value, forKey: "access_token")
                                }
                            }
                        }
                        
                        DispatchQueue.main.async {
                            withSuccess(jsonDictionary)
                        }
                    } else {
                        DispatchQueue.main.async {
                            failure(NSError(domain: "Invalid response format", code: 400, userInfo: nil))
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        failure(error)
                    }
                }
            }

            task.resume()
        }
    }
    
    class func getComment(parameter: [String: Any], path: String, isToken: Bool = false, withSuccess: @escaping (AnyObject?) ->(), failure: @escaping (Error?) ->()) {

        DispatchQueue.global(qos: .userInitiated).async {

            // Build URL with query parameters
            var urlComponents = URLComponents(string: path)
            var queryItems: [URLQueryItem] = []

            for (key, value) in parameter {
                queryItems.append(URLQueryItem(name: key, value: "\(value)"))
            }
            urlComponents?.queryItems = queryItems

            guard let url = urlComponents?.url else {
                DispatchQueue.main.async {
                    failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil))
                }
                return
            }

            var request = URLRequest(url: url, timeoutInterval: 20)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            if isToken, let accessToken = UserDefaults.standard.string(forKey: "access_token") {
                print("Access Token: \(accessToken)")
                request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            }
            
            // Make the network request
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    DispatchQueue.main.async {
                        failure(error)
                    }
                    return
                }

                guard let data = data else {
                    DispatchQueue.main.async {
                        failure(NSError(domain: "No data received", code: 400, userInfo: nil))
                    }
                    return
                }
                
            
                
                do {
                    if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [NSDictionary] {
                        DispatchQueue.main.async {
                            withSuccess(jsonArray as AnyObject)
                        }
                    } else if let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                        DispatchQueue.main.async {
                            withSuccess(jsonDictionary)
                        }
                    } else {
                        DispatchQueue.main.async {
                            failure(NSError(domain: "Invalid response format", code: 400, userInfo: nil))
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        failure(error)
                    }
                }
            }


            task.resume()
        }
    }

    
    
    class func postCommment(parameter: [String: Any], path: String, isToken: Bool = false, withSuccess: @escaping (_ responseObj: AnyObject?) -> (), failure: @escaping (_ error: Error?) -> ()) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            guard let url = URL(string: path) else {
                DispatchQueue.main.async {
                    failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil))
                }
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 20)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            // Serialize parameters into JSON for the request body
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: []) else {
                DispatchQueue.main.async {
                    failure(NSError(domain: "Invalid request body", code: 400, userInfo: nil))
                }
                return
            }
            
            request.httpBody = httpBody
            
            // Add the token to the Authorization header if isToken is true
            if isToken, let accessToken = UserDefaults.standard.string(forKey: "access_token") {
                print("Access Token: \(accessToken)")
                request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            }
            
            // Start the network request
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    DispatchQueue.main.async {
                        failure(error)
                    }
                    return
                }
                
                // Log the response status code
                if let httpResponse = response as? HTTPURLResponse {
                    print("HTTP Status Code: \(httpResponse.statusCode)")
                    print("Response Headers: \(httpResponse.allHeaderFields)")
                }
                
                guard let data = data else {
                    DispatchQueue.main.async {
                        failure(NSError(domain: "No data received", code: 400, userInfo: nil))
                    }
                    return
                }
                
                do {
                    if let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                        DispatchQueue.main.async {
                            withSuccess(jsonDictionary)
                        }
                    } else {
                        DispatchQueue.main.async {
                            failure(NSError(domain: "Invalid response format", code: 400, userInfo: nil))
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        failure(error)
                    }
                }
            }
            
            task.resume()
        }
    }
    

    class func putComment(parameter: [String: Any], path: String, isToken: Bool = false, withSuccess: @escaping (_ responseObj: AnyObject?) -> (), failure: @escaping (_ error: Error?) -> ()) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            guard let url = URL(string: path) else {
                DispatchQueue.main.async {
                    failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil))
                }
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 20)
            request.httpMethod = "PUT" // Change to PUT
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            // Serialize parameters into JSON for the request body
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: []) else {
                DispatchQueue.main.async {
                    failure(NSError(domain: "Invalid request body", code: 400, userInfo: nil))
                }
                return
            }
            
            request.httpBody = httpBody
            
            // Add the token to the Authorization header if isToken is true
            if isToken, let accessToken = UserDefaults.standard.string(forKey: "access_token") {
                print("Access Token: \(accessToken)")
                request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            }
            
            // Start the network request
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    DispatchQueue.main.async {
                        failure(error)
                    }
                    return
                }
                
                // Log the response status code
                if let httpResponse = response as? HTTPURLResponse {
                    print("HTTP Status Code: \(httpResponse.statusCode)")
                    print("Response Headers: \(httpResponse.allHeaderFields)")
                }
                
                guard let data = data else {
                    DispatchQueue.main.async {
                        failure(NSError(domain: "No data received", code: 400, userInfo: nil))
                    }
                    return
                }
                
                do {
                    if let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                        DispatchQueue.main.async {
                            withSuccess(jsonDictionary)
                        }
                    } else {
                        DispatchQueue.main.async {
                            failure(NSError(domain: "Invalid response format", code: 400, userInfo: nil))
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        failure(error)
                    }
                }
            }
            
            task.resume()
        }
    }

    //this functioin call api delete
    class func delete(parameter: [String: Any], path: String, isToken: Bool = false, withSuccess: @escaping (_ responseObj: AnyObject?) -> (), failure: @escaping (_ error: Error?) -> ()) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            guard let url = URL(string: path) else {
                DispatchQueue.main.async {
                    failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil))
                }
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: 20)
            request.httpMethod = "DELETE" // Use DELETE method
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            // Serialize parameters into JSON for the request body, if necessary
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: []) else {
                DispatchQueue.main.async {
                    failure(NSError(domain: "Invalid request body", code: 400, userInfo: nil))
                }
                return
            }
            
            request.httpBody = httpBody
            
            // Add the token to the Authorization header if isToken is true
            if isToken, let accessToken = UserDefaults.standard.string(forKey: "access_token") {
                print("Access Token: \(accessToken)")
                request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            }
            
            // Start the network request
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    DispatchQueue.main.async {
                        failure(error)
                    }
                    return
                }
                
                // Log the response status code
                if let httpResponse = response as? HTTPURLResponse {
                    print("HTTP Status Code: \(httpResponse.statusCode)")
                    print("Response Headers: \(httpResponse.allHeaderFields)")
                }
                
                guard let data = data else {
                    DispatchQueue.main.async {
                        failure(NSError(domain: "No data received", code: 400, userInfo: nil))
                    }
                    return
                }
                
                do {
                    if let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                        DispatchQueue.main.async {
                            withSuccess(jsonDictionary)
                        }
                    } else {
                        DispatchQueue.main.async {
                            failure(NSError(domain: "Invalid response format", code: 400, userInfo: nil))
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        failure(error)
                    }
                }
            }
            
            task.resume()
        }
    }

    

}
