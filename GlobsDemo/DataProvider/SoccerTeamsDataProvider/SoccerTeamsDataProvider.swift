//
//  SoccerTeamsDataProvider.swift
//  GlobsDemo
//
//  Created by Tal talspektor on 02/07/2021.
//

import Foundation

protocol SoccerTeamsDataProvider {
    func fetchSpanishLeague(completion: @escaping (Result<TeamsResult, Error>) -> Void)
    func fetchEnglishLeague(completion: @escaping (Result<TeamsResult, Error>) -> Void)
    func fetchFrenchLeague(completion: @escaping (Result<TeamsResult, Error>) -> Void)
}
