//
//  ViewModelProtocol.swift
//  GlobsDemo
//
//  Created by Tal Spektor on 14/07/2021.
//

import Foundation
import Combine

protocol ViewModelProtocol: LoaderHandlable, DataFetcherable {
    associatedtype Provider
    var refreshData: PassthroughSubject<Void, Never> { get }
    var lastSelection: String? { get set }
    var dataProvider: Provider { get }
    init(dataProvider: Provider)
}

protocol LoaderHandlable {
    var stopAnimate: (() -> Void)? { get }
    var startAnimate: (() -> Void)? { get }
}

protocol DataFetcherable {
    var timeInterval: TimeInterval { get }
    var cancellables: Set<AnyCancellable> { get }
    var counter: Int { get }
}
