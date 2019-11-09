class JediModelFactory {
    static func build(
        firstName: String? = nil,
        lastName: String? = nil,
        apprentices: [JediModel]? = nil
    ) -> JediModel {
        return JediModel(
            firstName: firstName,
            lastName: lastName,
            apprentices: apprentices
        )
    }
    
}
