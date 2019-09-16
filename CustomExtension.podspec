Pod::Spec.new do |s|
  s.name             = 'CustomExtension'
  s.version          = '1.0'
  s.summary          = '测试扩展内容'
  s.swift_version    = '4.0'
  s.description      = "当前版本主要用来测试，没有什么其他的意义，就只是用来测试的。。。。。"
  s.homepage         = 'https://github.com/Hanten/CustomDemo'
  s.author           = { 'Hanten' => 'hantianit@outlook.com' }
  s.source           = { :git => 'https://github.com/Hanten/CustomDemo.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.source_files = 'CustomExtension/Classes'
  
end