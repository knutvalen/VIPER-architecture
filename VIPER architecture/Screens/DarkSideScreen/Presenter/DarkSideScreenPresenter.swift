class DarkSideScreenPresenter {
    private var darkSideScreenView: DarkSideScreenViewType?
    private var darkSideScreenInteractor: DarkSideScreenInteractorType?
    private var darkSideScreenRouter: DarkSideScreenRouterType?
    private var darkSideScreenSithHolocronList: [DarkSideScreenEntityType.SithHolocron]?
    private var interactorIsLoading: [String: Bool]?
    
    private func onSithCode(
        _ sithCode: DarkSideScreenEntityType.SithCode?,
        _ error: DarkSideScreenEntityType.Error?)
    {
        onLoaded(function: "onSithCode")
        
        if let sithCode = sithCode {
            view?.set(sithCode: sithCode)
        }
    }
    
    private func onSithHolocronList(
        _ sithHolocronList: [DarkSideScreenEntityType.SithHolocron]?,
        _ error: DarkSideScreenEntityType.Error?)
    {
        onLoaded(function: "onSithHolocronList")
        
        if let sithHolocronList = sithHolocronList {
            darkSideScreenSithHolocronList = sithHolocronList
            view?.refreshSithHolocronList()
        }
    }
    
    private func onLoaded(function: String) {
        guard var interactorIsLoading = interactorIsLoading else { return }
        interactorIsLoading[function] = false
        self.interactorIsLoading = interactorIsLoading
        
        for isLoading in interactorIsLoading.values {
            if isLoading == true { return }
        }
        
        self.interactorIsLoading = nil
        view?.set(loading: false)
        view?.set(title: "Welcome to the dark side")
    }
    
}

extension DarkSideScreenPresenter: DarkSideScreenPresenterType {
    var router: DarkSideScreenRouterType? {
        get {
            return darkSideScreenRouter
        }
        set {
            darkSideScreenRouter = newValue
        }
    }
    
    var sithHolocronList: [SithHolocronModel]? {
        get {
            return darkSideScreenSithHolocronList
        }
    }
    
    func viewDidAppear() {
        view?.set(loading: true)
        interactorIsLoading = ["onSithCode": true, "onSithHolocronList": true]
        interactor?.getCode(completionHandler: onSithCode, useCache: true)
        interactor?.getSithHolocronList(completionHandler: onSithHolocronList, useCache: true)
    }
    
    func viewDidDisappear() {
        view?.set(sithCode: nil)
        view?.set(title: nil)
        darkSideScreenSithHolocronList = nil
        view?.refreshSithHolocronList()
    }
    
    func onLightSideSelected() {
        router?.routeToLightSideScreen(from: view)
    }
    
    var view: DarkSideScreenViewType? {
        get {
            return darkSideScreenView
        }
        set {
            darkSideScreenView = newValue
        }
    }
    
    var interactor: DarkSideScreenInteractorType? {
        get {
            return darkSideScreenInteractor
        }
        set {
            darkSideScreenInteractor = newValue
        }
    }
    
}
