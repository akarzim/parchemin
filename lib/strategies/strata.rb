require_relative "../project"
require_relative "../repartition"
require_relative "../sepia"

module Strategy
  class Strata
    def initialize(io:, dirpath:, **deps)
      @io = io
      @dirpath = dirpath
      @project_klass = deps.fetch(:project, Project)
      @repartition_klass = deps.fetch(:repartition, Repartition)
    end

    def call
      lines.map do |line|
        line_age = project.line_age(line)
        repartition = repartition_klass.new(line_age: line_age, first_commit_age: first_commit_age)
        sample = repartition.call
        color = String.colors[sample]
        project.extract_line(line).colorize(color)
      end.join
    end

    private

    attr_reader :io, :dirpath, :project_klass, :repartition_klass

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
