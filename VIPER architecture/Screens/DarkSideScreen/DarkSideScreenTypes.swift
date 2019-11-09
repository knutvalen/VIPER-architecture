import UIKit

protocol DarkSideScreenViewType {
    var presenter: DarkSideScreenPresenterType? { get set }
    func set(title: String?)
    func set(sithCode: DarkSideScreenEntityType.SithCode?)
    func set(loading isLoading: Bool)
    func refreshSithHolocronList()
}

protocol DarkSideScreenInteractorType {
    var entity: DarkSideScreenEntityType? { get set }
    var webService: WebServiceType? { get set }
    func getCode(completionHandler: @escaping SithCodeResponse, useCache: Bool)
    func getSithHolocronList(completionHandler: @escaping SithHolocronListResponse, useCache: Bool)
}

protocol DarkSideScreenPresenterType {
    var view: DarkSideScreenViewType? { get set }
    var interactor: DarkSideScreenInteractorType? { get set }
    var router: DarkSideScreenRouterType? { get set }
    var sithHolocronList: [DarkSideScreenEntityType.SithHolocron]? { get }
    func viewDidAppear()
    func viewDidDisappear()
    func onLightSideSelected()
}

protocol DarkSideScreenEntityType {
    typealias SithCode = CodeModel
    typealias SithHolocron = SithHolocronModel
    typealias Error = ErrorResponse
    var sithCode: SithCode? { get set }
    var sithHolocronList: [SithHolocron]? { get set }
}

protocol DarkSideScreenRouterType {
    static func create() -> UIViewController
    func routeToLightSideScreen(from view: DarkSideScreenViewType?)
}

typealias SithCodeResponse = (_ sithCode: DarkSideScreenEntityType.SithCode?, _ error: DarkSideScreenEntityType.Error?) -> Void
typealias SithHolocronListResponse = (_ sithHolocronList: [DarkSideScreenEntityType.SithHolocron]?, _ error: DarkSideScreenEntityType.Error?) -> Void
