Pod::Spec.new do |s|
  s.name             = 'RBToolKit'
  s.version          = '0.1.0'
  s.summary          = 'RBToolKit.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/wzc5670594/RBToolKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'wzc5670594' => '18511234520@163.com' }
  s.source           = { :git => 'https://github.com/wzc5670594/RBToolKit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'RBToolKit/**/*'

end
