import UIKit

protocol LightSideScreenViewType {
    var presenter: LightSideScreenPresenterType? { get set }
    func set(title: String?)
    func set(jediCode: LightSideScreenEntityType.JediCode?)
    func set(loading isLoading: Bool)
    func refreshJediList()
}

protocol LightSideScreenInteractorType {
    var entity: LightSideScreenEntityType? { get set }
    var webService: WebServiceType? { get set }
    func getCode(completionHandler: @escaping JediCodeResponse, useCache: Bool)
    func getJediList(completionHandler: @escaping JediListResponse, useCache: Bool)
}

protocol LightSideScreenPresenterType {
    var view: LightSideScreenViewType? { get set }
    var interactor: LightSideScreenInteractorType? { get set }
    var router: LightSideScreenRouterType? { get set }
    var jediList: [LightSideScreenEntityType.Jedi]? { get }
    func viewDidAppear()
    func viewDidDisappear()
    func onDarkSideSelected()
}

protocol LightSideScreenEntityType {
    typealias JediCode = CodeModel
    typealias Jedi = JediModel
    typealias Error = ErrorResponse
    var jediCode: JediCode? { get set }
    var jediList: [Jedi]? { get set }
}

protocol LightSideScreenRouterType {
    static func create() -> UIViewController
    func routeToDarkSideScreen(from view: LightSideScreenViewType?)
}

typealias JediCodeResponse = (_ jediCode: LightSideScreenEntityType.JediCode?, _ error: LightSideScreenEntityType.Error?) -> Void
typealias JediListResponse = (_ jediList: [LightSideScreenEntityType.Jedi]?, _ error: LightSideScreenEntityType.Error?) -> Void
