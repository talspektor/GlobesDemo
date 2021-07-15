//
//  NeatworkSoccesrTeamDataProvider.swift
//  GlobsDemo
//
//  Created by Tal talspektor on 02/07/2021.
//

import Foundation
import NetworkLayer
import Combine

struct NetworkSoccesrTeamDataProvider: SoccerTeamsDataProvider {

    private let router = Router<TeamsEndPoint>()

    func fetchSpanishLeague() -> AnyPublisher<TeamsResult, Error> {
        router.request(.spain, type: TeamsResult.self)
    }

    func fetchEnglishLeague() -> AnyPublisher<TeamsResult, Error> {
        router.request(.england, type: TeamsResult.self)
    }

    func fetchFrenchLeague() -> AnyPublisher<TeamsResult, Error> {
        router.request(.france, type: TeamsResult.self)
    }
}
