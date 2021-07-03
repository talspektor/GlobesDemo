//
//  GlobsInfoViewModel.swift
//  GlobsDemo
//
//  Created by Zemingo on 23/06/2021.
//

import Foundation

class GlobesInfoViewModel: BaseViewModel {
    
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
    
    private let dataProvider: GlobesDataProvider
    private let timeInterval = TimeInterval(5.0)

    @Atomic private var counter: Int = 0
        
    init(dataProvider: GlobesDataProvider) {
        self.dataProvider = dataProvider
        self.dataModel = carGlobsModels
        setCounter()
    }

    private func setCounter() {
        _counter.didSet = { [weak self] value in
            value == 0 ? self?.stopAnimate?() : self?.startAnimate?()
        }
    }
    
    func switchToSportAndCulture() {
        dataModel = sportGlobsModels
        dataModel.append(contentsOf: cultureGlobsModel)
    }
    
    func switchToCars() {
        dataModel = carGlobsModels
    }
    
    func fetchAll() {
        fetchCars { [weak self] in
            guard let self = self else { return }
            self.dataModel = self.carGlobsModels
            self.refreshData?()
        }
        fetchSport()
        fetchCulture()
    }
    
    func fetchCars(completion: (() -> Void)? = nil) {
        _counter.set(newValue: counter + 1)
        dataProvider.fetchCars { [weak self] result in
            guard let self = self else { return }
            self._counter.set(newValue: self.counter - 1)
            DispatchQueue.global().asyncAfter(deadline: .now() + self.timeInterval) { [weak self] in
                self?.fetchCars()
            }
            switch result {
            case .success(let carGlobsModels):
                self.carGlobsModels = carGlobsModels
                completion?()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchSport() {
        _counter.set(newValue: counter + 1)
        dataProvider.fetchSport { [weak self] result in
            guard let self = self else { return }
            self._counter.set(newValue: self.counter - 1)
            DispatchQueue.global().asyncAfter(deadline: .now() + self.timeInterval) { [weak self] in
                self?.fetchSport()
            }
            switch result {
            case .success(let sportGlobsModels):
                self.sportGlobsModels = sportGlobsModels
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchCulture() {
        _counter.set(newValue: counter + 1)
        dataProvider.fetchCulture { [weak self] result in
            guard let self = self else { return }
            self._counter.set(newValue: self.counter - 1)
            DispatchQueue.global().asyncAfter(deadline: .now() + self.timeInterval) { [weak self] in
                self?.fetchCulture()
            }
            switch result {
            case .success(let cultureGlobsModel):
                self.cultureGlobsModel = cultureGlobsModel
            case .failure(let error):
                print(error)
            }
        }
    }
}
