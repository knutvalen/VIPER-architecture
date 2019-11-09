class LightSideScreenEntity {
    private var jediCodeCache: JediCode?
    private var jediListCache: [Jedi]?
}

extension LightSideScreenEntity: LightSideScreenEntityType {
    var jediList: [Jedi]? {
        get {
            return jediListCache
        }
        set {
            jediListCache = newValue
        }
    }
    
    var jediCode: JediCode? {
        get {
            return jediCodeCache
        }
        set {
            jediCodeCache = newValue
        }
    }
    
}
