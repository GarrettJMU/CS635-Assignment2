module Concerns
  class Spreadsheet
    attr_accessor :cell1, :cell2, :cell3, :cell4, :cell5, :cell6, :cell7, :cell8, :cell9, :current_view

    def initalize
      @cell1 = SpreadsheetCell.new
      @cell2 = SpreadsheetCell.new
      @cell3 = SpreadsheetCell.new
      @cell4 = SpreadsheetCell.new
      @cell5 = SpreadsheetCell.new
      @cell6 = SpreadsheetCell.new
      @cell7 = SpreadsheetCell.new
      @cell8 = SpreadsheetCell.new
      @cell9 = SpreadsheetCell.new
      @current_view = 'visual'
    end
  end
end
