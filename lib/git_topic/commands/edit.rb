
module GitTopic
  module Commands
    # edit command edits branch description
    class Edit
      def initialize(topic_name)
        @topic_name = topic_name
      end

      def execute
        system("git branch --edit-description #{@topic_name}")
      end
    end
  end
end
