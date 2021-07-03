//
//  NeatworkSoccesrTeamDataProvider.swift
//  GlobsDemo
//
//  Created by Tal talspektor on 02/07/2021.
//

import Foundation
import NetworkLayer

struct NeatworkSoccesrTeamDataProvider: SoccerTeamsDataProvider {

    let router = Router<TeamsEndPoint>()

    func fetchSpanishLeague(completion: @escaping (Result<TeamsResult, Error>) -> Void) {
        router.request(.spain) { networkResponseItem in
            ResponseHandler.handleWithDecoding(TeamsResult.self, networkResponseItem) { result in
                completion(result)
            }
        }
    }

    func fetchEnglishLeague(completion: @escaping (Result<TeamsResult, Error>) -> Void) {
        router.request(.england) { networkResponseItem in
            ResponseHandler.handleWithDecoding(TeamsResult.self, networkResponseItem) { result in
                completion(result)
            }
        }
    }

    func fetchFrenchLeague(completion: @escaping (Result<TeamsResult, Error>) -> Void) {
        router.request(.france) { networkResponseItem in
            ResponseHandler.handleWithDecoding(TeamsResult.self, networkResponseItem) { result in
                completion(result)
            }
        }
    }
}
