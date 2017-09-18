require 'term/ansicolor'

module GitTopic
  module Commands
    # list command shows summarized topic information
    class List
      include Term::ANSIColor
      def execute
        branches, current_branch = parse_branch
        branches.each do |branch_name|
          begin
            print_line(current_branch, branch_name)
          rescue EOFError => _ex
            nop
          end
        end
      end

      def parse_branch
        branches = []
        current_branch = nil
        _stdin, stdout, _stderr, _wait_thr = *Open3.popen3('git branch')
        stdout.each do |line|
          matched = line.match(/\s*(\* )?(.*)/)
          next unless matched
          branches << branch_name = matched[2]
          current_branch = branch_name if matched[1]
        end
        [branches, current_branch]
      end

      def print_line(current_branch, branch_name)
        description = get_description_of branch_name
        branch_format = if branch_name == current_branch
                          "* #{green}#{bold}%-20s#{clear}"
                        else
                          "  #{bold}%-20s#{clear}"
                        end
        printf "#{branch_format} %s", branch_name, description
      end

      def get_description_of(branch)
        config_key = "branch.#{branch}.description"
        command = "git config #{config_key}"
        _stdin, stdout, _stderr, _wait_thr = *Open3.popen3(command)
        stdout.readline
      end
    end
  end
end
