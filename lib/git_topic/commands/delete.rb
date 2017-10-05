# frozen_string_literal: true

module GitTopic
  module Commands
    # delete command deletes topic
    class Delete
      def initialize(topic_name)
        @topic_name = topic_name
      end

      def execute
        system("git config --unset topic.#{@topic_name}")
      end
    end
  end
end
