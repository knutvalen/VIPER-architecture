class DarkSideScreenEntity {
    private var sithCodeCache: SithCode?
    private var sithHolocronListCache: [SithHolocron]?
}

extension DarkSideScreenEntity: DarkSideScreenEntityType {
    var sithCode: SithCode? {
        get {
            return sithCodeCache
        }
        set {
            sithCodeCache = newValue
        }
    }
    
    var sithHolocronList: [SithHolocron]? {
        get {
            return sithHolocronListCache
        }
        set {
            sithHolocronListCache = newValue
        }
    }
    
}
