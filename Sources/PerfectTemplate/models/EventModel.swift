import MongoDBStORM
class EventModel: MongoDBStORM {
    var _id : String = ""
    var slug : String = ""
    var name : String = ""

    override init() {
        super.init()
        _collection = "events"
    }

    func findAll(){

      do {
          let events = try self.find()
          print(events)
      } catch {

      }

    }
}
