//
//  ListViewController.h
//  CoreDataEmployeeExample
//
//  Created by admin on 21/08/15.
//
//

#import <UIKit/UIKit.h>
#import "Employee.h"

@interface ListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end
