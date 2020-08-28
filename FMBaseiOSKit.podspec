
Pod::Spec.new do |s|
  s.name             = 'FMBaseiOSKit'
  s.version          = '0.3.8'
  s.summary          = '一个iOS项目基础框架'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/CoderFM/FMBaseiOSKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'CoderFM' => 'zhoufaming251@163.com' }
  s.source           = { :git => 'https://github.com/CoderFM/FMBaseiOSKit.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'

  s.source_files = 'FMBaseiOSKit/Classes/**/*'
  
  s.dependency 'Masonry'
  s.dependency 'FMFormSubmitKit'
  s.dependency 'FMLayoutKit'
  s.dependency 'FMPickerView'
  
end
