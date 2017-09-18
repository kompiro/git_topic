require 'thor'

module Git
  module Topic
    # CLI command entry point
    class Cli < Thor
      desc 'hello NAME', 'say hello to NAME'
      def hello(name)
        puts "Hello #{name}"
      end
    end
  end
end
