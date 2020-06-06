require_relative "../sepia"

module Strategy
  class Random
    def initialize(io:, dirpath:, **deps)
      @io = io
      @dirpath = dirpath
      @project_klass = deps.fetch(:project, Project)
    end

    def call
      lines.map do |line|
        color = String.colors.sample
        project.extract_line(line).colorize(color)
      end.join
    end

    private

    attr_reader :io, :dirpath, :project_klass

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
