import UIKit

class DarkSideScreenRouter: DarkSideScreenRouterType {
    static func create() -> UIViewController {
        let storyboard = UIStoryboard(name: "DarkSideScreenView", bundle: .main)
        
        if let view = storyboard.instantiateViewController(withIdentifier: "DarkSideScreenView")
            as? DarkSideScreenView
        {
            let interactor = DarkSideScreenInteractor()
            let presenter = DarkSideScreenPresenter()
            let entity = DarkSideScreenEntity()
            let router = DarkSideScreenRouter()
            
            view.presenter = presenter
            interactor.entity = entity
            interactor.webService = FakeWebService()
            presenter.view = view
            presenter.interactor = interactor
            presenter.router = router
            
            return view
        }
        
        return UIViewController()
    }
    
    func routeToLightSideScreen(from view: DarkSideScreenViewType?) {
        if let view = view as? UIViewController,
            let navigationController = view.navigationController
        {
            navigationController.pushViewController(
                LightSideScreenRouter.create(),
                animated: true
            )
        }
    }
    
}
