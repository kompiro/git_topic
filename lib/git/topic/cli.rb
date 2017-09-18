require 'thor'

module Git
  module Topic
    # CLI command entry point
    class Cli < Thor
      default_command :list
      desc 'hello NAME', 'say hello to NAME'
      def hello(name)
        puts "Hello #{name}"
      end

      desc 'list', 'show topics'
      def list
        puts 'list'
      end
    end
  end
end
