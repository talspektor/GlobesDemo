//
//  GlobsEndPoint.swift
//  GlobsDemo
//
//  Created by Zemingo on 23/06/2021.
//

import Foundation
import NetworkLayer

enum GlobesEndPoint: String, EndPointType {

    case cars = "cars"
    case sport = "sports"
    case culture = "culture"
    
    var baseURL: URL {
        URL(string: "http://10.26.107.205:3000/api/globes/")!
    }
    
    var path: String {
        self.rawValue
    }

    var body: Parameters? {
        return nil
    }

    var queryParams: QueryParams? {
        return nil
    }

    var httpMethod: HTTPMethod {
        .get
    }
    
    var headers: HTTPHeaders? {
        ["":""]
    }

    var task: HTTPTask {
        return .request
    }
}
