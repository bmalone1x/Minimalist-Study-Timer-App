import UIKit


class CustomTabBarController: UITabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBar.unselectedItemTintColor = UIColor.gray;
    }
    
     func switchToAccountTab()
    {
        self.tabBar.selectedItem = tabBar.items?.first
    }
}
