//
//  Employee.h
//  
//
//  Created by admin on 21/08/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Employee : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * fatherName;
@property (nonatomic, retain) NSString * designation;
@property (nonatomic, retain) NSString * companyName;
@property (nonatomic, retain) NSString * contact;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * city;

@end
