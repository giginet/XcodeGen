import Foundation
import JSONUtilities
import PathKit
import Yams

extension Dictionary where Key: JSONKey {
    public func json<T: NamedJSONDictionaryConvertible>(atKeyPath keyPath: JSONUtilities.KeyPath, invalidItemBehaviour: InvalidItemBehaviour<T> = .remove, parallel: Bool = false) async throws -> [T] {
        guard let dictionary = json(atKeyPath: keyPath) as JSONDictionary? else {
            return []
        }
        if parallel {
            let keys = Array(dictionary.keys)

            return try await withThrowingTaskGroup(of: Result<T, Error>.self, returning: [T].self) { group in
                for idx in 0..<count {
                    group.addTask {
                        do {
                            let key = keys[idx]
                            let jsonDictionary: JSONDictionary = try dictionary.json(atKeyPath: .key(key))
                            let item = try T(name: key, jsonDictionary: jsonDictionary)
                            return .success(item)
                        } catch {
                            return .failure(error)
                        }
                    }
                }
                var results: Array<T> = []
                for try await result in group {
                    let item = try result.get()
                    results.append(item)
                }
                return Array(results)
            }
        } else {
            var items: Array<T> = []
            for (key, _) in dictionary {
                let jsonDictionary: JSONDictionary = try dictionary.json(atKeyPath: .key(key))
                let item = try T(name: key, jsonDictionary: jsonDictionary)
                items.append(item)
            }
            return Array(items)
        }
    }

    public func json<T: NamedJSONConvertible>(atKeyPath keyPath: JSONUtilities.KeyPath, invalidItemBehaviour: InvalidItemBehaviour<T> = .remove) throws -> [T] {
        guard let dictionary = json(atKeyPath: keyPath) as JSONDictionary? else {
            return []
        }
        var items: [T] = []
        for (key, value) in dictionary {
            let item = try T(name: key, json: value)
            items.append(item)
        }
        return items
    }
}

public protocol NamedJSONDictionaryConvertible {

    init(name: String, jsonDictionary: JSONDictionary) throws
}

public protocol NamedJSONConvertible {

    init(name: String, json: Any) throws
}

extension JSONObjectConvertible {

    public init(path: Path) throws {
        let content: String = try path.read()
        if content == "" {
            try self.init(jsonDictionary: [:])
            return
        }
        let yaml = try Yams.load(yaml: content)
        guard let jsonDictionary = yaml as? JSONDictionary else {
            throw JSONUtilsError.fileNotAJSONDictionary
        }
        try self.init(jsonDictionary: jsonDictionary)
    }
}
