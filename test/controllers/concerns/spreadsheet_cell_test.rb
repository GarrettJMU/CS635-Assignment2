require 'test_helper'

class SpreadsheetCellTest < ActionDispatch::IntegrationTest
  test 'our instantiation and getters/setters are correct' do
    described_class = ::Concerns::SpreadsheetCell.new
    described_class.expression_view = '$A $B +'
    described_class.value_view = '1'
    described_class.current_value = '1'
    assert_equal(described_class.expression_view, '$A $B +')
    assert_equal(described_class.value_view, '1')
    assert_equal(described_class.current_value, '1')
  end

  test 'adding an observer' do
    described_class = ::Concerns::SpreadsheetCell.new
    second_cell = ::Concerns::SpreadsheetCell.new
    described_class.add_observer(second_cell)
    assert_equal(described_class.observers.length, 1)
  end

  test 'removing observers' do
    described_class = ::Concerns::SpreadsheetCell.new
    second_cell = ::Concerns::SpreadsheetCell.new
    described_class.add_observer(second_cell)
    assert_equal(described_class.observers.length, 1)

    described_class.delete_observers
    assert_equal(described_class.observers.length, 0)
  end
end
