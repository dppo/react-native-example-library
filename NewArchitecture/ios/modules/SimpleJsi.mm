//
//  SimpleJsi.m
//  NewArchitecture
//
//  Created by 高昇 on 2022/4/13.
//

#import "SimpleJsi.h"
#import <React/RCTBridge+Private.h>
#import <jsi/jsi.h>

using namespace facebook::jsi;
using namespace std;

@implementation SimpleJsi

RCT_EXPORT_MODULE()

+ (BOOL)requiresMainQueueSetup
{
  return YES;
}

RCT_EXPORT_BLOCKING_SYNCHRONOUS_METHOD(install)
{
    RCTBridge* bridge = [RCTBridge currentBridge];
    RCTCxxBridge* cxxBridge = (RCTCxxBridge*)bridge;
    if (cxxBridge == nil) {
        return @false;
    }

    auto jsiRuntime = (facebook::jsi::Runtime*) cxxBridge.runtime;
    if (jsiRuntime == nil) {
        return @false;
    }
    install(*(facebook::jsi::Runtime *)jsiRuntime, self);
   
    return @true;
}

static void install(facebook::jsi::Runtime &jsiRuntime, SimpleJsi *simpleJsi)
{
  auto add = Function::createFromHostFunction(jsiRuntime,PropNameID::forAscii(jsiRuntime,"add"),2,[simpleJsi](Runtime &runtime,const Value &thisValue,const Value *arguments,size_t count) -> Value {
    int a = arguments[0].getNumber();
    int b = arguments[1].getNumber();
    return Value(a + b);
  });
  
  jsiRuntime.global().setProperty(jsiRuntime, "add", move(add));
}

@end
