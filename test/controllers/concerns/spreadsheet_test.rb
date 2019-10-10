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
    assert_equal(::Concerns::Spreadsheet.new(::Concerns::ConcreteValueState.new).parse('2 1 +', 1), 3)
  end

  test '- operation' do
    assert_equal(::Concerns::Spreadsheet.new(::Concerns::ConcreteValueState.new).parse('2 1 -', 1), 1)
  end

  test '* operation' do
    assert_equal(::Concerns::Spreadsheet.new(::Concerns::ConcreteValueState.new).parse('2 3 *',1), 6)
  end

  test '/ operation' do
    assert_equal(::Concerns::Spreadsheet.new(::Concerns::ConcreteValueState.new).parse('2 4 /', 1), 0.5)
  end

  test 'lg operation' do
    assert_equal(::Concerns::Spreadsheet.new(::Concerns::ConcreteValueState.new).parse('2 lg ',1 ), Math.log2(2))
  end

  test 'sin operation' do
    assert_equal(::Concerns::Spreadsheet.new(::Concerns::ConcreteValueState.new).parse('2 sin', 1), Math.sin(2))
  end

  test 'value view' do
    described_class = ::Concerns::Spreadsheet.new(::Concerns::ConcreteValueState.new)
    described_class.cells.each_with_index do |cell, index|
      described_class.handle_value_view(cell, "#{index}")
      assert_equal(cell.value_view, "#{index}")
      assert_equal(cell.current_value, "#{index}")
    end
  end

  test 'expression view' do
    described_class = ::Concerns::Spreadsheet.new(::Concerns::ConcreteValueState.new)
    described_class.cells.each_with_index do |cell, index|
      described_class.handle_value_view(cell, "#{index}")
      assert_equal(cell.value_view, "#{index}")
      assert_equal(cell.current_value, "#{index}")
    end

    described_class.handle_equation_view

    described_class.cells.each_with_index do |cell, index|
      described_class.handle_equation_view(cell, "#{index}")
      assert_equal(cell.expression_view, "#{index}")
      assert_equal(cell.current_value, "#{index}")
    end


  end

  test 'flipping between views' do
    described_class = ::Concerns::Spreadsheet.new(::Concerns::ConcreteValueState.new)
    described_class.cells.each_with_index do |cell, index|
      described_class.handle_value_view(cell, "#{index}")
      assert_equal(cell.value_view, "#{index}")
      assert_equal(cell.current_value, "#{index}")
    end

    described_class.handle_equation_view
    described_class.handle_equation_view(described_class.cells[0], '$I $H +')
    assert_equal(described_class.cells[0].value_view, 15.0)
    assert_equal(described_class.cells[0].current_value, '$I $H +')
    assert_equal(described_class.cells[0].expression_view, '$I $H +')

    described_class.handle_value_view
    assert_equal(described_class.cells[0].current_value, 15.0)

  end

  test 'observers properly update' do
    described_class = ::Concerns::Spreadsheet.new(::Concerns::ConcreteValueState.new)
    described_class.cells[0].value_view = '1'
    described_class.handle_equation_view
    described_class.handle_equation_view(described_class.cells[1], '$A 6 *')

    assert_equal(described_class.cells[0].current_value, "1")
    assert_equal(described_class.cells[1].value_view, 6)
    assert_equal(described_class.cells[0].count_observers, 1)

    described_class.handle_equation_view(described_class.cells[0], '2')
    assert_equal(described_class.cells[1].value_view, 12.0)
  end

  # test 'circular dependency' do
  #   described_class = ::Concerns::Spreadsheet.new(::Concerns::ConcreteValueState.new)
  #   described_class.cells[0].value_view = 1
  #   described_class.handle_equation_view
  #
  #   described_class.handle_equation_view(described_class.cells[1], '$A $C +')
  #   described_class.handle_equation_view(described_class.cells[2], '$D 1 +')
  #   described_class.handle_equation_view(described_class.cells[3], '$B 2 *')
  #
  #   assert_equal(described_class.cells[0].current_value, 1)
  #   assert_equal(described_class.cells[1].value_view, 1.0)
  #   assert_equal(described_class.cells[2].value_view, 1.0)
  #   assert_equal(described_class.cells[3].value_view, 2.0)
  # end

end
