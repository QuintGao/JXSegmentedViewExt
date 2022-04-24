# JXSegmentedViewExt

<p align="center">
<a href="https://github.com/QuintGao/JXSegmentedViewExt"><img src="https://img.shields.io/badge/platform-iOS-red.svg"></a>
<a href="" ><img src="https://img.shields.io/badge/license-MIT-green.svg?style=flat"></a>
<a href="https://cocoapods.org/pods/JXSegmentedViewExt"><img src="http://img.shields.io/cocoapods/v/JXSegmentedViewExt.svg?style=flat"></a>
<a href=""><img src="https://img.shields.io/badge/support-ios%208%2B-orange.svg"></a>
</p>

该库是对[JXSegmentedView](https://github.com/pujiaxin33/JXSegmentedView)的扩展及优化，目前的JXSegmentedView版本是1.3.0，JXSegmentedViewExt版本是1.0.0

## 优化及bug修改

#### 优化
1、增加方法，可动态刷新标题和指示器颜色
```
/// 刷新所有cell状态
func gk_refreshCellState()

/// 刷新所有指示器状态
func gk_refreshIndicatorState()

/// 刷新所有cell和指示器状态
func gk_refreshCellAndIndicatorState()

```

2、增加属性isSelectItemOnScrollHalf，可控制在滑动到一半的时候选中下一个item

#### bug修改
1、修复某些情况下导致的Unbalanced calls to begin/end appearance transitions for XXXX

## Pod扩展
JXSegmentedViewExt优化了JXSegmentedView的pod方式，将不同组件进行拆分，可按需pod

#### 基础库
```
pod 'JXSegmentedViewExt' 或 pod 'JXSegmentedViewExt/Core'
```

#### 分类
```
// 文字
pod 'JXCategoryViewExt/Title'

// 文字+副标题
pod 'JXCategoryViewExt/SubTitle'

// 图片
pod 'JXCategoryViewExt/Image'

// 文字+图片
pod 'JXCategoryViewExt/TitleImage'

// 富文本
pod 'JXCategoryViewExt/TitleAttribute'

// title+小红点
pod 'JXCategoryViewExt/Dot'

// title+小红点缩放
pod 'JXCategoryViewExt/DotZoom'

// title+数字
pod 'JXCategoryViewExt/Number'

// title+(文字、数字、红点混合)
pod 'JXCategoryViewExt/Badge'

// title垂直滚动缩放
pod 'JXCategoryViewExt/VerticalZoomTitle'
```

#### 指示器
```
// 背景
pod 'JXCategoryViewExt/Background'

// 线
pod 'JXCategoryViewExt/Indicator/Line'

// 线+对齐
pod 'JXCategoryViewExt/Indicator/AlignmentLine'

// 线+彩虹效果
pod 'JXCategoryViewExt/Indicator/RainbowLine'

// 图片
pod 'JXCategoryViewExt/Indicator/Image'

// 背景渐变
pod 'JXCategoryViewExt/Indicator/Gradient'

// 线渐变
pod 'JXCategoryViewExt/Indicator/GradientLine'

// 三角形
pod 'JXCategoryViewExt/Indicator/Triangle'

// 点线
pod 'JXCategoryViewExt/Indicator/DotLine'

// 双线
pod 'JXCategoryViewExt/Indicator/DoubleLine'
```

## 更新记录

* 1.0.0 2022.04.24 优化及bug修改，将pod拆分为多个
