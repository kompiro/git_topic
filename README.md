# git_topic 

![Travis CI](https://travis-ci.org/kompiro/git_topic.svg?branch=master)

`git topic` is a subcommand of git to manage your topic branches by branch description.

## Installation

Install it yourself as:

    $ gem install git_topic

## Usage

    Commands:
      git-topic [list] [-a]                 # Show managed topics
      git-topic edit [branch_name]     # Edit topic description
      git-topic show [branch_name]     # Show topic description
      git-topic add topic_name         # Remember topic
    
    Plan to support:
      git-topic start topic_name       # Transfer topic_name to branch to implement code
      git-topic publish [branch_name]  # Create pull request using branch description

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `OVERCOMMIT_DISABLED=1 bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kompiro/git-topic. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Git::Topics project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/kompiro/git-topic/blob/master/CODE_OF_CONDUCT.md).
