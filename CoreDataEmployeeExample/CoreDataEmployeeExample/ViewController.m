//
//  ViewController.m
//  CoreDataEmployeeExample
//
//  Created by admin on 21/08/15.
//
//

#import "ViewController.h"
#import "AppDelegate.h"

typedef enum {
    TAG_UPDATE = 90,
    TAG_SAVE = 91
}TAGS;

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UITextField *txtFName;
@property (nonatomic, weak) IBOutlet UITextField *txtLName;
@property (nonatomic, weak) IBOutlet UITextField *txtFatherName;
@property (nonatomic, weak) IBOutlet UITextField *txtCity;
@property (nonatomic, weak) IBOutlet UITextField *txtContact;
@property (nonatomic, weak) IBOutlet UITextField *txtEmail;
@property (nonatomic, weak) IBOutlet UITextField *txtDesignation;
@property (nonatomic, weak) IBOutlet UITextField *txtCompany;
@property (nonatomic, weak) IBOutlet UIButton *btnAction;

@property (nonatomic, weak) IBOutlet UIView *viewAddEmp;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.backEmployee) {
        [_btnAction setTitle:@"Update" forState:UIControlStateNormal];
        [_btnAction setTag:TAG_UPDATE];
        [_viewAddEmp setHidden:NO];
        [_txtFName setText:_backEmployee.firstName];
        [_txtLName setText:_backEmployee.lastName];
        [_txtFatherName setText:_backEmployee.fatherName];
        [_txtCity setText:_backEmployee.city];
        [_txtContact setText:_backEmployee.contact];
        [_txtEmail setText:_backEmployee.email];
        [_txtDesignation setText:_backEmployee.designation];
        [_txtCompany setText:_backEmployee.companyName];
    }else{
        [_viewAddEmp setHidden:YES];
    }
}

-(IBAction) btnListClicked:(UIButton*) button
{
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ListViewController"] animated:YES];
}

-(IBAction) btnAddClicked:(UIButton*) button
{
    [UIView transitionWithView:_viewAddEmp duration:0.4 options:UIViewAnimationOptionTransitionCrossDissolve animations:NULL completion:NULL];
    [_viewAddEmp setHidden:NO];
}



-(IBAction) btnSaveAction:(UIButton*) button
{
    if(button.tag == TAG_SAVE){
        
    Employee*employee = (Employee*)[NSEntityDescription insertNewObjectForEntityForName: @"Employee" inManagedObjectContext:[appDelegate managedObjectContext]];
    
        [employee setId:[self getEmployeeId]];
        [employee setFirstName:_txtFName.text];
        [employee setLastName:_txtLName.text];
        [employee setFatherName:_txtFatherName.text];
        [employee setDesignation:_txtDesignation.text];
        [employee setCompanyName:_txtCompany.text];
        [employee setContact:_txtContact.text];
        [employee setEmail:_txtEmail.text];
        [employee setCity:_txtCity.text];
    }
    else if(button.tag == TAG_UPDATE)
    {
        [_backEmployee setFirstName:_txtFName.text];
        [_backEmployee setLastName:_txtLName.text];
        [_backEmployee setFatherName:_txtFatherName.text];
        [_backEmployee setDesignation:_txtDesignation.text];
        [_backEmployee setCompanyName:_txtCompany.text];
        [_backEmployee setContact:_txtContact.text];
        [_backEmployee setEmail:_txtEmail.text];
        [_backEmployee setCity:_txtCity.text];
    }
    NSError *error;
    [appDelegate.managedObjectContext save:&error];
    if (error) {
        NSLog(@"%@",error);
    }else {
        NSString *message = (button.tag == TAG_SAVE)?@"Saved Successfully.":@"Updated Successfully.";
        [[[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
    [self resetAll];
    [appDelegate saveContext];
}

-(IBAction) btnCancelAction:(UIButton*) button
{
    [self resetAll];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self resignTextFieldResponder];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self resignTextFieldResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self resignTextFieldResponder];
    return YES;
}

-(NSNumber *) getEmployeeId {
    NSString *key = @"MAX_EMPLOYEE_ID";
    NSNumber *emp_id = [[NSUserDefaults standardUserDefaults] valueForKey:key];
    if(!emp_id){
        emp_id = [NSNumber numberWithLong:1];
    }else{
        emp_id = [NSNumber numberWithLong:([emp_id longValue]+1)];
    }
    [[NSUserDefaults standardUserDefaults] setObject:emp_id forKey:key];
    return emp_id;
}

- (void) resignTextFieldResponder {
    [_txtFName resignFirstResponder];
    [_txtLName resignFirstResponder];
    [_txtFatherName resignFirstResponder];
    [_txtCity resignFirstResponder];
    [_txtContact resignFirstResponder];
    [_txtEmail resignFirstResponder];
    [_txtDesignation resignFirstResponder];
    [_txtCompany resignFirstResponder];
}

-(void) resetAll {
    [_btnAction setTitle:@"Save" forState:UIControlStateNormal];
    [_btnAction setTag:TAG_SAVE];
    [_txtFName setText:nil];
    [_txtLName setText:nil];
    [_txtFatherName setText:nil];
    [_txtCity setText:nil];
    [_txtContact setText:nil];
    [_txtEmail setText:nil];
    [_txtDesignation setText:nil];
    [_txtCompany setText:nil];
    
    [UIView transitionWithView:_viewAddEmp duration:0.4 options:UIViewAnimationOptionTransitionCrossDissolve animations:NULL completion:NULL];
    
    [_viewAddEmp setHidden:YES];
}

@end
