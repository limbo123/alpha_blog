require "test_helper"

class CategiryTest < ActiveSupport::TestCase

  def setup
    @category = Category.new()
  end

  test "category should be valid" do
    @category.name = "Sports"
    assert @category.valid?
  end

  test "name shouldn't be empty" do
    @category.name = ""
    assert_not @category.valid?
  end

  test "name should be unique" do
    @category.name = "Category"
    @invalid_category = Category.new(name: "Category")

    @category.save
    assert_not @invalid_category.valid?
  end

  test "name should not be too short" do
    @category.name = "h"
    assert_not @category.valid?
  end

  test "name should not be too long" do
    @category.name = "a" * 21
    assert_not @category.valid?
  end
end
