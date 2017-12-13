//
//  KXTime.m
//  Pods
//
//  Created by Ray on 2017/9/27.
//
//

#import "RBTime.h"

#import "NSString+SafeString.h"
#import "NSNumber+Time.h"

@implementation KXTime

+ (NSString *(^)(double))time {
    return ^(double ms) {
      
        if (!ms) {
            return @"";
        }
        
        return KXTime.time_second(@(ms).secondsValue.doubleValue);
    };
}

+ (NSString *(^)(double))time_second {
    return ^(double s) {
        
        if (!s) {
            return @"";
        }
        
        return NSString.safe([KXTime getDateConvertToLocalTime:s]);
        
    };
}

+ (NSString *)getDateConvertToLocalTime:(double)time {
    
    if (time <= 0.0) {
        return @"";
    }
    
    NSDate * createDate = [NSDate dateWithTimeIntervalSince1970:time];
    NSString *formatDate = [self friendlyDate:createDate];
    return formatDate;
}


+ (NSString *)getDateWithFormat:(NSString *)format withPastSeconds:(double)time {
    
    NSDate * createDate = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateformat = [[NSDateFormatter alloc]init];
    
    [dateformat setDateFormat:format];
    
    NSString *formatDate = [dateformat stringFromDate:createDate];
    
    return formatDate;
}

+ (NSString *)friendlyDate:(NSDate *)date{
    unsigned units = NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    //计算今天过了多少秒
    NSDate *now = [NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *dateCom = [cal components:units fromDate:date];
    NSInteger preYear = [dateCom year];
    NSDateComponents *components = [cal components:units fromDate:now];
    NSInteger year = [components year];
    NSInteger hours = [components hour];
    NSInteger minites = [components minute];
    NSInteger seconds = [components second];
    NSInteger todayPastSeconds = (hours * 60 + minites) * 60 + seconds;
    
    //获取今天开始的时间
    NSDate *todayStart = [now dateByAddingTimeInterval:- todayPastSeconds];
    NSDate *yestodayStart = [now dateByAddingTimeInterval:- todayPastSeconds - 86400];
    NSDate *lastdayStart = [now dateByAddingTimeInterval:- todayPastSeconds - 86400 * 2];
    NSDate *tomorrow = [now dateByAddingTimeInterval:- todayPastSeconds + 86400];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    if (preYear < year) {
        //今年以前的数据
        [formatter setDateFormat:@"yyyy-MM-dd"];
    }
    else {
        //比较时间，确定时间要格式化的格式
        if([date compare:lastdayStart] < 0 || [date compare:tomorrow] > 0 ) {
            //        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            [formatter setDateFormat:@"MM-dd HH:mm"];
            
        }
        else if ([date compare:lastdayStart] > 0 && [date compare:yestodayStart] < 0) {
            [formatter setDateFormat:@"前天 HH:mm"];
        }
        else if([date compare:todayStart] < 0 && [date compare:yestodayStart] > 0) {
            [formatter setDateFormat:@"昨天 HH:mm"];
        }
        else{
            [formatter setDateFormat:@"今天 HH:mm"];
        }
        
    }
    
    NSString *formatDate = [formatter stringFromDate:date];
    return formatDate;
}


@end
