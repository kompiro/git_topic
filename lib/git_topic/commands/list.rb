require 'term/ansicolor'

module GitTopic
  module Commands
    # list command shows summarized topic information
    class List
      include Term::ANSIColor
      def execute
        print_header
        print_contents
      end

      private

      Branch = Struct.new('Branch', :name, :rev)

      def print_header
        printf "  %-20s %-7s %s\n", 'Branch', 'Rev', 'Summary'
        puts '-' * 80
      end

      def print_contents
        branches, current_branch = parse_branches
        branches.each do |branch|
          begin
            print_line(current_branch, branch)
          rescue EOFError => _ex
            # nop
          end
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

      def parse_branch(line)
        matched = line.match(/\s*(\* )?(\S+)\s+(\S+)\s+(.*)/)
        raise 'cannot parse branch' unless matched
        branch_name = matched[2]
        current_branch = matched[1] ? branch_name : nil
        rev = matched[3]
        [branch_name, rev, current_branch]
      end

      def print_line(current_branch, branch)
        branch_name = branch.name
        rev = branch.rev
        description = get_description_of branch_name
        branch_format = if branch_name == current_branch
                          "* #{green}#{bold}%-20s#{clear}"
                        else
                          "  #{bold}%-20s#{clear}"
                        end
        printf "#{branch_format} %s %s", branch_name, rev, description
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
