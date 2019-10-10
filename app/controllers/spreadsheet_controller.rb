class SpreadsheetController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :instantiate_if_needed

  # This is an anti-pattern, as I've essentially turned http requests from stateless to stateful,
  # but I did so for the sake of this assignment so I had something visual I could put in portfolio that is hosted.
  # As you can see I only instantiate the class once and all subsequent calls are done so on the same class variable

  @@spreadsheet ||= ::Concerns::Spreadsheet.new(::Concerns::ConcreteValueState.new)

  def index
    render 'spreadsheet'
  end

  def instantiate_if_needed
    @spreadsheet ||= @@spreadsheet
  end

  def change_view
    if params[:state] === 'Value'
      @@spreadsheet.handle_equation_view
    else
      @@spreadsheet.handle_value_view
    end
  end

  def update
    cell_index = params[:index].to_i
    value = params[:value].to_s
    if params[:state] === 'Value'
      @@spreadsheet.handle_value_view(@@spreadsheet.cells[cell_index], value)
    else
      @@spreadsheet.handle_equation_view(@@spreadsheet.cells[cell_index], value)
    end
  end

  def undo
    @@spreadsheet
  end

end
