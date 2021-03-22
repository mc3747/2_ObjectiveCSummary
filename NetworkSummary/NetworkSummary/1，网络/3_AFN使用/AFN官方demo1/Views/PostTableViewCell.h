

#import <UIKit/UIKit.h>

@class Post;

@interface PostTableViewCell : UITableViewCell

@property (nonatomic, strong) Post *post;

+ (CGFloat)heightForCellWithPost:(Post *)post;

@end
