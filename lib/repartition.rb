class Repartition
  def initialize(line_age:, first_commit_age:)
    @line_age = line_age
    @first_commit_age = first_commit_age
  end

  def call
    matrix_line = proc { |repartition| MATRIX[repartition] }
    repartition = proc { |erosion| erosion * MATRIX.size - 1 }
    erosion = proc { |line_age, first_commit_age| line_age / first_commit_age }
    sample = proc { |matrix_line| matrix_line.sample }

    (erosion >> repartition >> matrix_line >> sample).call(line_age, first_commit_age)
  end

  private

  attr_reader :line_age, :first_commit_age

  MATRIX = [
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
    [0, 0, 0, 0, 0, 0, 0, 0, 1, 1],

    [0, 0, 0, 0, 0, 0, 0, 1, 1, 2],
    [0, 0, 0, 0, 0, 0, 1, 1, 1, 2],
    [0, 0, 0, 0, 0, 1, 1, 1, 2, 2],
    [0, 0, 0, 0, 1, 1, 1, 2, 2, 3],
    [0, 0, 0, 1, 1, 1, 1, 2, 2, 3],
    [0, 0, 1, 1, 1, 1, 1, 2, 2, 3],
    [0, 1, 1, 1, 1, 1, 1, 2, 2, 3],

    [1, 1, 1, 1, 1, 1, 1, 2, 2, 3],
    [1, 1, 1, 1, 1, 1, 2, 2, 2, 3],
    [1, 1, 1, 1, 1, 2, 2, 2, 3, 3],
    [1, 1, 1, 1, 2, 2, 2, 3, 3, 4],
    [1, 1, 1, 2, 2, 2, 2, 3, 3, 4],
    [1, 1, 2, 2, 2, 2, 2, 3, 3, 4],
    [1, 2, 2, 2, 2, 2, 2, 3, 3, 4],

    [2, 2, 2, 2, 2, 2, 2, 3, 3, 4],
    [2, 2, 2, 2, 2, 2, 3, 3, 3, 4],
    [2, 2, 2, 2, 2, 3, 3, 3, 4, 4],
    [2, 2, 2, 2, 3, 3, 3, 4, 4, 5],
    [2, 2, 2, 3, 3, 3, 3, 4, 4, 5],
    [2, 2, 3, 3, 3, 3, 3, 4, 4, 5],
    [2, 3, 3, 3, 3, 3, 3, 4, 4, 5],

    [3, 3, 3, 3, 3, 3, 3, 4, 4, 5],
    [3, 3, 3, 3, 3, 3, 4, 4, 4, 5],
    [3, 3, 3, 3, 3, 4, 4, 4, 5, 5],
    [3, 3, 3, 3, 4, 4, 4, 5, 5, 6],
    [3, 3, 3, 4, 4, 4, 4, 5, 5, 6],
    [3, 3, 4, 4, 4, 4, 4, 5, 5, 6],
    [3, 4, 4, 4, 4, 4, 4, 5, 5, 6],

    [4, 4, 4, 4, 4, 4, 4, 5, 5, 6],
    [4, 4, 4, 4, 4, 4, 5, 5, 5, 6],
    [4, 4, 4, 4, 4, 5, 5, 5, 6, 6],
    [4, 4, 4, 4, 5, 5, 5, 6, 6, 7],
    [4, 4, 4, 5, 5, 5, 5, 6, 6, 7],
    [4, 4, 5, 5, 5, 5, 5, 6, 6, 7],
    [4, 5, 5, 5, 5, 5, 5, 6, 6, 7],

    [5, 5, 5, 5, 5, 5, 5, 6, 6, 7],
    [5, 5, 5, 5, 5, 5, 6, 6, 6, 7],
    [5, 5, 5, 5, 5, 6, 6, 6, 7, 7],
    [5, 5, 5, 5, 6, 6, 6, 7, 7, 8],
    [5, 5, 5, 6, 6, 6, 6, 7, 7, 8],
    [5, 5, 6, 6, 6, 6, 6, 7, 7, 8],
    [5, 6, 6, 6, 6, 6, 6, 7, 7, 8],

    [6, 6, 6, 6, 6, 6, 6, 7, 7, 8],
    [6, 6, 6, 6, 6, 6, 7, 7, 7, 8],
    [6, 6, 6, 6, 6, 7, 7, 7, 8, 8],
    [6, 6, 6, 6, 7, 7, 7, 8, 8, 9],
    [6, 6, 6, 7, 7, 7, 7, 8, 8, 9],
    [6, 6, 7, 7, 7, 7, 7, 8, 8, 9],
    [6, 7, 7, 7, 7, 7, 7, 8, 8, 9],

    [7, 7, 7, 7, 7, 7, 7, 8, 8, 9],
    [7, 7, 7, 7, 7, 7, 8, 8, 8, 9],
    [7, 7, 7, 7, 7, 8, 8, 8, 9, 9],
    [7, 7, 7, 7, 8, 8, 8, 8, 9, 9],
    [7, 7, 7, 8, 8, 8, 8, 9, 9, 9],
    [7, 7, 8, 8, 8, 8, 8, 9, 9, 9],
    [7, 8, 8, 8, 8, 8, 8, 9, 9, 9],

    [8, 8, 8, 8, 8, 8, 8, 9, 9, 9],
    [8, 8, 8, 8, 8, 8, 9, 9, 9, 9],
    [8, 8, 8, 8, 8, 9, 9, 9, 9, 9],
    [8, 8, 8, 8, 9, 9, 9, 9, 9, 9],
    [8, 8, 8, 9, 9, 9, 9, 9, 9, 9],
    [8, 8, 9, 9, 9, 9, 9, 9, 9, 9],
    [8, 9, 9, 9, 9, 9, 9, 9, 9, 9],

    [9, 9, 9, 9, 9, 9, 9, 9, 9, 9]
  ]
end