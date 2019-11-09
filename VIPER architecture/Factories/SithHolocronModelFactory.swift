class SithHolocronModelFactory {
    static func build(
        name: String? = nil,
        creator: String? = nil,
        powers: [String]? = nil
    ) -> SithHolocronModel {
        return SithHolocronModel(
            name: name,
            creator: creator,
            powers: powers
        )
    }
    
}
