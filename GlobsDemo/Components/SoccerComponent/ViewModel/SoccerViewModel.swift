//
//  SoccerViewModel.swift
//  GlobsDemo
//
//  Created by Tal talspektor on 02/07/2021.
//

import Foundation
import Combine

class SoccerViewModel: BaseViewModel, ViewModelProtocol {
    typealias Provider = SoccerTeamsDataProvider
    
    var refreshData: (() -> Void)?
    var stopAnimate: (() -> Void)?
    var startAnimate: (() -> Void)?

    var dataModel = [Team]() {
        didSet {
            refreshData?()
        }
    }
    var lastSelection: String?

    private var spanishTeams = [Team]()
    private var englishTeams = [Team]()
    private var frenceTeams = [Team]()

    private(set) var dataProvider: SoccerTeamsDataProvider
    var timeInterval: TimeInterval {
        TimeInterval(5.0)
    }
    private(set) var cancellables = Set<AnyCancellable>()

    @Atomic private(set) var counter: Int = 0

    required init(dataProvider: SoccerTeamsDataProvider) {
        self.dataProvider = dataProvider
        self.dataModel = spanishTeams
        setCounter()
    }

    private func setCounter() {
        _counter.didSet = { [weak self] value in
            value == 0 ? self?.stopAnimate?() : self?.startAnimate?()
        }
    }

    func switchToEnglandAndFrance() {
        dataModel = englishTeams
        dataModel.append(contentsOf: frenceTeams)
    }

    func switchToSpain() {
        dataModel = spanishTeams
    }

    func fetchAll() {
        fetchSpanishLeague { [weak self] in
            guard let self = self else { return }
            self.dataModel = self.spanishTeams
            self.refreshData?()
        }
        fetchFrenchLeague()
        fetchEnglishLeague()
    }

    func fetchSpanishLeague(completion: (() -> Void)? = nil) {
        _counter.set(newValue: counter + 1)
        dataProvider.fetchSpanishLeague()
            .sink { [weak self] completion in
                guard let self = self else { return }
                self._counter.set(newValue: self.counter - 1)
                DispatchQueue.global().asyncAfter(deadline: .now() + self.timeInterval) { [weak self] in
                    self?.fetchSpanishLeague()
                }
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] (teamsResult) in
                self?.spanishTeams = teamsResult.teams
                completion?()
            }.store(in: &cancellables)
    }

    func fetchEnglishLeague() {
        _counter.set(newValue: counter + 1)
        dataProvider.fetchEnglishLeague()
            .sink { [weak self] completion in
                self?.decraceCount()
                guard let self = self else { return }
                self._counter.set(newValue: self.counter - 1)
                DispatchQueue.global().asyncAfter(deadline: .now() + self.timeInterval) { [weak self] in
                    self?.fetchEnglishLeague()
                }
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] (teamsResult) in
                self?.englishTeams = teamsResult.teams
            }.store(in: &cancellables)
    }

    func fetchFrenchLeague() {
        _counter.set(newValue: counter + 1)
        dataProvider.fetchFrenchLeague()
            .sink { [weak self] completion in
                self?.decraceCount()
                guard let self = self else { return }
                DispatchQueue.global().asyncAfter(deadline: .now() + self.timeInterval) { [weak self] in
                    self?.fetchFrenchLeague()
                }
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] (teamsResult) in
                self?.frenceTeams = teamsResult.teams
            }.store(in: &cancellables)
    }
    
    private func decraceCount() {
        _counter.set(newValue: counter - 1)
    }
}
