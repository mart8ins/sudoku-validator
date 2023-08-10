# frozen_string_literal: true

# Module SudokuFormater
#
# This module provides methods to format sudoku game from file input
module SudokuFormater
  def clean_sudoku_string_split_lines(sudoku_input)
    sudoku_input.gsub(/[-+|s]/, '').lines.map(&:chomp).reject(&:empty?)
  end

  def create_two_dimensional_array(sudoku_input)
    cleaned_sudoku = clean_sudoku_string_split_lines(sudoku_input)
    sudoku_array = []
    cleaned_sudoku.each_with_index do |row, index|
      sudoku_array[index] = row.split(' ').map(&:to_i)
    end
    sudoku_array
  end

  def rotate_array(sudoku_array)
    sudoku_array.transpose
  end
end
