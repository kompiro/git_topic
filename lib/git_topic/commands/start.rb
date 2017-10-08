# frozen_string_literal: true

module GitTopic
  module Commands
    # this command starts topic to create branch
    class Start
      def initialize(topic_name)
        @topic_name = topic_name
      end

      def execute
        create_branch
        summary = read_summary
        summary_to_branch summary
        puts "start `#{@topic_name}`"
      end

      private

      def create_branch
        command = "git checkout -b #{@topic_name}"
        system(command)
      end

      def read_summary
        command = "git config --get topic.#{@topic_name}"
        _stdin, stdout, _stderr, _wait_thr = *Open3.popen3(command)
        stdout.readline
      end

      def summary_to_branch(summary)
        system("git config --add branch.#{@topic_name}.description #{summary}")
      end
    end
  end
end
