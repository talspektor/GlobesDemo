//
//  AtomicInteger.swift
//  GlobsDemo
//
//  Created by Tal talspektor on 02/07/2021.
//

import Foundation

@propertyWrapper
struct AtomicInteger<Value> {

    var wrappedValue: Value {
        get { return get() }
        set { set(newValue: newValue) }
    }
    var didSet: ((Value) -> Void)?

    private let lock = NSLock()
    private var value: Value {
        didSet {
            didSet?(value)
        }
    }

    init(wrappedValue value: Value) {
        self.value = value
    }

    func get() -> Value {
        lock.lock()
        defer { lock.unlock() }
        return value
    }

    mutating func set(newValue: Value) {
        lock.lock()
        defer { lock.unlock() }
        value = newValue
    }

    mutating public func increment() {
        guard var value = value as? Int else { return }
        lock.lock()
        value = value + 1
        lock.unlock()
    }

    mutating public func reduction() {
        guard var value = value as? Int else { return }
        lock.lock()
        value = value - 1
        lock.unlock()
    }
}
