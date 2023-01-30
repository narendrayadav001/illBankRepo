//
//  ListRouter.swift
//  DemoByNarendraYadavv
//
//  Created by Narendra Yadav on 30/01/23.
//

import Foundation
import UIKit

// MARK: -  List Router
class ListRouter:PresenterToRouterProtocol{
    
    static func createModule() -> ListViewController {
        let view = mainstoryboard.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
        let presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = ListPresenter()
        let interactor: PresenterToInteractorProtocol = ListInteractor()
        let router:PresenterToRouterProtocol = ListRouter()
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        return view
        
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
}
