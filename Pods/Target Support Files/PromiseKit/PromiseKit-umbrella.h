#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "AAA-CocoaPods-Hack.h"
#import "AnyPromise.h"
#import "PromiseKit.h"
#import "NSNotificationCenter+AnyPromise.h"
#import "NSURLSession+AnyPromise.h"
#import "PMKFoundation.h"
#import "CALayer+AnyPromise.h"
#import "PMKQuartzCore.h"
#import "PMKUIKit.h"
#import "UIView+AnyPromise.h"
#import "UIViewController+AnyPromise.h"

FOUNDATION_EXPORT double PromiseKitVersionNumber;
FOUNDATION_EXPORT const unsigned char PromiseKitVersionString[];

