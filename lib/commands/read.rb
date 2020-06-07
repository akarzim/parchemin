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
        option :mode, default: :dark, values: %i[dark light], aliases: ["-m"], desc: "Colorization mode"

        example [
          "path/to/file                     # Run Parchemin on file",
          "--strategy=strata path/to/file   # Run Parchemin on file with strata strategy",
          "--mode=light path/to/file        # Run Parchemin on file using light mode"
        ]

        def call(file:, **options)
          filepath = File.expand_path(file)
          dirpath = File.dirname(filepath)
          filename = File.basename(filepath)

          if File.file?(filepath)
            io = IO.popen(["sh", "-c", "git blame #{filename}"], chdir: dirpath)

            puts colorize(io, dirpath, **options.slice(:mode, :strategy))
          else
            puts "File not found."
            exit 1
          end
        end

        private

        def colorize(io, dirpath, mode:, strategy:)
          case strategy
          when :scratch then Strategy::Scratch.new(io: io, dirpath: dirpath, mode: mode).call
          when :strata then Strategy::Strata.new(io: io, dirpath: dirpath, mode: mode).call
          when :random then Strategy::Random.new(io: io, dirpath: dirpath, mode: mode).call
          when :none then io.read
          end
        end
      end
    end
  end
end
