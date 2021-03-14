//
//  offerService.swift
//  HPBookstore
//
//  Created by Nabil El khaddari on 04/03/2021.
//

import Foundation
import RxSwift

protocol OfferServiceProtocol {
    func request(from endpoint: BooksApi) -> Observable<Offers>
}

class OfferService: OfferServiceProtocol {
    
    func request(from endpoint: BooksApi) -> Observable<Offers> {
        return RequestWrapper.request(from: endpoint.urlRequest)
    }
}
