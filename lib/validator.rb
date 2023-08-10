require_relative "format_sudoku.rb"
include SudokuFormater

class Validator
  def initialize(puzzle_string)
    @puzzle_string = puzzle_string
  end

  def self.validate(puzzle_string)
    new(puzzle_string).validate
  end

  def validate
    sudoku_array =  SudokuFormater.create_two_dimensional_array(@puzzle_string)
    not_valid_row, not_complete_row = validate_rows(sudoku_array)
    not_valid_col, not_complete_col = validate_cols(sudoku_array)

    not_valid_subgroup, not_complete_subgroup = validate_subgroups(sudoku_array)

    if not_valid_subgroup or not_valid_row or not_valid_col
      return "Sudoku is invalid."
    elsif !not_valid_row and not_complete_row or !not_valid_col and not_complete_col
      return "Sudoku is valid but incomplete."
    else
      return "Sudoku is valid."
    end
  end

  def validate_cols(sudoku_array)
      rotated_array = SudokuFormater.rotate_array(sudoku_array)
      return validate_rows(rotated_array)
  end
  
  def validate_rows(sudoku_array)
    not_valid = false
    not_complete = false
    numbers = []

    for sudoku_line in sudoku_array
        if not_valid
          break
        else
          for number_in_line in sudoku_line
            if number_in_line != 0
              if numbers.include? number_in_line or number_in_line < 0 or number_in_line > 9
                not_valid = true
                break
              end
              numbers.push(number_in_line)
            end
        end
          if sudoku_line.include? 0
            not_complete = true
          end
        numbers = []
        end
    end
    return not_valid, not_complete
  end

  def validate_subgroups(sudoku_array)
    subgroups = []

    subgroups.push(get_sub_group(0,2,sudoku_array))
    subgroups.push(get_sub_group(3,5,sudoku_array))
    subgroups.push(get_sub_group(6,8,sudoku_array))

    return validate_rows(subgroups)
  end

  def get_sub_group(start_index, end_index, array)
    group = []
    for i in start_index..end_index
      group.push(*array[i][start_index,3])
    end
    return group
  end

end
