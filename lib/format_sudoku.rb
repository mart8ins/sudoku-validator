module SudokuFormater

    def clean_sudoku_string_split_lines(sudoku_input)
        return sudoku_input.gsub(/[-+\|s]/, "").lines.map(&:chomp).reject(&:empty?)
    end

    def create_two_dimensional_array(sudoku_input)
        cleaned_sudoku = clean_sudoku_string_split_lines(sudoku_input)
        sudoku_array = []
        for index in 0..cleaned_sudoku.length - 1
            sudoku_array[index] = cleaned_sudoku[index].split(" ").map(&:to_i)
        end
        return sudoku_array
    end

    def rotate_array(sudoku_array)
        rotated_array = Array.new(9) { Array.new }
        for i in 0..sudoku_array.length - 1
            for j in 0..sudoku_array[i].length - 1
                rotated_array[j][i] = sudoku_array[i][j]
            end
        end
        return rotated_array
    end

end
