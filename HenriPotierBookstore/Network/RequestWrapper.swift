//
//  RequestWrapper.swift
//  HPBookstore
//
//  Created by Nabil El khaddari on 04/03/2021.
//

import Foundation
import RxSwift

struct RequestWrapper {
    
    static func request<T: Decodable>(from urlRequest: URLRequest) -> Observable<T> {
        return Observable.create { observer -> Disposable in
            let task = URLSession.shared.dataTask(with: urlRequest) { data, response, _ in
                if let httpResponse = response as? HTTPURLResponse {
                    let statusCode = httpResponse.statusCode
                    do {
                        let data = data ?? Data()
                        if (200...299).contains(statusCode) {
                            let objects = try JSONDecoder().decode(T.self, from: data)
                            observer.onNext(objects)
                        } else {
                            observer.onError(APIError.errorCode(statusCode))
                        }
                    } catch {
                        observer.onError(APIError.decode)
                    }
                } else {
                    observer.onError(APIError.unknown)
                }
                observer.onCompleted()
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
