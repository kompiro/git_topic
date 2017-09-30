# frozen_string_literal: true

module GitTopic
  module Commands
    # add command register topic summary
    class Add
      def initialize(topic_name, summary)
        @topic_name = topic_name
        @summary = summary
      end

      def execute
        system("git config --add topic.#{@topic_name} #{@summary}")
      end
    end
  end
end
