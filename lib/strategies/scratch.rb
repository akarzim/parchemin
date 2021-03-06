require_relative "../project"
require_relative "../repartition"
require_relative "../sepia"

module Strategy
  class Scratch
    def initialize(io:, dirpath:, mode:, **deps)
      @io = io
      @dirpath = dirpath
      @mode = mode
      @project_klass = deps.fetch(:project, Project)
      @repartition_klass = deps.fetch(:repartition, Repartition)
    end

    def call
      lines.map do |line|
        line_age = project.line_age(line)
        repartition = repartition_klass.new(line_age: line_age, first_commit_age: first_commit_age)

        project.extract_line(line).chars.map do |char|
          sample = repartition.call
          color = String.colors[sample]
          char.colorize(color: color, mode: mode)
        end.join
      end.join
    end

    private

    attr_reader :io, :dirpath, :mode, :project_klass, :repartition_klass

    def lines
      io.readlines
    end

    def project
      @project ||= project_klass.new(dirpath: dirpath)
    end

    def first_commit_age
      project.initial_commit_age
    end
  end
end
