require "colorize"

module Sepia
  RGB = {
    fg0: [251, 241, 199],
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
  }
end

module Colorize::ClassMethods
  alias :old_colors :colors

  #
  # Return array of available colors used by colorize
  #
  def colors
    ENV["COLORTERM"] ? %i[fg0 fg1 fg2 fg3 fg4 gray bg4 bg3 bg2 bg1 bg0] : old_colors
  end
end

module Colorize::InstanceMethods
  alias :old_colorize :colorize

  # Takes symbol with English color name, returns colored string.
  # Examples: "foo".colorize(:red) => returns red string.
  #           "foo".colorize(color: :red) => returns blue background string.
  #           "foo".colorize(background: :blue) => returns blue background string.
  def colorize(params)
    if ENV["COLORTERM"]
      return self if self.class.disable_colorization

      case params
      when Symbol
        color_text(*Sepia::RGB.fetch(params, Sepia::RGB[:fg0]))
      when Hash
        color_text(*Sepia::RGB.fetch(params[:color], Sepia::RGB[:fg0])).
          color_bg(*Sepia::RGB.fetch(params[:background], Sepia::RGB[:bg0]))
      end
    else
      self.old_colorize(params)
    end
  end

  protected

  def color_text(r, g, b)
    "\033[38;2;#{r};#{g};#{b}m#{self}\u001b[0m"
  end

  def color_bg(r, g, b)
    "\033[48;2;#{r};#{g};#{b}m#{self}\u001b[0m"
  end
end
