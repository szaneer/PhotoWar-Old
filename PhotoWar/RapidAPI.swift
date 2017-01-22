//
//  RapidAPI.swift
//  PhotoWar
//
//  Created by Siraj Zaneer on 1/21/17.
//  Copyright © 2017 Siraj Zaneer. All rights reserved.
//

import UIKit

class RapidAPI: NSObject {
    
    var _baseURL = ""
    var _auth = ""
    
    init(projectName: String, token: String) {
        super.init()
        let authStr = String(format: "%s:%s", projectName, token)
        let authData = authStr.data(using: .utf8)
        let authValue = String(format: "Basic %s", authData!.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0)))
        
        _baseURL = "https://rapidapi.io/connect"
        _auth = authValue
        
    }
    
    func getBaseURL() -> String {
        return self._baseURL
    }

    func buildCallURLWithPackage(package: String, block: String) -> String {
        return String(format: "%s/%s/%s", self.getBaseURL(), package, block)
    }
    
    func callPackage(package: String, block: String, withParameters parameters: NSDictionary, success: @escaping (_ response: NSDictionary) -> Void, failure: @escaping (_ error: Error) -> Void) {
        let url = URL(string: self.buildCallURLWithPackage(package: package, block: block))
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = ["Authorization": self._auth]
        
        let request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        
    }
    
}
/*
 - (void)callPackage:(NSString*)package
 block:(NSString*)block
 withParameters:(NSDictionary*)parameters
 success:(void (^)(NSDictionary *responseDict))success
 failure:(void(^)(NSError* error))failure
 {
 
 NSURL *url = [NSURL URLWithString:[self buildCallUrlWithPackage:package block:block]];
 NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
 config.HTTPAdditionalHeaders = @{@"Authorization": self.auth};
 NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
 
 NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
 
 [request setHTTPMethod:@"POST"];
 
 NSString *BoundaryConstant = @"----------V2ymHFg03ehbqgZCaKO6jy";
 
 NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", BoundaryConstant];
 [request setValue:contentType forHTTPHeaderField:@"Content-type"];
 
 NSMutableData *body = [NSMutableData data];
 
 for (NSString *param in parameters) {
 
 
 if([[parameters objectForKey:param] isKindOfClass:[NSString class]])
 {
 [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[[NSString stringWithFormat:@"%@\r\n", [parameters objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
 }
 else
 {
 NSString* FileParamConstant = param;
 [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image.jpg\"\r\n", FileParamConstant] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[parameters objectForKey:param]];
 [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
 }
 
 }
 
 
 [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
 [request setHTTPBody:body];
 
 NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
 [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
 
 NSError *error = nil;
 
 if (!error) {
 NSURLSessionDataTask *uploadTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
 
 NSDictionary * json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
 success(json);
 
 }];
 [uploadTask resume];
 }
 
 
 }
 
 @end
 Contact GitHub API Training Shop Blog About
*/
