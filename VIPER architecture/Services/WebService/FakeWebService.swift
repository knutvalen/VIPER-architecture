import Foundation

class FakeWebService {
    private func performFakeRequest(
        path: String,
        successCompletion: @escaping (Data?) -> Void)
    {
        if path.elementsEqual("light-side-service/jedi/code") {
            // Faking the networking request
            DispatchQueue.main.asyncAfter(deadline: .now() + randomDelay) {
                // Faking the networking response payload
                let jediCode = CodeModelFactory.build(
                    title: "The Jedi code",
                    rules: "There is no emotion, there is peace.\nThere is no ignorance, there is knowledge.\nThere is no passion, there is serenity.\nThere is no chaos, there is harmony.\nThere is no death, there is the Force."
                )
                let encoder = JSONEncoder()
                // encoding the fake response payload
                let data = try? encoder.encode(jediCode)
                successCompletion(data)
            }
        }
        
        if path.elementsEqual("light-side-service/jedi-list") {
            // Faking the networking request
            DispatchQueue.main.asyncAfter(deadline: .now() + randomDelay) {
                // Faking the networking response payload
                let obiWanKenobi = JediModelFactory.build(
                    firstName: "Obi-Wan",
                    lastName: "Kenobi"
                )
                let anakinSkywalker = JediModelFactory.build(
                    firstName: "Anakin",
                    lastName: "Skywalker"
                )
                let lukeSkywalker = JediModelFactory.build(
                    firstName: "Luke",
                    lastName: "Skywalker"
                )
                let yoda = JediModelFactory.build(
                    firstName: "Yoda"
                )
                let maceWindu = JediModelFactory.build(
                    firstName: "Mace",
                    lastName: "Windu")
                
                obiWanKenobi.apprentices = [
                    anakinSkywalker,
                    lukeSkywalker
                ]
                anakinSkywalker.apprentices = [
                    JediModelFactory.build(firstName: "Ahsoka", lastName: "Tano")
                ]
                lukeSkywalker.apprentices = [
                    JediModelFactory.build(firstName: "Ben", lastName: "Solo"),
                    JediModelFactory.build(firstName: "Rey")
                ]
                maceWindu.apprentices = []
                yoda.apprentices = [
                    obiWanKenobi,
                    anakinSkywalker,
                    lukeSkywalker,
                    maceWindu
                ]
                
                let jediList = [
                    obiWanKenobi,
                    anakinSkywalker,
                    lukeSkywalker,
                    yoda,
                    maceWindu
                ]
                
                let encoder = JSONEncoder()
                // encoding the fake response payload
                let data = try? encoder.encode(jediList)
                successCompletion(data)
            }
        }
        
        if path.elementsEqual("dark-side-service/sith/code") {
            // Faking the networking request
            DispatchQueue.main.asyncAfter(deadline: .now() + randomDelay) {
                // Faking the networking response payload
                let sithCode = CodeModelFactory.build(
                    title: "The Sith code",
                    rules: "Peace is a lie, there is only passion.\nThrough passion, I gain strength.\nThrough strength, I gain power.\nThrough power, I gain victory.\nThrough victory, my chains are broken.\nThe Force shall free me."
                )
                let encoder = JSONEncoder()
                // encoding the fake response payload
                let data = try? encoder.encode(sithCode)
                successCompletion(data)
            }
        }
        
        if path.elementsEqual("dark-side-service/sith/holocron-list") {
            // Faking the networking request
            DispatchQueue.main.asyncAfter(deadline: .now() + randomDelay) {
                // Faking the networking response payload
                let sithHolocronList = [
                    SithHolocronModelFactory.build(
                        name: "Holocron of Heresies",
                        creator: "Darth Andeddu",
                        powers: ["Essence transfer"]
                    ),
                    SithHolocronModelFactory.build(
                        name: "Holocron of Naga Sadow",
                        creator: "Naga Sadow",
                        powers: ["Dark rituals", "Sith alchemy"]
                    ),
                    SithHolocronModelFactory.build(
                        name: "Adas's holocron",
                        creator: "King Adas",
                        powers: ["Dark rituals"]
                    ),
                    SithHolocronModelFactory.build(
                        name: "Tulak Hord's holocron",
                        creator: "Tulak Hord"
                    ),
                    SithHolocronModelFactory.build(
                        name: "Lord Ergast's holocron",
                        creator: "Lord Ergast",
                        powers: ["Force walking"]
                    ),
                    SithHolocronModelFactory.build(
                        name: "Telos holocron",
                        powers: ["Sith history", "Code of the Sith", "Transcriptions from Darth Revan's holocron", "Dark rituals"]
                    ),
                ]
                
                let encoder = JSONEncoder()
                // encoding the fake response payload
                let data = try? encoder.encode(sithHolocronList)
                successCompletion(data)
            }
        }
    }
    
    private var randomDelay: Double {
        get {
            return Double.random(in: 0.5 ..< 2.0)
        }
    }
    
}

extension FakeWebService: WebServiceType {
    func request<Response>(
        path: String,
        method: String,
        completion: @escaping (Result<Response, ErrorResponse>) -> Void)
        where Response : Decodable
    {
        performFakeRequest(path: path, successCompletion: { data in
            if let responseData = data {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(Response.self, from: responseData)
                    completion(.success(result))
                } catch let error {
                    completion(.failure(.decodeError(error)))
                }
            }
        })
    }
    
}
