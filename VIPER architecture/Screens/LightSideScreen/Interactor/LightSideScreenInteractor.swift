class LightSideScreenInteractor {
    private var lightSideScreenEntity: LightSideScreenEntityType?
    private var lightSideScreenWebService: WebServiceType?
}

extension LightSideScreenInteractor: LightSideScreenInteractorType {
    var webService: WebServiceType? {
        get {
            return lightSideScreenWebService
        }
        set {
            lightSideScreenWebService = newValue
        }
    }
    
    var entity: LightSideScreenEntityType? {
        get {
            return lightSideScreenEntity
        }
        set {
            lightSideScreenEntity = newValue
        }
    }
    
    func getCode(completionHandler: @escaping JediCodeResponse, useCache: Bool) {
        if let cache = entity?.jediCode,
            useCache == true
        {
            completionHandler(cache, nil)
            return
        }
        
        webService?.request(path: "light-side-service/jedi/code", method: "GET") {
            (result: Result<LightSideScreenEntityType.JediCode?, LightSideScreenEntityType.Error>) in
            switch result {
            case let .success(jediCode):
                self.entity?.jediCode = jediCode
                completionHandler(jediCode, nil)
                
            case let .failure(error):
                completionHandler(nil, error)
            }
        }
    }
    
    func getJediList(completionHandler: @escaping JediListResponse, useCache: Bool) {
        if let cache = entity?.jediList,
            useCache == true
        {
            completionHandler(cache, nil)
            return
        }
        
        webService?.request(path: "light-side-service/jedi-list", method: "GET") {
            (result: Result<[LightSideScreenEntityType.Jedi]?, LightSideScreenEntityType.Error>) in
            switch result {
            case let .success(jediList):
                self.entity?.jediList = jediList
                completionHandler(jediList, nil)
                
            case let .failure(error):
                completionHandler(nil, error)
            }
        }
    }
    
}
