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
    validation_result = validate_rows(sudoku_array)
    if validation_result[0] and validation_result[1]
      return "Sudoku is valid but incomplete."
    elsif validation_result[0] and !validation_result[1]
      return "Sudoku is valid."
    else
      return "Sudoku is invalid."
    end
  end

  def validate_rows(sudoku_array)
    valid = true
    not_complete = false
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
          if(sudoku_line.include? 0)
            not_complete = true
          end
        numbers = []
        end
    end
    return valid, not_complete
  end


end
