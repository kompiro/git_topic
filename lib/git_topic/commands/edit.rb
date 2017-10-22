# frozen_string_literal: true

module GitTopic
  module Commands
    # edit command edits branch description
    class Edit
      def initialize(topic_name)
        @topic_name = topic_name
      end

      def execute
        system("git branch --edit-description #{@topic_name}")
        true
      rescue e
        puts e.message
        true
      end
    end
  end
end
