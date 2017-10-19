# frozen_string_literal: true

module GitTopic
  module Commands
    # Publish command pushes branch and create pull request from description.
    class Publish
      def initialize(topic_name)
        @topic_name = topic_name
      end

      def execute
        system("git push #{@topic_name}")
      end
    end
  end
end
