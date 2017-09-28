# frozen_string_literal: true

module GitTopic
  module Commands
    # show command shows branch description
    class Show
      def initialize(topic_name)
        if topic_name.nil?
          command = 'git rev-parse --abbrev-ref HEAD'
          _stdin, stdout, _stderr, _wait_thr = *Open3.popen3(command)
          topic_name = stdout.readline.chop
        end
        @topic_name = topic_name
      end

      def execute
        config_key = "branch.#{@topic_name}.description"
        system("git config #{config_key}")
      end
    end
  end
end
