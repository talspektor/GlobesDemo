//
//  DataProvider.swift
//  GlobsDemo
//
//  Created by Zemingo on 23/06/2021.
//

import Foundation

protocol GlobesDataProvider {
    func fetchCars(completion: @escaping (Result<[GlobsModel], Error>) -> Void)
    func fetchSport(completion: @escaping (Result<[GlobsModel], Error>) -> Void)
    func fetchCulture(completion: @escaping (Result<[GlobsModel], Error>) -> Void)
}
