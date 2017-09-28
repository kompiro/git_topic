# frozen_string_literal: true

require 'thor'
require 'open3'

require 'git_topic/version'
require 'git_topic/commands/list'
require 'git_topic/commands/edit'
require 'git_topic/commands/show'

module GitTopic
  # CLI command entry point
  class Cli < Thor
    default_command :list

    desc 'list', 'Show managed topics'
    option :version, aliases: 'v'
    def list
      # Show version if -v specified
      if options[:version]
        version if options[:version]
        return
      end

      command = GitTopic::Commands::List.new
      command.execute
    end

    desc 'edit [branch_name]', 'Edit topic description'
    def edit(branch_name = nil)
      command = GitTopic::Commands::Edit.new branch_name
      command.execute
    end

    desc 'show [branch_name]', 'Show topic description'
    def show(branch_name = nil)
      command = GitTopic::Commands::Show.new branch_name
      command.execute
    end

    desc 'version', 'Show version'
    def version
      puts GitTopic::VERSION
    end

    desc 'add topic_name', 'Remember topic'
    def add(topic_name)
      puts "add #{topic_name}"
      raise 'not implemented'
    end

    desc 'start topic_name', 'Transfer topic_name to branch to implement code'
    def start(topic_name)
      puts "start #{topic_name}"
      raise 'not implemented'
    end

    desc 'publish [branch_name]', 'Create pull request using branch description'
    def publish(branch_name)
      puts "publish #{branch_name}"
      raise 'not implemented'
    end
  end
end
