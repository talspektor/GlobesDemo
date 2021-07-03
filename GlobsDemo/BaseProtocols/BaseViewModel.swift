//
//  BaseViewModel.swift
//  GlobsDemo
//
//  Created by Tal talspektor on 03/07/2021.
//

import UIKit

protocol BaseViewModel {

}

protocol ViewModel {
    func getViewModel<T>(type: T.Type, viewModelType: ViewModelType) -> T
}

extension ViewModel where Self: BaseViewController {
    func getViewModel<T>(type: T.Type, viewModelType: ViewModelType) -> T {
        viewModelType.viewModel as! T
    }
}

enum ViewModelType {
    case user
    case soccer(dataProvider: SoccerTeamsDataProvider)
    case globes(dataProvider: GlobesDataProvider)

    var viewModel: BaseViewModel {
        switch self {
        case .soccer(let provider):
            return SoccerViewModel(dataProvider: provider)
        case .user:
            return UserViewModel()
        case .globes(let provider):
            return GlobesInfoViewModel(dataProvider: provider)
        }
    }
}
