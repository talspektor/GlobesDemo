//
//  NetworkDataProvider.swift
//  GlobsDemo
//
//  Created by Zemingo on 23/06/2021.
//

import Foundation
import NetworkLayer
import Combine

struct GlobesNetworkDataProvider: GlobesDataProvider {
    
    let router = Router<GlobesEndPoint>()
    
    func fetchCars() -> AnyPublisher<[GlobesModel], Error> {
        router.request(.cars, type: [GlobesModel].self)
    }
    
    func fetchSport() -> AnyPublisher<[GlobesModel], Error> {
        router.request(.sport, type: [GlobesModel].self)
    }
    
    func fetchCulture() -> AnyPublisher<[GlobesModel], Error> {
        router.request(.culture, type: [GlobesModel].self)
    }
}
