import FluentKit

final class CitySeed: Migration {
    init() { }

    func prepare(on database: Database) -> EventLoopFuture<Void> {
        let saves = [
            City(name: "Amsterdam", averageNumberOfPupils: 300),
            City(name: "New York", averageNumberOfPupils: 400)
        ].map { city -> EventLoopFuture<Void> in
            return city.save(on: database)
        }
        return .andAllSucceed(saves, on: database.eventLoop)
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.eventLoop.makeSucceededFuture(())
    }
}
