//
//  GlobsInfoViewModel.swift
//  GlobsDemo
//
//  Created by Zemingo on 23/06/2021.
//

import Foundation
import Combine

class GlobesInfoViewModel: BaseViewModel, ViewModelProtocol {
    
    typealias Provider = GlobesDataProvider
    
    var refreshData = PassthroughSubject<Void, Never>()
    var stopAnimate: (() -> Void)?
    var startAnimate: (() -> Void)?

    var dataModel = [GlobesModel]() {
        didSet {
            refreshData.send()
        }
    }
    
    var lastSelection: String?
    var timeInterval: TimeInterval {
        TimeInterval(5.0)
    }
    private(set) var cancellables = Set<AnyCancellable>()

    @Atomic private(set) var counter: Int = 0

    private var carGlobsModels = [GlobesModel]()
    private var sportGlobsModels = [GlobesModel]()
    private var cultureGlobsModel = [GlobesModel]()
    
    private(set) var dataProvider: GlobesDataProvider
        
    required init(dataProvider: GlobesDataProvider) {
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
            self.refreshData.send()
        }
        fetchSport()
        fetchCulture()
    }
    
    func fetchCars(completion: (() -> Void)? = nil) {
        _counter.set(newValue: counter + 1)
        
        dataProvider.fetchCars()
            .sink { [weak self] completion in
                guard let self = self else { return }
                self._counter.set(newValue: self.counter - 1)
                DispatchQueue.global().asyncAfter(deadline: .now() + self.timeInterval) { [weak self] in
                    self?.fetchCars()
                }
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] model in
                self?.carGlobsModels = model
                completion?()
            }.store(in: &cancellables)
    }
    
    func fetchSport() {
        _counter.set(newValue: counter + 1)
        
        dataProvider.fetchCars()
            .sink { [weak self] completion in
                guard let self = self else { return }
                self._counter.set(newValue: self.counter - 1)
                DispatchQueue.global().asyncAfter(deadline: .now() + self.timeInterval) { [weak self] in
                    self?.fetchSport()
                }
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] model in
                self?.sportGlobsModels = model
            }.store(in: &cancellables)
    }
    
    func fetchCulture() {
        _counter.set(newValue: counter + 1)
        
        dataProvider.fetchCars()
            .sink { [weak self] completion in
                guard let self = self else { return }
                self._counter.set(newValue: self.counter - 1)
                DispatchQueue.global().asyncAfter(deadline: .now() + self.timeInterval) { [weak self] in
                    self?.fetchCulture()
                }
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] model in
                self?.cultureGlobsModel = model
            }.store(in: &cancellables)
    }
}
