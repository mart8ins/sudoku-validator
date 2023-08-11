# frozen_string_literal: true

require_relative 'format_sudoku'
include SudokuFormater
# class Validator
#
# Class is used to validate sudoku games
class Validator
  def initialize(puzzle_string)
    @puzzle_string = puzzle_string
  end

  def self.validate(puzzle_string)
    new(puzzle_string).validate
  end

  def validate
    sudoku_array = SudokuFormater.create_two_dimensional_array(@puzzle_string)
    not_valid_subgroup, = validate_subgroups(sudoku_array)
    not_valid_row, not_complete_row = validate_rows(sudoku_array)
    not_valid_col, not_complete_col = validate_cols(sudoku_array)
    if not_valid_subgroup || not_valid_row || not_valid_col
      'Sudoku is invalid.'
    elsif !not_valid_row && not_complete_row || !not_valid_col && not_complete_col
      'Sudoku is valid but incomplete.'
    else
      'Sudoku is valid.'
    end
  end

  def validate_cols(sudoku_array)
    rotated_array = SudokuFormater.rotate_array(sudoku_array)
    validate_rows(rotated_array)
  end

  def validate_rows(sudoku_array)
    not_valid = false
    not_complete = false
    sudoku_array.each do |sudoku_line|
      break if not_valid

      not_valid = check_for_duplicates(sudoku_line)
      not_complete = true if sudoku_line.include? 0
    end
    [not_valid, not_complete]
  end

  def check_for_duplicates(sudoku_line)
    numbers = []
    not_valid = false
    sudoku_line.each do |number_in_line|
      next unless number_in_line != 0

      not_valid = true if (numbers.include? number_in_line) || number_in_line.negative? || (number_in_line > 9)
      numbers.push(number_in_line)
    end
    not_valid
  end

  def validate_subgroups(sudoku_array)
    subgroups = []
    subgroups.push(*get_sub_group(0, sudoku_array))
    subgroups.push(*get_sub_group(3, sudoku_array))
    subgroups.push(*get_sub_group(6, sudoku_array))
    validate_rows(subgroups)
  end

  def get_sub_group(start_index, array)
    group = []
    subgroup = []
    3.times do |j|
      subgroup.push(*array[j][start_index, 3])
    end
    group.push(subgroup)
    subgroup = []
    (3..5).each do |j|
      subgroup.push(*array[j][start_index, 3])
    end
    group.push(subgroup)
    subgroup = []
    (6..8).each do |j|
      subgroup.push(*array[j][start_index, 3])
    end
    group.push(subgroup)
    subgroup = []

    group
  end
end
