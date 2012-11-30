module Guard
  class Runner
    attr_accessor :bundle_path
    attr_accessor :sdk
    attr_accessor :device
    attr_accessor :project
    attr_accessor :target
    attr_accessor :config
    attr_accessor :no_launch
    attr_accessor :reset_between_scenarios
    def initialize(options)
      self.sdk = init_sdk(options)
      self.device = init_device(options)
      self.project = init_project(options)
      self.target = init_target(options)
      self.config = init_config(options)
      self.no_launch = init_no_launch(options)
      self.reset_between_scenarios = init_reset_between_scenarios(options)
      self.bundle_path = init_bundle_path(options)
    end

    def init_sdk(options)
      sdks = [:ios4, :ios5]
      if sdks.include? options[:sdk]
        options[:sdk]
      else
        :ios5
      end
    end

    def init_device(options)
      devices = [:iphone, :ipad]
      if devices.include? options[:device]
        options[:device]
      else
        :iphone
      end
    end

    def init_project(options)
      if options[:project].nil?
        xproject = Dir.glob("*.xcodeproj").first
        if xproject
          xproject.gsub(".xcodeproj","")
        else
          UI.info "Could not find project"
          nil
        end
      else
        options[:project]
      end
    end

    def init_config(options)
      if options[:config].nil?
        "Debug"
      else
        options[:config]
      end
    end
    
    def init_no_launch(options)
      case options[:no_launch]
      when true
        1
      when false
        0
      end
    end

    def init_reset_between_scenarios(options)
      case options[:reset_between_scenarios]
      when true
        1
      when false
        0
      end
    end

    def init_target(options)
      if options[:target].nil?
        "#{self.project}-cal"
      else
        options[:target]
      end
    end

    def run(features)
      unless File.exists? self.bundle_path.to_s
        UI.info "Could not run Calabash. \n'#{self.bundle_path}' not found."
        return false
      end
      if features.eql?("features") or features.empty?
        start_message = "Run all features"
      else
        features = features.join(' ') if features.kind_of? Array
        start_message = "Run #{features}"
      end
      UI.info start_message
      system(command(features))
    end

    def command(features)
      if features.kind_of? Array
        features = features.join(' ')
      end
      cmd = []
      cmd << "APP_BUNDLE_PATH='#{self.bundle_path}'"
      cmd << "OS=#{self.sdk}"
      cmd << "DEVICE=#{self.device}"
      cmd << "NO_LAUNCH=#{self.no_launch}" if self.no_launch
      cmd << "RESET_BETWEEN_SCENARIOS=#{self.reset_between_scenarios}" if self.reset_between_scenarios
      cmd << "cucumber #{features} --require features"      
      cmd.join ' '
    end

    def init_bundle_path(options)
      path = []
      path << "#{Dir::pwd}/DerivedData/"
      path << "#{self.project}/"
      path << "Build/Products/"
      path << "#{self.config}-iphonesimulator/"
      path << "#{self.target}.app"
      path.join
    end
  end
end
