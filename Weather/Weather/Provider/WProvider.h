//
//  WProvider.h
//  Weather
//
//  Created by Sangwook Wi on 5/2/17.
//  Copyright © 2017 Sangwook Wi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WProvider : NSObject

- (void)fetchDataWithCallback:(void (^)(NSData *data, NSError *error))callback;

@end
