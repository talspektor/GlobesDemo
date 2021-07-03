//
//  GlobsInfoViewModel.swift
//  GlobsDemo
//
//  Created by Zemingo on 23/06/2021.
//

import Foundation

class GlobesInfoViewModel {
    
    enum State {
        case fatching
        case none
    }
    
    var refreshData: (() -> Void)?
    var stopAnimate: (() -> Void)?
    var startAnimate: (() -> Void)?
    var dataModel = [GlobsModel]() {
        didSet {
            refreshData?()
        }
    }
    
    var lastSelection: String?
    private var carGlobsModels = [GlobsModel]()
    private var sportGlobsModels = [GlobsModel]()
    private var cultureGlobsModel = [GlobsModel]()
    
    private let dataProvider: GlobesNetworkDataProvider
    private let timeInterval = TimeInterval(5.0)
    private var isFatching: Bool {
        isFetchingCars && isFetchingSport && isFetchingCulture
    }
    private var isFetchingCars = false
    private var isFetchingSport = false
    private var isFetchingCulture = false
        
    init(dataProvider: GlobesNetworkDataProvider) {
        self.dataProvider = dataProvider
        self.dataModel = carGlobsModels
    }
    
    func switchToSportAndCulture() {
        dataModel = sportGlobsModels
        dataModel.append(contentsOf: cultureGlobsModel)
    }
    
    func switchToCars() {
        dataModel = carGlobsModels
    }
    
    func fetchAll() {
        fetchCars {
            self.dataModel = self.carGlobsModels
        }
        fetchSport()
        fetchCulture()
    }
    
    func fetchCars(completion: (() -> Void)? = nil) {
        isFetchingCars = true
        if isFatching {
            stopAnimate?()
        }
        dataProvider.fetchCars { result in
            DispatchQueue.global().asyncAfter(deadline: .now() + self.timeInterval) {
                self.fetchCars()
            }
            switch result {
            case .success(let carGlobsModels):
                self.carGlobsModels = carGlobsModels
                completion?()
            case .failure(let error):
                print(error)
            }
            
            self.isFetchingCars = false
            if !self.isFatching {
                self.stopAnimate?()
            }
        }
    }
    
    func fetchSport() {
        isFetchingSport = true
        if isFatching {
            stopAnimate?()
        }
        dataProvider.fetchSport { result in
            DispatchQueue.global().asyncAfter(deadline: .now() + self.timeInterval) {
                self.fetchSport()
            }
            switch result {
            case .success(let sportGlobsModels):
                self.sportGlobsModels = sportGlobsModels
            case .failure(let error):
                print(error)
            }
            self.isFetchingSport = false
            if !self.isFatching {
                self.stopAnimate?()
            }
        }
    }
    
    func fetchCulture() {
        isFetchingCulture = true
        if isFatching {
            stopAnimate?()
        }
        dataProvider.fetchCulture { result in
            DispatchQueue.global().asyncAfter(deadline: .now() + self.timeInterval) {
                self.fetchCulture()
            }
            switch result {
            case .success(let cultureGlobsModel):
                self.cultureGlobsModel = cultureGlobsModel
            case .failure(let error):
                print(error)
            }
            self.isFetchingCulture = false
            if !self.isFatching {
                self.stopAnimate?()
            }
        }
    }
    
    deinit {
        print(String(describing: GlobesInfoViewModel.self))
    }
}
