Pod::Spec.new do |s|

  s.name         = "TweenController"
  s.version      = "1.0.1"
  s.summary      = "A pure Swift toolkit for creating interactive menus and tutorials"
  s.platform	  = :ios, '8.0'

  s.description  = <<-DESC
                   On the surface, TweenController makes it easy to build interactive menus and tutorials. Under the hood, it's a simple but powerful toolkit to interpolate between values that are Tweenable.
                   DESC

  s.homepage     = "https://github.com/daltonclaybrook/tween-controller"
  s.screenshots  = "https://raw.githubusercontent.com/daltonclaybrook/tween-controller/master/example.gif"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.authors            = { "Dalton Claybrook" => "daltonclaybrook@gmail.com" }
  s.social_media_url   = "http://twitter.com/daltonclaybrook"

  s.source       = { :git => "https://github.com/daltonclaybrook/tween-controller.git", :tag => s.version }
  
  s.source_files  = ["TweenController/*.swift", "TweenController/TweenController.h"]
  s.public_header_files = ["TweenController/TweenController.h"]
  
  s.requires_arc = true

end