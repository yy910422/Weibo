
import Foundation


protocol YTableViewModelDelegate{
    
    var delegate:UIViewController!{get set}
    
    func itemAtIndex(index: NSIndexPath) -> AnyObject
    
    func numOfSections() -> Int
    
    func numOfRowsInSection(section: Int) -> Int
    
    func heightForRowAtIndexPath (indexPath: NSIndexPath) -> CGFloat
    
    func heightForFooterInSection(section: Int) -> CGFloat
    
    func heightForHeaderInSection(section: Int) -> CGFloat
    
    
}