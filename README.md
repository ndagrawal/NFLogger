# NFLogger   



Please refer [Header File Documentation] (https://github.com/ndagrawal/NFLogger/blob/master/NFLogger/NFLogger.h) to check the usage of APIs of the library. 

**Steps to build the library :**   
Select the target scheme as “NFLoggerLib” and device as “General Device”   
Click Run (Build and Run). This will create NFLogger.framework in the project folder.   

**Steps to Integrate the library with your application:**   
1. Drag and drop the NFLogger.framework in the frameworks folder. Select Following Options :   
            i. Check : Copy Items if needed  
            ii. Create Groups  
            iii. Select Target     
2. Add “libsqlite3.0.tbd”   
    i. Navigate to Build Phases   
    ii. Navigate to Link to Binaries   
    iii. Add “libsqlite3.0.tbd  
4. Navigate to Target - Select General  
    Add NFLogger.framework in “Embedded Binaries”  
5. Refer  [Header File Documentation] (https://github.com/ndagrawal/NFLogger/blob/master/NFLogger/NFLogger.h) to initilizeSDK.    
6. Navigate to App Delegate and import header file.  
```#import<NFLogger/NFLogger.h>

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {  
// Override point for customization after application launch.  
    [NFLogger initializeSDKWithMode:NFLOGManualCapture];  
    [NFLogger setLogLevelOfNFLog:NFLOG_LEVEL_VERBOSE|NFLOG_LEVEL_DEBUG|NFLOG_LEVEL_ERROR];  
    return YES;  
}  
```

Author : Nilesh Agrawal
For more questions please mail : nilesh.d.agrawal@gmail.com

----

MIT License

Copyright (c) 2017 Nilesh Agrawal

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

