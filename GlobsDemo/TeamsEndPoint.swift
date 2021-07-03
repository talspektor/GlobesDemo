//
//  TeamsEndPoint.swift
//  GlobsDemo
//
//  Created by Tal talspektor on 02/07/2021.
//

import Foundation
import NetworkLayer

enum TeamsEndPoint: String, EndPointType {

    case france = "France"
    case spain = "Spain"
    case england = "England"

    var baseURL: URL {
        URL(string: "https://www.thesportsdb.com/api/v1/json/1/search_all_teams.php?s=Soccer&c=")!
    }

    var path: String {
        ""
    }

    var httpMethod: HTTPMethod {
        .get
    }

    var task: HTTPTask {
        .requestParametest(bodyParameters: nil, urlParanatars: queryParams)
    }

    var headers: HTTPHeaders? {
        nil
    }

    var body: Parameters? {
        nil
    }

    var queryParams: QueryParams? {
        ["s": "Soccer", "c": rawValue]
    }
}
