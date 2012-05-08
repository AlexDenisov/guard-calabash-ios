module Guard
  class Runner
    attr_accessor :bundle_path
    attr_accessor :sdk
    attr_accessor :device
    def initialize(options)
      if options[:project].nil?
        project = Dir.glob("*.xcodeproj").first
        if project
          options[:project] = project.gsub(".xcodeproj","")
        else
          UI.info "You must specify project name at your Guardfile."
        end
      end
      self.bundle_path = bundle(options)
      self.sdk = options[:sdk]
    end

    def run(features)
      unless File.exists? self.bundle_path
        UI.info "Could not run Calabash. \n'#{self.bundle_path}' not found."
        return false
      end
      if features.eql?("features")
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
      "APP_BUNDLE_PATH='#{self.bundle_path}' OS=#{self.sdk} cucumber #{features} --require features"
    end

    def bundle(options)
      pwd = Dir::pwd
      project = options[:project]
      target = options[:target] || "frankified"
      config = options[:config] || "Debug"
      bundle_path = "#{pwd}/DerivedData/#{project}/Build/Products/#{config}-iphonesimulator/#{project}-cal.app"
    end
  end
end
