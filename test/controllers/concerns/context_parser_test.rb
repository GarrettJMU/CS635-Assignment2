require 'test_helper'
module Concerns
  class ContextParser < ActionDispatch::IntegrationTest
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
    end

    test 'our regex for + doesnt collide with others' do
      assert_no_match(/\A\+/, "-")
      assert_no_match(/\A\+/, "*")
      assert_no_match(/\A\+/, "a")
    end

    test 'our regex for -' do
      assert_match(/\A\-/, "-")
    end

    test 'our regex for - doesnt collide with others' do
      assert_no_match(/\A\-/, "+")
      assert_no_match(/\A\-/, "*")
      assert_no_match(/\A\-/, "a")
    end

    test 'our regex for *' do
      assert_match(/\A\*/, "*")
    end

    test 'our regex for * doesnt collide with others' do
      assert_no_match(/\A\*/, "+")
      assert_no_match(/\A\*/, "-")
      assert_no_match(/\A\*/, "a")
    end
  end
end
