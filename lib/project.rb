require "date"

class Project
  BLAME_REGEX = /\A(?<commit>\^?[[:xdigit:]]{7,9})\s\((?<author>.+?)\s+(?<date>\d{4}-\d{2}-\d{2})\s(?<time>\d{2}:\d{2}:\d{2})\s(?<zone>[+-]\d{4})\s+(?<num>\d+)\)\s?(?<line>.*)$/

  def initialize(dirpath:)
    @dirpath = dirpath
  end

  def extract_line(line)
    extract_blame(line)[:line] + "\n"
  end

  def initial_commit_age
    @initial_commit_age ||= \
      begin
        date = initial_commit_date
        days_since(date)
      end
  end

  def line_age(line)
    date = extract_date(line)
    days_since(date)
  end

  private

  attr_reader :dirpath

  def days_since(since_date, until_date = Date.today)
    (until_date - since_date)
  end

  def extract_blame(line)
    line.match(BLAME_REGEX)
  end

  def extract_date(line)
    date = extract_blame(line)[:date]
    Date.parse(date)
  end

  def initial_commit_blame
    io = IO.popen(["sh", "-c", "git log --reverse --pretty='format:%h (%an %ad 0) ' --date=iso | head -n 1"], chdir: dirpath)
    io.readlines.first
  end

  def initial_commit_date
    line = initial_commit_blame
    extract_date(line)
  end
end
