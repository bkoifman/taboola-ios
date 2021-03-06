//
//  SecondViewController.swift
//  TaboolaDemoSwiftApp
//

import UIKit
import TaboolaSDK

class TBFeedViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var taboolaView: TaboolaView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taboolaView.delegate = self
        taboolaView.ownerViewController = self
        taboolaView.autoResizeHeight = true
        taboolaView.scrollEnable = false
        taboolaView.enableClickHandler = true
        
        taboolaView.mode = "thumbnails-sdk3"
        taboolaView.publisher = "betterbytheminute-app"
        taboolaView.pageType = "article"
        taboolaView.pageUrl = "http://www.example.com"
        taboolaView.placement = "Mobile"
        taboolaView.targetType = "mix"
        taboolaView.setInterceptScroll(true)
        
        // Optional - add extra styling rules to the widget, CSS format.
//        taboolaView.optionalWidgetStyle = "background:linear-gradient(135deg, #ECEDDC 25%, transparent 25%) -50px 0,linear-gradient(225deg, #ECEDDC 25%, transparent 25%) -50px 0,linear-gradient(315deg, #ECEDDC 25%, transparent 25%),linear-gradient(45deg, #ECEDDC 25%, transparent 25%)background-size: 100px 100pxbackground-color: #EC173A"
        
        
        let pageDict = ["referrer": "http://www.example.com/ref"]
        taboolaView.setOptionalPageCommands(pageDict)
        
        taboolaView.fetchContent()
    }
}

// MARK: Extensions
extension TBFeedViewController: TaboolaViewDelegate {
    func onItemClick(_ placementName: String!, withItemId itemId: String!, withClickUrl clickUrl: String!, isOrganic organic: Bool) -> Bool {
        if organic {
            print("itemId: \(itemId)")
        } else {
            print("clickUrl: \(clickUrl)")
        }
        return true
    }
    
    func taboolaView(_ taboolaView: UIView!, didLoadPlacementNamed placementName: String!, withHeight height: CGFloat) {
        print("Placement \(placementName) loaded successfully. height \(height)");
    }
    
    func taboolaView(_ taboolaView: UIView!, didFailToLoadPlacementNamed placementName: String!, withErrorMessage error: String!) {
        print("Placement \(placementName) failed to load because: %@ \(error)");
    }
}

extension TBFeedViewController: ActionAssistantProtocol {
    func refreshChild() {
        //        mTaboolaView.refresh()
    }
    
    func editChild(dict: [String : String]) {
        taboolaView.mode = dict[ConstantsProperties.mode]
        taboolaView.publisher = dict[ConstantsProperties.publisher]
        taboolaView.pageType = dict[ConstantsProperties.pageType]
        taboolaView.pageUrl = dict[ConstantsProperties.pageUrl]
        taboolaView.placement = dict[ConstantsProperties.placement]
        taboolaView.fetchContent()
    }
}
