import Foundation

public extension Set {
    func parallelMap<T>(transform: @escaping (Element) async -> T) async -> Set<T> {
        await withTaskGroup(of: T.self) { group in
            for element in self {
                group.addTask {
                    await transform(element)
                }
            }
            var results: Set<T> = []
            for await converted in group {
                results.insert(converted)
            }
            return results
        }
    }
}
