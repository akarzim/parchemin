require "stringio"
require "dry/cli"
require_relative "../strategies"

module Parchemin
  module CLI
    module Commands
      class Read < Dry::CLI::Command
        desc "Read the given file"

        argument :file, required: true, desc: "File to read"
        option :strategy, default: :random, values: %i[scratch strata random none], aliases: ["-s"], desc: "Colorization strategy"

        example [
          "path/to/file # Run Parchemin from file"
        ]

        def call(file:, **options)
          filepath = File.expand_path(file)
          dirpath = File.dirname(filepath)
          filename = File.basename(filepath)

          if File.file?(filepath)
            io = IO.popen(["sh", "-c", "git blame #{filename}"], chdir: dirpath)

            puts colorize(io, dirpath, strategy: options.fetch(:strategy))
          else
            puts "File not found."
            exit 1
          end
        end

        private

        def colorize(io, dirpath, strategy:)
          case strategy
          when :scratch then Strategy::Scratch.new(io: io, dirpath: dirpath).call
          when :strata then Strategy::Strata.new(io: io, dirpath: dirpath).call
          when :random then Strategy::Random.new(io: io, dirpath: dirpath).call
          when :none then io.read
          end
        end
      end
    end
  end
end
