//
//  FileNameUtils.m
//  KSCrash
//
//  Created by Simon Lawrence on 13/02/2024.
//  Copyright © 2024 Karl Stenerud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileNameUtils.h"
#import "KSCrashReportStore.h"

// Moved from KSCrashReportStore.c
int64_t getReportIDFromFilename(const char *filename)
{
    NSString *appName = [NSString stringWithCString:getAppName()
                                           encoding:NSUTF8StringEncoding];
    NSString *filenameString = [[[NSString stringWithCString:filename
                                                    encoding:NSUTF8StringEncoding] lastPathComponent] stringByDeletingPathExtension];
    if (![filenameString hasPrefix:appName]) {
        return 0;
    }
    NSArray *elements = [filenameString componentsSeparatedByString:@"-"];
    NSString *last = [elements lastObject];

    if (last != nil) {
        uint64_t result = 0;
        NSScanner *scanner = [NSScanner scannerWithString:last];
        [scanner scanHexLongLong:&result];
        return (int64_t)result;
    }

    return 0;
}
