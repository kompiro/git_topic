# frozen_string_literal: true

module GitTopic
  module Commands
    # this command starts topic to create branch
    class Start
      def initialize(topic_name)
        @topic_name = topic_name
      end

      def execute
        command = "git config --get topic.#{@topic_name}"
        _stdin, stdout, _stderr, _wait_thr = *Open3.popen3(command)
        puts stdout
      end
    end
  end
end
