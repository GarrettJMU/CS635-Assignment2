require 'test_helper'

class SpreadsheetTest < ActionDispatch::IntegrationTest
  test 'our instantiation is correct' do
    described_class = ::Concerns::Spreadsheet.new(::Concerns::ConcreteValueState.new)
    assert_equal(described_class.current_view, 'Value')
    assert_equal(described_class.cells.length, 9)
  end

  test 'we can change views currently' do
    described_class = ::Concerns::Spreadsheet.new(::Concerns::ConcreteValueState.new)
    assert_equal(described_class.current_view, 'Value')
    described_class.handle_equation_view
    assert_equal(described_class.current_view, 'Expression')
  end

  test 'we can change back view' do
    described_class = ::Concerns::Spreadsheet.new(::Concerns::ConcreteValueState.new)
    described_class.handle_equation_view
    assert_equal(described_class.current_view, 'Expression')
    described_class.handle_value_view

    assert_equal(described_class.current_view, 'Value')
  end

  test "our regex for numbers" do
    0...10.times do |i|
      assert_match(/\A-?\d+(\.\d+)?/, "#{i}")
    end
  end

  test 'our regex doesnt match math operators' do
    assert_no_match(/\A-?\d+(\.\d+)?/, '+')
    assert_no_match(/\A-?\d+(\.\d+)?/, '-')
    assert_no_match(/\A-?\d+(\.\d+)?/, '*')
    assert_no_match(/\A-?\d+(\.\d+)?/, 'a')
  end

  test 'our regex for +' do
    assert_match(/\A\+/, "+")
    assert_no_match(/\A\+/, "-")
    assert_no_match(/\A\+/, "*")
    assert_no_match(/\A\+/, "a")
  end

  test 'our regex for -' do
    assert_match(/\A\-/, "-")
    assert_no_match(/\A\-/, "+")
    assert_no_match(/\A\-/, "*")
    assert_no_match(/\A\-/, "a")
  end

  test 'our regex for *' do
    assert_match(/\A\*/, "*")
    assert_no_match(/\A\*/, "+")
    assert_no_match(/\A\*/, "-")
    assert_no_match(/\A\*/, "a")
  end

  test 'our regex for symbols' do
    assert_match(/\A\$A/, "$A")
  end

  test '+ operation' do
    assert_equal(::Concerns::Spreadsheet.new(::Concerns::ConcreteValueState.new).parse('2 1 +'), 3)
  end

  test '- operation' do
    assert_equal(::Concerns::Spreadsheet.new(::Concerns::ConcreteValueState.new).parse('2 1 -'), 1)
  end

  test '* operation' do
    assert_equal(::Concerns::Spreadsheet.new(::Concerns::ConcreteValueState.new).parse('2 3 *'), 6)
  end

  test '/ operation' do
    assert_equal(::Concerns::Spreadsheet.new(::Concerns::ConcreteValueState.new).parse('2 4 /'), 0.5)
  end

  test 'lg operation' do
    assert_equal(::Concerns::Spreadsheet.new(::Concerns::ConcreteValueState.new).parse('2 lg'), Math.log2(2))
  end

  test 'sin operation' do
    assert_equal(::Concerns::Spreadsheet.new(::Concerns::ConcreteValueState.new).parse('2 sin'), Math.sin(2))
  end


  # test 'that when the view is updated the cells are notified' do
    # described_class = ::Concerns::Spreadsheet.new(::Concerns::ConcreteValueState.new)
    # described_class.cells[0].equation_view = "0 2 +"
    # described_class.cells[0].value_view = "2"
    #
    # assert_equal(described_class.current_view, 'Value')
    # described_class.change_view
    # assert_equal(described_class.current_view, 'Expression')
    # assert_equal(described_class.cells[0].current_value, "0 2 +")
    #
    # described_class.change_view
    # assert_equal(described_class.current_view, 'Value')
    # assert_equal(described_class.cells[0].current_value, "2")
  # end

end
