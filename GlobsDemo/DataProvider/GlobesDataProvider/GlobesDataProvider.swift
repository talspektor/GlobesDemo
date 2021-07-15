//
//  DataProvider.swift
//  GlobsDemo
//
//  Created by Zemingo on 23/06/2021.
//

import Foundation
import Combine

protocol GlobesDataProvider: DataProvider {
    func fetchCars() -> AnyPublisher<[GlobesModel], Error>
    func fetchSport() -> AnyPublisher<[GlobesModel], Error>
    func fetchCulture() -> AnyPublisher<[GlobesModel], Error>
}
