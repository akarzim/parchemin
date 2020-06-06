require "dry/cli"
require_relative "../sepia"

module Parchemin
  module CLI
    module Commands
      module Color
        class Colors < Dry::CLI::Command
          desc "return array of all possible colors names"

          def call(**options)
            puts String.colors
          end
        end

        class Modes < Dry::CLI::Command
          desc "return array of all possible modes"

          def call(*)
            puts String.modes
          end
        end

        class Samples < Dry::CLI::Command
          desc "displays color samples in all combinations"

          def call(*)
            puts String.color_samples
          end
        end

        class Disabled < Dry::CLI::Command
          desc "check if colorization is disabled"

          def call(*)
            puts String.disable_colorization
          end
        end
      end
    end
  end
end
