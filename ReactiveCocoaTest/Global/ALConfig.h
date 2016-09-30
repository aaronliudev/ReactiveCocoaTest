//
//  ALConfig.h
//  ReactiveCocoaTest
//
//  Created by Alan on 16/9/12.
//  Copyright © 2016年 Alan. All rights reserved.
//

#ifndef ALConfig_h
#define ALConfig_h

///------------
/// AppDelegate
///------------

#define ALSharedAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define ALMainWindow ([(AppDelegate *)[UIApplication sharedApplication].delegate window])

///------------
/// Client Info
///------------

#define AL_CLIENT_ID     @"ef5834ea86b53233dc41"
#define AL_CLIENT_SECRET @"6eea860464609635567d001b1744a052f8568a99"

///-----------
/// SSKeychain
///-----------

#define AL_SERVICE_NAME @"com.Alan.ReactiveCocoaTest"
#define AL_RAW_LOGIN    @"RawLogin"
#define AL_PASSWORD     @"Password"
#define AL_ACCESS_TOKEN @"AccessToken"

///-----------
/// URL Scheme
///-----------

#define AL_URL_SCHEME @"mvvmreactivecocoa"

///----------------------
/// Persistence Directory
///----------------------

#define AL_DOCUMENT_DIRECTORY NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject

#endif /* ALConfig_h */
