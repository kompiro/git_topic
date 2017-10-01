# frozen_string_literal: true

require 'git_topic/formatter/helper'
require 'term/ansicolor'

module GitTopic
  module Formatter
    # summarizes branches information
    class Branches
      include Term::ANSIColor
      include GitTopic::Formatter::Helper
      Branch = Struct.new('Branch', :name, :rev)

      def print
        puts '[Branches]'
        puts ''
        branches, current_branch = parse_branches
        print_header(branches.first)
        print_contents(branches, current_branch)
      end

      def print_header(branch)
        rev_length = branch.rev.length
        header_format = "  %-20s %-#{rev_length}s %s"
        puts format(header_format, :Branch, :Rev, :Summary)
        puts '-' * 80
      end

      def print_contents(branches, current_branch)
        branches.each do |branch|
          print_line(current_branch, branch)
        end
      end

      def parse_branches
        branches = []
        current_branch = nil
        _stdin, stdout, _stderr, _wait_thr = *Open3.popen3('git branch -v')
        stdout.each do |line|
          branch_name, rev, current_candidate = parse_branch(line)
          current_branch ||= current_candidate
          branches << Branch.new(branch_name, rev)
        end
        [branches, current_branch]
      end

      BRANCH_FORMAT = /
        \s*(?<current_exp>\*\ )?
        (?<branch_name>\S+)\s+
        (?<rev>\S+)\s+(.*)
      /x

      def parse_branch(line)
        matched = line.match(BRANCH_FORMAT)
        raise 'cannot parse branch' unless matched
        branch_name = matched[:branch_name]
        rev = matched[:rev]
        current_branch = matched[:current_exp] ? branch_name : nil
        [branch_name, rev, current_branch]
      end

      def print_line(current_branch, branch)
        branch_name = branch.name
        rev = branch.rev
        description = get_description_of branch
        return if description.nil?
        branch_format = branch_format(branch_name, current_branch)
        truncated_name = truncate(branch_name)
        puts format("#{branch_format} %s %s", truncated_name, rev, description)
      end

      def get_description_of(branch)
        config_key = "branch.#{branch.name}.description"
        command = "git config #{config_key}"
        _stdin, stdout, _stderr, _wait_thr = *Open3.popen3(command)
        return nil if stdout.eof?
        stdout.readline
      end

      def branch_format(branch_name, current_branch)
        if branch_name == current_branch
          "* #{green}#{bold}%-20s#{clear}"
        else
          "  #{bold}%-20s#{clear}"
        end
      end
    end
  end
end
