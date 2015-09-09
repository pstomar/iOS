//
//  ListViewController.m
//  CoreDataEmployeeExample
//
//  Created by admin on 21/08/15.
//
//

#import "ListViewController.h"
#import "ViewController.h"

@interface ListViewController ()
@property NSMutableArray *dataSource;
@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSFetchRequest *query = [[NSFetchRequest alloc] initWithEntityName:@"Employee"];
    NSSortDescriptor *sortByName = [[NSSortDescriptor alloc] initWithKey:@"id" ascending:YES];
    [query setSortDescriptors:[NSArray arrayWithObject:sortByName]];
    NSError *error;
    _dataSource = [[[appDelegate managedObjectContext] executeFetchRequest:query error:&error] mutableCopy];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    Employee*emp = [_dataSource objectAtIndex:indexPath.row];
    [cell.textLabel setText:emp.firstName];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle) editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(editingStyle == UITableViewCellEditingStyleDelete) {
        [appDelegate.managedObjectContext deleteObject:[_dataSource objectAtIndex:indexPath.row]];
        [_dataSource removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (UIViewController *controller in [self.navigationController viewControllers]){
        if ([controller isKindOfClass:[ViewController class]]) {
            ((ViewController*) controller).backEmployee = [_dataSource objectAtIndex:indexPath.row];
            break;
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
