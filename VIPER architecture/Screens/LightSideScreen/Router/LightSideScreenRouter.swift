import UIKit

class LightSideScreenRouter: LightSideScreenRouterType {
    static func create() -> UIViewController {
        let storyboard = UIStoryboard(name: "LightSideScreenView", bundle: .main)
        
        if let view = storyboard.instantiateViewController(withIdentifier: "LightSideScreenView")
            as? LightSideScreenView
        {
            let interactor = LightSideScreenInteractor()
            let presenter = LightSideScreenPresenter()
            let entity = LightSideScreenEntity()
            let router = LightSideScreenRouter()
            
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
    
    func routeToDarkSideScreen(from view: LightSideScreenViewType?) {
        if let view = view as? UIViewController,
            let navigationController = view.navigationController
        {
            navigationController.pushViewController(
                DarkSideScreenRouter.create(),
                animated: true
            )
        }
    }
    
}
