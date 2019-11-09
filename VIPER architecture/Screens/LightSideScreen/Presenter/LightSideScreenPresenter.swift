class LightSideScreenPresenter {
    private var lightSideScreenView: LightSideScreenViewType?
    private var lightSideScreenInteractor: LightSideScreenInteractorType?
    private var lightSideScreenRouter: LightSideScreenRouterType?
    private var lightSideScreenJediList: [LightSideScreenEntityType.Jedi]?
    private var interactorIsLoading: [String: Bool]?
    
    private func onJediCode(
        _ jediCode: LightSideScreenEntityType.JediCode?,
        _ error: LightSideScreenEntityType.Error?)
    {
        onLoaded(function: "onJediCode")
        
        if let jediCode = jediCode {
            view?.set(jediCode: jediCode)
        }
    }
    
    private func onJediList(
        _ jediList: [LightSideScreenEntityType.Jedi]?,
        _ error: LightSideScreenEntityType.Error?)
    {
        onLoaded(function: "onJediList")
        
        if let jediList = jediList {
            lightSideScreenJediList = jediList
            view?.refreshJediList()
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
        view?.set(title: "Welcome to the light side")
    }
    
}

extension LightSideScreenPresenter: LightSideScreenPresenterType {
    var view: LightSideScreenViewType? {
        get {
            return lightSideScreenView
        }
        set {
            lightSideScreenView = newValue
        }
    }
    
    var interactor: LightSideScreenInteractorType? {
        get {
            return lightSideScreenInteractor
        }
        set {
            lightSideScreenInteractor = newValue
        }
    }
    
    var router: LightSideScreenRouterType? {
        get {
            return lightSideScreenRouter
        }
        set {
            lightSideScreenRouter = newValue
        }
    }
    
    var jediList: [LightSideScreenEntityType.Jedi]? {
        get {
            return lightSideScreenJediList
        }
    }
    
    func viewDidAppear() {
        view?.set(loading: true)
        interactorIsLoading = ["onJediCode": true, "onJediList": true]
        interactor?.getCode(completionHandler: onJediCode, useCache: true)
        interactor?.getJediList(completionHandler: onJediList, useCache: true)
    }
    
    func viewDidDisappear() {
        view?.set(jediCode: nil)
        view?.set(title: nil)
        lightSideScreenJediList = nil
        view?.refreshJediList()
    }
    
    func onDarkSideSelected() {
        router?.routeToDarkSideScreen(from: view)
    }
    
}
