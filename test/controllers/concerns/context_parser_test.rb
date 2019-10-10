require 'test_helper'

class ContextParserTest < ActionDispatch::IntegrationTest

  test 'our regex for numbers' do
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
    assert_equal(::Concerns::ContextParser.new.parse('2 1 +', 1), 3)
  end

  test '- operation' do
    assert_equal(::Concerns::ContextParser.new.parse('2 1 -', 1), 1)
  end

  test '* operation' do
    assert_equal(::Concerns::ContextParser.new.parse('2 3 *',1), 6)
  end

  test '/ operation' do
    assert_equal(::Concerns::ContextParser.new.parse('2 4 /', 1), 0.5)
  end

  test 'lg operation' do
    assert_equal(::Concerns::ContextParser.new.parse('2 lg ',1 ), Math.log2(2))
  end

  test 'sin operation' do
    assert_equal(::Concerns::ContextParser.new.parse('2 sin', 1), Math.sin(2))
  end
end
