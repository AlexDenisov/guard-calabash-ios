require 'guard'
require 'guard/guard'
require 'guard/notifier'
require 'guard/calabash-ios/runner'

module Guard
  class CalabashiOS < Guard

    # Initialize a Guard.
    # @param [Array<Guard::Watcher>] watchers the Guard file watchers
    # @param [Hash] options the custom Guard options
    def initialize(watchers = [], options = {})
      super
      @options = {
          :all_on_start   => true,
      }.update(options)
    end

    # Call once when Guard starts. Please override initialize method to init stuff.
    # @raise [:task_has_failed] when start has failed
    def start
      @runner = Runner.new @options
      if @runner.nil?
        @raise [:task_has_failed]
      end
      notify_start
      run_all if @options[:all_on_start]
    end

    # Called when `stop|quit|exit|s|q|e + enter` is pressed (when Guard quits).
    # @raise [:task_has_failed] when stop has failed
    def stop
    end

    # Called when `reload|r|z + enter` is pressed.
    # This method should be mainly used for "reload" (really!) actions like reloading passenger/spork/bundler/...
    # @raise [:task_has_failed] when reload has failed
    def reload
    end

    # Called when just `enter` is pressed
    # This method should be principally used for long action like running all specs/tests/...
    # @raise [:task_has_failed] when run_all has failed
    def run_all
      run("features")
    end

    # Called on file(s) modifications that the Guard watches.
    # @param [Array<String>] paths the changes files or paths
    # @raise [:task_has_failed] when run_on_change has failed
    def run_on_change(paths)
      run(paths)
    end

    # Called on file(s) deletions that the Guard watches.
    # @param [Array<String>] paths the deleted files or paths
    # @raise [:task_has_failed] when run_on_change has failed
    def run_on_deletion(paths)
    end


    private

    def run(features)
      if @runner.run(features)
        notify_success
      else
        notify_failure
      end
    end

    def notify_start
      ::Guard::Notifier.notify 'Started successfully', :title => "Calabash-iOS", :image => :success
    end

    def notify_success
      ::Guard::Notifier.notify 'Success', :title => "Calabash-iOS", :image => :success
    end

    def notify_failure
      ::Guard::Notifier.notify 'Failed', :title => "Calabash-iOS", :image => :failed
    end

  end
end

