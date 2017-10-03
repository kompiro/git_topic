# frozen_string_literal: true

require 'term/ansicolor'

module GitTopic
  module Formatter
    # summarizes topics information
    # Topic means theme that not start to implement
    class Topics
      include Term::ANSIColor
      include GitTopic::Formatter::Helper

      def print
        puts "#{bold}[Topics]#{clear}"
        topics = parse_topics
        print_header
        print_contents topics
      end

      private

      def print_header
        header_format = '  %-20s %s'
        puts format(header_format, :Topic, :Summary)
        puts '-' * 80
      end

      Topic = Struct.new('Topic', :name, :summary)
      LIST_TOPIC_COMMAND = 'git config --get-regexp ^topic.\*'

      def parse_topics
        topics = []
        _stdin, stdout, _stderr, _wait_thr = *Open3.popen3(LIST_TOPIC_COMMAND)
        stdout.each do |line|
          name, summary = parse_topic(line)
          topics << Topic.new(name, summary)
        end
        topics
      end

      def parse_topic(line)
        matched = line.match(/topic\.(?<topic_name>\S+)\s+(?<summary>.*)/)
        raise 'cannot parse topic' unless matched
        topic_name = matched[:topic_name]
        summary = matched[:summary]
        [topic_name, summary]
      end

      def print_contents(topics)
        topics.each do |topic|
          print_line topic
        end
      end

      def print_line(topic)
        truncated_name = truncate(topic.name)
        summary = topic.summary
        puts format("  #{bold}%-20s#{clear} %s", truncated_name, summary)
      end
    end
  end
end
