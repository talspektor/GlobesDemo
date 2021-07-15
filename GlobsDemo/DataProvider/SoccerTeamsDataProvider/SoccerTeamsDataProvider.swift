//
//  SoccerTeamsDataProvider.swift
//  GlobsDemo
//
//  Created by Tal talspektor on 02/07/2021.
//

import Foundation
import Combine

protocol SoccerTeamsDataProvider: DataProvider {
    func fetchSpanishLeague() -> AnyPublisher<TeamsResult, Error>
    func fetchEnglishLeague() -> AnyPublisher<TeamsResult, Error>
    func fetchFrenchLeague() -> AnyPublisher<TeamsResult, Error>
}
