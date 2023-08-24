//
//  UserDefaultRepository.swift
//  CineTracker
//
//  Created by Jorge Andrade on 22/08/2023.
//

import Foundation

class UserDefaultRepository<T: Equatable> {

    private let userDefaults: UserDefaults
    private let key: String

    init(
        userDefaults: UserDefaults = UserDefaults.standard,
        key: String
    ) {
        self.key = key
        self.userDefaults = userDefaults
    }

    func set(objects: [T]) {
        userDefaults.set(objects, forKey: key)
    }

    func getAll() -> [T] {
        (userDefaults.array(forKey: key) as? [T]) ?? []
    }

    func add(object: T) {
        var objects = getAll()
        objects.insert(object, at: 0)
        set(objects: objects)
    }

    func remove(object: T) {
        var objects = getAll()

        if let index = objects.firstIndex(where: { $0 == object }) {
            objects.remove(at: index)
            set(objects: objects)
        }
    }

    func reset() {
        userDefaults.removeObject(forKey: key)
    }
}
