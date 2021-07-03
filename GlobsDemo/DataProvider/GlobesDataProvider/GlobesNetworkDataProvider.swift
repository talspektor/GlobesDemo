//
//  NetworkDataProvider.swift
//  GlobsDemo
//
//  Created by Zemingo on 23/06/2021.
//

import Foundation
import NetworkLayer

struct GlobesNetworkDataProvider: GlobesDataProvider {
    
    let router = Router<GlobesEndPoint>()
    
    func fetchCars(completion: @escaping (Result<[GlobsModel], Error>) -> Void) {
        router.request(.cars) { networkResponseItem in
            ResponseHandler.handleWithDecoding([GlobsModel].self, networkResponseItem) { result in
                completion(result)
            }
        }
    }
    
    func fetchSport(completion: @escaping (Result<[GlobsModel], Error>) -> Void) {
        router.request(.sport) { networkResponseItem in
            ResponseHandler.handleWithDecoding([GlobsModel].self, networkResponseItem) { result in
                completion(result)
            }
        }
    }
    
    func fetchCulture(completion: @escaping (Result<[GlobsModel], Error>) -> Void) {
        router.request(.culture) { networkResponseItem in
            ResponseHandler.handleWithDecoding([GlobsModel].self, networkResponseItem) { result in
                completion(result)
            }
        }
    }
}
