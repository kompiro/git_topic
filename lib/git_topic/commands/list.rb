module GitTopic
  module Commands
    # list command shows summarized topic information
    class List
      def execute
        Open3.popen3 'git branch' do |_stdin, stdout|
          stdout.each do |branch|
            puts branch
          end
        end
      end
    end
  end
end
