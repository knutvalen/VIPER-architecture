class DarkSideScreenInteractor {
    private var darkSideScreenEntity: DarkSideScreenEntityType?
    private var darkSideScreenWebService: WebServiceType?
}

extension DarkSideScreenInteractor: DarkSideScreenInteractorType {
    var webService: WebServiceType? {
        get {
            return darkSideScreenWebService
        }
        set {
            darkSideScreenWebService = newValue
        }
    }
    
    func getCode(completionHandler: @escaping SithCodeResponse, useCache: Bool) {
        if let cache = entity?.sithCode,
            useCache == true
        {
            completionHandler(cache, nil)
            return
        }
        
        webService?.request(path: "dark-side-service/sith/code", method: "GET") {
            (result: Result<DarkSideScreenEntityType.SithCode?, DarkSideScreenEntityType.Error>) in
            switch result {
            case let .success(sithCode):
                self.entity?.sithCode = sithCode
                completionHandler(sithCode, nil)
                
            case let .failure(error):
                completionHandler(nil, error)
            }
        }
    }
    
    func getSithHolocronList(completionHandler: @escaping SithHolocronListResponse, useCache: Bool) {
        if let cache = entity?.sithHolocronList,
            useCache == true
        {
            completionHandler(cache, nil)
            return
        }
        
        webService?.request(path: "dark-side-service/sith/holocron-list", method: "GET") {
            (result: Result<[DarkSideScreenEntityType.SithHolocron]?, DarkSideScreenEntityType.Error>) in
            switch result {
            case let .success(sithHolocronList):
                self.entity?.sithHolocronList = sithHolocronList
                completionHandler(sithHolocronList, nil)
                
            case let .failure(error):
                completionHandler(nil, error)
            }
        }
    }
    
    var entity: DarkSideScreenEntityType? {
        get {
            return darkSideScreenEntity
        }
        set {
            darkSideScreenEntity = newValue
        }
    }
    
}
