//
//  ClassListViewController.h
//  LayerPlayerOc
//
//  Created by 武蕴 on 15/8/17.
//  Copyright (c) 2015年 WymanY. All rights reserved.
//

#import <UIKit/UIKit.h>
// =====================================================
/*
 ##58_UIView，CALayer和CAShapeLayer

 1⃣️，UIView和CALayer区别：
 1，UIView继承UIResponser，可以响应事件；Layer直接继承自NSObject，不可以响应事件
 2，View中frame getter方法，bounds和center，UIView并没有做什么工作；它只是简单的各自调用它底层的CALayer的frame，bounds和position方法。
 3，UIView主要是对显示内容的管理而 CALayer 主要侧重显示内容的绘制。
      UIView 是 CALayer 的CALayerDelegate，我猜测是在代理方法内部[UIView(CALayerDelegate) drawLayer:inContext]调用 UIView 的 DrawRect方法，从而绘制出了 UIView 的内容
 4，CALayer 是默认修改属性支持隐式动画的，在给 UIView 的 Layer 做动画的时候，View 作为 Layer 的代理，Layer 通过 actionForLayer:forKey:向 View请求相应的 action(动画行为)


 2⃣️，CALayer和CAShapeLayer区别：
 1、CAShapeLayer继承自CALayer，可以使用CALayer的所有属性值
 2、CAShapeLayer需要与贝塞尔曲线配合使用才有意义
 3、使用CAShapeLayer与贝塞尔曲线可以实现不在view的drawRect方法中画出有一些想要的图形
 4、CAShapeLayer属于CoreAnimation框架，其动画渲染直接提交到手机的GPU当中，相较于view的drawRect方法使用CPU渲染而言，其效率极高，能大大优化内存使用情况。
 个人经验：可以重写UIView的子类中的drawRect来实现进度条效果，但是UIView的drawRect是用CPU渲染实现的，而使用CAShapeLayer效率更高，因为它用的是GPU渲染。

 3⃣️，贝塞尔曲线
     UIBezierPath用于定义一个由直线/曲线组合而成的路径, 并且可以在自定义视图中渲染该路径.
 */
// =====================================================



/*
 ✅layer的种类：
 CAShapeLayer：用来根据路径绘制矢量图形。
 CATextLayer：绘制文字信息。
 CATransformLayer：使用单独的图层创建3D图形。
 CAGradientLayer：绘制线性渐变色。
 CAReplicatorLayer：高效地创建多个相似的图层并施加相似的效果或动画。
 CAScrollLayer：没有交互效果的滚动图层，没有滚动边界，可以任意滚动上面的图层内容。
 CATiledLayer：将大图裁剪成多个小图以提高内存和性能。
 CAEmitterLayer：各种炫酷的粒子效果。
 CAEAGLLayer：用来显示任意的OpenGL图形。
 AVPlayerLayer：用来播放视频。
*/
@interface ClassListViewController : UITableViewController

@end
