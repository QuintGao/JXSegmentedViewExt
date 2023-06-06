Pod::Spec.new do |s|
  s.name             = 'JXSegmentedViewExt'
  s.version          = '1.0.3'
  s.summary          = 'JXSegmentedViewExt extensions and optimize'
  s.homepage         = 'https://github.com/QuintGao/JXSegmentedViewExt'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'QuintGao' => '1094887059@qq.com' }
  s.source           = { :git => 'https://github.com/QuintGao/JXSegmentedViewExt.git', :tag => "#{s.version}" }
  s.requires_arc     = true
  s.platform         = :ios, "9.0"
  s.swift_version    = "5.0"
  s.default_subspec  = 'Core'
  
  # -----------基础组件--------------------------#
  s.subspec 'Core' do |ss|
    ss.source_files = 'Sources/Core/**/*.{swift}'
  end
  
  # -----------分类-----------------------------#
  s.subspec 'Title' do |ss|
    ss.source_files = 'JXSegmentedView/Title'
    ss.dependency 'JXSegmentedViewExt/Core'
  end
  
  s.subspec 'SubTitle' do |ss|
    ss.source_files = 'JXSegmentedView/SubTitle'
    ss.dependency 'JXSegmentedViewExt/Title'
  end
  
  s.subspec 'SubTitleImage' do |ss|
    ss.source_files = 'JXSegmentedView/SubTitleImage'
    ss.dependency 'JXSegmentedViewExt/SubTitle'
  end
  
  s.subspec 'TitleImage' do |ss|
    ss.source_files = 'JXSegmentedView/TitleImage'
    ss.dependency 'JXSegmentedViewExt/Title'
  end
  
  s.subspec 'TitleOrImage' do |ss|
    ss.source_files = 'JXSegmentedView/TitleOrImage'
    ss.dependency 'JXSegmentedViewExt/Title'
  end
  
  s.subspec 'TitleGradient' do |ss|
    ss.source_files = 'JXSegmentedView/TitleGradient'
    ss.dependency 'JXSegmentedViewExt/Title'
  end
  
  s.subspec 'AttributeTitle' do |ss|
    ss.source_files = 'JXSegmentedView/AttributeTitle'
    ss.dependency 'JXSegmentedViewExt/Core'
  end
  
  s.subspec 'Dot' do |ss|
    ss.source_files = 'JXSegmentedView/Dot'
    ss.dependency 'JXSegmentedViewExt/Title'
  end
  
  s.subspec 'DotZoom' do |ss|
    ss.source_files = 'JXSegmentedView/DotZoom'
    ss.dependency 'JXSegmentedViewExt/Title'
  end
  
  s.subspec 'Number' do |ss|
    ss.source_files = 'JXSegmentedView/Number'
    ss.dependency 'JXSegmentedViewExt/Title'
  end
  
  s.subspec 'Badge' do |ss|
    ss.source_files = 'JXSegmentedView/Badge'
    ss.dependency 'JXSegmentedViewExt/Title'
  end
  
  # ----------指示器-----------------------------#
  s.subspec 'Indicator' do |ss|
    ss.subspec 'Background' do |sss|
      sss.source_files = 'JXSegmentedView/Indicator/Background'
      sss.dependency 'JXSegmentedViewExt/Core'
    end
    
    ss.subspec 'Line' do |sss|
      sss.source_files = 'JXSegmentedView/Indicator/Line'
      sss.dependency 'JXSegmentedViewExt/Core'
    end
    
    ss.subspec 'AlignmentLine' do |sss|
      sss.source_files = 'JXSegmentedView/Indicator/AlignmentLine'
      sss.dependency 'JXSegmentedViewExt/Indicator/Line'
    end
    
    ss.subspec 'Gradient' do |sss|
      sss.source_files = 'JXSegmentedView/Indicator/Gradient'
      sss.dependency 'JXSegmentedViewExt/Core'
    end
    
    ss.subspec 'GradientLine' do |sss|
      sss.source_files = 'JXSegmentedView/Indicator/GradientLine'
      sss.dependency 'JXSegmentedViewExt/Indicator/Line'
    end
    
    ss.subspec 'DotLine' do |sss|
      sss.source_files = 'JXSegmentedView/Indicator/DotLine'
      sss.dependency 'JXSegmentedViewExt/Core'
    end
    
    ss.subspec 'DoubleLine' do |sss|
      sss.source_files = 'JXSegmentedView/Indicator/DoubleLine'
      sss.dependency 'JXSegmentedViewExt/Core'
    end
    
    ss.subspec 'RainbowLine' do |sss|
      sss.source_files = 'JXSegmentedView/Indicator/RainbowLine'
      sss.dependency 'JXSegmentedViewExt/Indicator/Line'
    end
    
    ss.subspec 'Triangle' do |sss|
      sss.source_files = 'JXSegmentedView/Indicator/Triangle'
      sss.dependency 'JXSegmentedViewExt/Core'
    end
    
    ss.subspec 'Image' do |sss|
      sss.source_files = 'JXSegmentedView/Indicator/Image'
      sss.dependency 'JXSegmentedViewExt/Core'
    end
  end
  
end
