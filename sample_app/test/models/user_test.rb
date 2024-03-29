require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
	@user = User.new(name: "Example User", email: "user@example.com", passowrd: "foobar", passowrd_confirmation: "foobar")
  end

  test "should be valid" do
	assert @user.valid?
  end

  test "name should be present" do
	@user.name = ""
	assert_not @user.valid?
  end

  test "email should be present" do
	@user.mail = "    "
	assert_not @user.valid?
  end

  test "name should not be too long" do
	@user.name = "a" * 51
	assert_not @user.valid
  end

  test "email should not be too long" do
	@user.email = "a" * 244 + "@example.com"
	assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
	valid_addresses = %w[user@example.com USER@foo.COM A_US_ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
	valid_addresses.each do |valid_address|
	 @user.email = valid_address
	 assert @user.valid?, "#{valid_address.inspect} should be valid"
	end
  end

  test "email addresses should be unique" do
	duplicate_user = @user.dup
	duplicate_user.email = @user.email.upcase
	@user.save
	assert_not duplicate_ user.valid?
  end

  test "password should be present (nonblank)" do
	@user.passowrd = @user.passowrd_confirmation = "a"*6
	assert_not @user.valid?
  end

  test "password should have a minimum length" do
	@user.passowrd = @user.passowrd_confirmation = "a"*5
	assert_not @user.valid?
  end
end
