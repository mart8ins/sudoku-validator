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
    valid_row, not_complete_row = validate_rows(sudoku_array)
    valid_col, not_complete_col = validate_cols(sudoku_array)

    if !valid_row or !valid_col
      return "Sudoku is invalid."
    elsif valid_row and not_complete_row or valid_col and not_complete_col
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
    valid = true
    not_complete = true
    numbers = []

    for sudoku_line in sudoku_array
        if !valid
          break
        else
          for number_in_line in sudoku_line
            if number_in_line != 0
              if numbers.include? number_in_line
                valid = false
                break
              end
              numbers.push(number_in_line)
            end
        end
          if(!sudoku_line.include? 0)
            not_complete = false
          end
        numbers = []
        end
    end
    return valid, not_complete
  end

end
