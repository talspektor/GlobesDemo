//
//  SoccerViewModel.swift
//  GlobsDemo
//
//  Created by Tal talspektor on 02/07/2021.
//

import Foundation

class SoccerViewModel: BaseViewModel {

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

    private let dataProvider: SoccerTeamsDataProvider
    private let timeInterval = TimeInterval(5.0)

    @Atomic private var counter: Int = 0

    init(dataProvider: SoccerTeamsDataProvider) {
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
        dataProvider.fetchSpanishLeague { [weak self] result in
            guard let self = self else { return }
            self._counter.set(newValue: self.counter - 1)
            DispatchQueue.global().asyncAfter(deadline: .now() + self.timeInterval) { [weak self] in
                self?.fetchSpanishLeague()
            }
            switch result {
            case .success(let teamsResult):
                self.spanishTeams = teamsResult.teams
                completion?()
            case .failure(let error):
                print(error)
            }
        }
    }

    func fetchEnglishLeague() {
        _counter.set(newValue: counter + 1)
        dataProvider.fetchEnglishLeague { [weak self] result in
            guard let self = self else { return }
            self._counter.set(newValue: self.counter - 1)
            DispatchQueue.global().asyncAfter(deadline: .now() + self.timeInterval) { [weak self] in
                self?.fetchEnglishLeague()
            }
            switch result {
            case .success(let teamsResult):
                self.englishTeams = teamsResult.teams
            case .failure(let error):
                print(error)
            }
        }
    }

    func fetchFrenchLeague() {
        _counter.set(newValue: counter + 1)
        dataProvider.fetchFrenchLeague { [weak self] result in
            guard let self = self else { return }
            self._counter.set(newValue: self.counter - 1)
            DispatchQueue.global().asyncAfter(deadline: .now() + self.timeInterval) { [weak self] in
                self?.fetchFrenchLeague()
            }
            switch result {
            case .success(let teamsResult):
                self.frenceTeams = teamsResult.teams
            case .failure(let error):
                print(error)
            }
        }
    }
}
