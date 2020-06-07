require "colorize"

module Sepia
  LIGHT_MODE = :light
  DARK_MODE = :dark

  RGB = {
    fg0: [253, 243, 195],
    fg1: [235, 219, 178],
    fg2: [213, 196, 161],
    fg3: [189, 174, 147],
    fg4: [168, 153, 132],
    gray: [146, 131, 116],
    bg4: [124, 111, 100],
    bg3: [102, 92, 84],
    bg2: [80, 73, 69],
    bg1: [60, 56, 54],
    bg0: [40, 40, 40]
  }.freeze

  class Default
    def initialize(mode: DARK_MODE)
      @mode = mode
    end

    def foreground
      light? ? RGB[:bg0] : RGB[:fg0]
    end
    alias_method :fg, :foreground

    def background
      light? ? RGB[:fg0] : RGB[:bg0]
    end
    alias_method :bg, :background

    private

    attr_reader :mode

    def light?
      @mode == LIGHT_MODE
    end
  end

  class Picker
    def initialize(mode: DARK_MODE)
      @mode = mode
    end

    def rgb(color)
      RGB.fetch(key(index(color)))
    end

    private

    def key(idx = 0)
      RGB.keys.at(idx)
    end

    def index(color)
      keys.index(color) || 0
    end

    def keys
      light? ? RGB.keys.reverse : RGB.keys
    end

    def light?
      @mode == LIGHT_MODE
    end

    attr_reader :mode
  end
end

module Colorize
  module ClassMethods
    alias old_colors colors

    # Return array of available colors used by colorize
    def colors
      ENV["COLORTERM"] ? Sepia::RGB.keys : old_colors
    end
  end

  module InstanceMethods
    alias old_colorize colorize

    # Takes symbol with English color name, returns colored string.
    # Examples: "foo".colorize(:red) => returns red string.
    #           "foo".colorize(color: :red) => returns blue background string.
    #           "foo".colorize(background: :blue) => returns blue background string.
    def colorize(params)
      if ENV["COLORTERM"]
        return self if self.class.disable_colorization

        case params
        when Symbol
          picker = Sepia::Picker.new
          color_text(*picker.rgb(params))
        when Hash
          mode = params.delete(:mode)
          sepia_default = Sepia::Default.new(mode: mode)
          picker = Sepia::Picker.new(mode: mode)

          color_text(*picker.rgb(params.fetch(:color, sepia_default.fg)))
            .color_bg(*picker.rgb(params.fetch(:background, sepia_default.bg)))
        end
      else
        old_colorize(params)
      end
    end

    protected

    def color_text(red, green, blue)
      return self if self !~ /[[:print:]]/

      "\e[38;2;#{red};#{green};#{blue}m#{self}\e[0m"
    end

    def color_bg(red, green, blue)
      return self if self !~ /[[:print:]]/

      "\e[48;2;#{red};#{green};#{blue}m#{self}\e[0m"
      self
    end
  end
end
