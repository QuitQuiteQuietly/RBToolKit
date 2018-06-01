Pod::Spec.new do |s|
  s.name             = 'RBToolKit'
  s.version          = '0.1.1'
  s.summary          = 'RBToolKit.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/wzc5670594/RBToolKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'wzc5670594' => '18511234520@163.com' }
  s.source           = {
                        :git => 'https://github.com/wzc5670594/RBToolKit.git',
                        :tag => s.version.to_s,
                        }
    #:submodules => true



    s.subspec 'InterFace' do |inter|
        inter.source_files = 'RBToolKit/InterFace/*.{h,m}', 'RBToolKit/InterFace/Category/*.{h,m}', 'RBToolKit/TransitionButton/*.{h,m}'
    end

    s.subspec 'Time' do |time|
        time.source_files = 'RBToolKit/Time/*.{h,m}', 'RBToolKit/Time/**/*.{h,m}'
    end

    s.subspec 'TableView' do |tableView|
        tableView.source_files = 'RBToolKit/TableView/RBTableView.{h,m}'
        tableView.dependency 'MJRefresh'
        tableView.dependency 'ReactiveObjC'
    end

    s.subspec 'CountDown' do |cd|
        cd.source_files = 'RBToolKit/CountDown/*.{h,m}'
        cd.dependency 'ReactiveObjC'
    end
    
    s.subspec 'Localize' do |local|
    local.source_files = 'RBToolKit/Localize/*.{h,m}'
    end
    
    s.subspec 'File' do |f|
        f.source_files = 'RBToolKit/FileManager/*.{h,m}', 'RBToolKit/FileManager/Documents/*.{h,m}'
    end

    s.subspec 'QRScan' do |qr|
        qr.source_files = 'RBToolKit/QRScan/**/*'
        qr.dependency 'ReactiveObjC'
    end
    
    s.subspec 'Wallet_Package' do [wp]
        wp.source_files = 'RBToolKit/FileManager/**/*', 'RBToolKit/QRScan/**/*', 'RBToolKit/InterFace/**/*', 'RBToolKit/TransitionButton/*.{h,m}', 'RBToolKit/Time/**/*', 'RBToolKit/TableView/RBTableView.{h,m}'
        wp.dependency 'MJRefresh'
        wp.dependency 'ReactiveObjC'
        end

  s.ios.deployment_target = '8.0'

  s.source_files = 'RBToolKit/**/*'

end
