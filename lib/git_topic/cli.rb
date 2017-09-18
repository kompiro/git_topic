require 'thor'
require 'open3'
require 'git_topic/commands/list'

module GitTopic
  # CLI command entry point
  class Cli < Thor
    default_command :list

    desc 'list', 'Show managed topics'
    def list
      command = GitTopic::Commands::List.new
      command.execute
    end

    desc 'add branch_name, summary', 'Remember topic'
    def add(branch_name, summary)
      puts "#{branch_name}, #{summary}"
      raise 'not implemented'
    end

    desc 'start branch_name', 'Start to write code to topic branch'
    def start(branch_name)
      puts branch_name
      raise 'not implemented'
    end

    desc 'publish branch_name', 'Create pull request using branch description'
    def publish(branch_name)
      puts branch_name
      raise 'not implemented'
    end
  end
end
