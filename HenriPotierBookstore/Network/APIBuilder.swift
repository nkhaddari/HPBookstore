//
//  APIBuilder.swift
//  HPBookstore
//
//  Created by Nabil El khaddari on 04/03/2021.
//

import Foundation

protocol APIBuilder {
    var urlRequest: URLRequest { get }
    var baseURL: URL { get }
    var path: String { get }
}
