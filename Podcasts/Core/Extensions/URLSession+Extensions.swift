//
//  URLSession+Extensions.swift
//  Podcasts
//
//  Created by Alberto on 07/06/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

import Foundation
import Combine

enum RequestError: Error {
    case request(code: Int, error: Error?)
    case unknown
}

extension URLSession {
    
    func send(request: URLRequest) -> AnyPublisher<Data, RequestError> {
        return AnyPublisher { subscriber in
            let task = self.dataTask(with: request) { data, response, error in
                //TODO: main thread no creo que haga falta...
                DispatchQueue.main.async {
                    let httpReponse = response as? HTTPURLResponse
                    if let data = data, let httpReponse = httpReponse, 200..<300 ~= httpReponse.statusCode {
                        _ = subscriber.receive(data)
                        subscriber.receive(completion: .finished)
                    }
                    else if let httpReponse = httpReponse {
                        subscriber.receive(completion: .failure(.request(code: httpReponse.statusCode, error: error)))
                    }
                    else {
                        subscriber.receive(completion: .failure(.unknown))
                    }
                }
            }
            
            subscriber.receive(subscription: AnySubscription(task.cancel))
            task.resume()
        }
    }
    
}

extension JSONDecoder: TopLevelDecoder {}
