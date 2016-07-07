Pod::Spec.new do |s|
  s.name         	= "KVParkedTextField"
  s.version      	= "0.0.1"
  s.summary      	= "A text field with a constant text/placeholder"
  s.homepage     	= "https://github.com/tuantmdev/KVParkedTextField"
  s.screenshots  	= "https://raw.githubusercontent.com/gmertk/ParkedTextField/master/Screenshots/ParkedTextField.gif", "http://i.imgur.com/N23OrK1.png"
  s.license      	= { :type => "MIT", :file => "LICENSE" }
  s.author       	= { "tuantmdev" => "tuan.dev@gmail.com" }
  s.social_media_url  	= "http://facebook.com/tuantm.dev"
  s.platform     	= :ios, "8.0"
  s.source       	= { :git => "https://github.com/tuantmdev/KVParkedTextField.git", :tag => "#{s.version}" }
  s.source_files 	= "KVParkedTextField/*.{h,m}"
  s.requires_arc 	= true
end
