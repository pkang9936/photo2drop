//
//  LeftMenuViewController.swift
//  Photo2Drop
//
//  Created by Kang, Puthyrak on 12/7/15.
//  Copyright © 2015 Kang, Puthyrak. All rights reserved.
//

import UIKit

enum LeftMenu: Int {
    case PhotoAlbum = 0
    case Setting
}

protocol LeftMenuProtocol: class {
    func changeViewController(menu: LeftMenu)
}

class LeftMenuViewController: UIViewController, LeftMenuProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    var menus = ["Photo Album", "Settings"]
    var imageHeaderView: ImageHeaderView!
    
    // MARK: - 
    private let tableHeaderHeight: CGFloat = 200.0
    private let tableHeaderCutAway: CGFloat = 50.0
    
    private var headerView: LeftMenuTableHeader!
    private var headerMaskLayer: CAShapeLayer!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.tableView.registerCellClass(BaseTableViewCell.self)
       /*
        self.imageHeaderView = ImageHeaderView.loadNib()
        self.view.addSubview(self.imageHeaderView)
*/
        headerView = tableView.tableHeaderView as! LeftMenuTableHeader
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)
        
        tableView.contentInset = UIEdgeInsets(top: tableHeaderHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -tableHeaderHeight)
        
        headerMaskLayer = CAShapeLayer()
        headerMaskLayer.fillColor = UIColor.blackColor().CGColor
        
        headerView.layer.mask = headerMaskLayer
        
        
        updateHeaderView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateHeaderView()
    }
    func updateHeaderView() {
        let effectiveHeight = tableHeaderHeight - tableHeaderCutAway / 2
        
        var headerRect = CGRect(x: 0, y: -effectiveHeight, width: tableView.bounds.width, height: tableHeaderHeight)
        
        if tableView.contentOffset.y < -effectiveHeight {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y + tableHeaderCutAway/2
        }
        headerView.frame = headerRect
        
        // cut away
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 0, y: 0))
        path.addLineToPoint(CGPoint(x: headerRect.width, y: 0))
        path.addLineToPoint(CGPoint(x: headerRect.width, y: headerRect.height))
        path.addLineToPoint(CGPoint(x: 0, y: headerRect.height - tableHeaderCutAway))
        headerMaskLayer?.path = path.CGPath
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        /*
        self.imageHeaderView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 160)
        self.view.layoutIfNeeded()
*/
        updateHeaderView()
    }
    
    
    func changeViewController(menu: LeftMenu) {
        //
    }
}


extension LeftMenuViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if let menu = LeftMenu(rawValue: indexPath.item) {
            switch menu {
            case .PhotoAlbum, .Setting:
                return BaseTableViewCell.height()
            }
        }
        return 0
    }
}

extension LeftMenuViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        /*
        if let menu = LeftMenu(rawValue: indexPath.item) {
            switch menu {
            case .PhotoAlbum, .Setting:
                let cell = BaseTableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: BaseTableViewCell.identifier)
                cell.setData(menus[indexPath.row])
                return cell
            }
        }
        return UITableViewCell()
*/
        
        let cell = tableView.dequeueReusableCellWithIdentifier(menus[indexPath.row], forIndexPath: indexPath) as UITableViewCell!
        
        cell.imageView
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let menu = LeftMenu(rawValue: indexPath.item) {
            self.changeViewController(menu)
        }
    }

}

extension LeftMenuViewController: UIScrollViewDelegate {
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //if self.tableView == scrollView {
            updateHeaderView()
       // }
    }
}
