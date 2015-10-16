
//
//  Constant.h
//  Generic Class
//
//  Created by Prabhat Tomar on 10/09/15.
//  Copyright (c) 2014 Prabhat Tomar. All rights reserved.

#ifndef Generic_Constant_h
#define Generic_Constant_h

typedef enum {
    FACEBOOK, LINKEDIN, PHONEBOOK, GOOGLEPLUS, TWITTER, GMAIL
}SOCIAL_TYPE;

#define toString(obj)  ([obj isKindOfClass:[NSNull class]] || obj == nil)?nil:[NSString stringWithFormat:@"%@",obj]
#define toString(aBOOL) aBOOL? @"YES" : @"NO"
#define isNull(obj)  ([obj isKindOfClass:[NSNull class]] || obj == nil)?YES:NO
#define USER_DEFAULTS [NSUserDefaults standardUserDefaults]

#define DEG2RAD(x) (0.0174532925 * (x))
#define MyLog(ObjPrint,Obj) NSLog(ObjPrint, Obj)
