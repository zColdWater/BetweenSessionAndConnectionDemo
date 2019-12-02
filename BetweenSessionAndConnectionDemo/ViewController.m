#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self startConnection];
}

- (void)startConnection {
    // 这里 https://httpbin.org/post 这个域名下面的服务器 需要科学上网才可以访问。 你挂全局代理可以请求得通。
    NSURL *url = [NSURL URLWithString:@"https://httpbin.org/post"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSDictionary *body = @{@"key11":@"value11",@"key22":@"value22"};
    [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:body options: NSJSONWritingPrettyPrinted error:NULL]];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
      if (error) {
        NSLog(@"Error,%@", [error localizedDescription]);
      }
      else {
        NSLog(@"connection: %@", [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding]);
      }
    }];
}


@end
