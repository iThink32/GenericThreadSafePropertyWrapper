//
//  ThreadSafePropertyWrapper.swift
//
//  Created by N A Shashank on 09/07/21.
//

import Foundation

@propertyWrapper public class ThreadSafe<T>{
    private let concurrentQueue = PMDispatchQueue.concurrent
    private var value: T
    public init(wrappedValue: T) {
        self.value = wrappedValue
    }
    
    public var wrappedValue:T {
        set(newValue) {
            self.concurrentQueue.async(flags: .barrier) {[weak self] in
                self?.value = newValue
            }
        }
        get {
            return self.concurrentQueue.sync {
                return self.value
            }
        }
    }
}
