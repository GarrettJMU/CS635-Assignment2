class SpreadsheetController < ApplicationController
  before_action :instantiate_if_needed
  # include './concerns/spreadsheet_cell.rb'

  def equation
    render 'equation'
  end

  def value
    render 'value'
  end

  def instantiate_if_needed
    # @spreadsheet =
    @cell1 ||= ::Concerns::SpreadsheetCell.new
    @cell2 ||= ::Concerns::SpreadsheetCell.new
    @cell3 ||= ::Concerns::SpreadsheetCell.new
    @cell4 ||= ::Concerns::SpreadsheetCell.new
    @cell5 ||= ::Concerns::SpreadsheetCell.new
    @cell6 ||= ::Concerns::SpreadsheetCell.new
    @cell7 ||= ::Concerns::SpreadsheetCell.new
    @cell8 ||= ::Concerns::SpreadsheetCell.new
    @cell9 ||= ::Concerns::SpreadsheetCell.new
  end

end
