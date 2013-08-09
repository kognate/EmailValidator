Pod::Spec.new do |s|
  s.name         = "EmailValidator"
  s.version      = "0.0.1"
  s.summary      = "A non-trivial, mostly rfc822 compliant email validator."
  s.homepage     = "http://suprageni.us/EmailValidator"
  s.license      = { :type => 'MIT', :file => 'FILE_LICENSE' }
  s.author       = { "Joshua Smith" => "kognate@gmail.com" }
  s.source       = { :git => "https://github.com/kognate/EmailValidator.git", :tag => "0.0.1" }
  s.platform     = :ios, '5.0'
  s.source_files = 'libs', 'libs/**/*.{a,h,m}'
  s.requires_arc = true
end
