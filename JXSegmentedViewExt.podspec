Pod::Spec.new do |s|
  s.name             = 'JXSegmentedViewExt'
  s.version          = '1.0.0'
  s.summary          = 'JXSegmentedViewExt extensions and optimize'
  s.description      = <<-DESC
对JXSegmentedView的优化扩展，拆分pod
                       DESC
  s.homepage         = 'https://github.com/QuintGao/JXSegmentedViewExt'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '1094887059@qq.com' => '1094887059@qq.com' }
  s.source           = { :git => 'https://github.com/QuintGao/JXSegmentedViewExt.git', :tag => "#{s.version}" }
  s.requires_arc     = true
  s.ios.deployment_target = '9.0'
  s.default_subspec = 'Core'
  
  # -----------基础组件--------------------------#
  s.subspec 'Core' do |ss|
    ss.source_files = 'JXSegmentedView/Core/**/*.{swift}'
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
end
