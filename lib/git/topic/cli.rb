require 'thor'
require 'open3'

module Git
  module Topic
    # CLI command entry point
    class Cli < Thor
      default_command :list

      desc 'list', 'Show managed topics'
      def list
        Open3.popen3 'git branch' do |_stdin, stdout|
          stdout.each do |branch|
            puts branch
          end
        end
      end

      desc 'add SUMMARY', 'Remember topic'
      def add(summary)
        puts summary
      end
    end
  end
end
