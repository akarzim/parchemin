require "dry/cli"

module Parchemin
  module CLI
    module Commands
      class Version < Dry::CLI::Command
        desc "Print version"

        def call(*)
          puts "0.1.0"
        end
      end
    end
  end
end
