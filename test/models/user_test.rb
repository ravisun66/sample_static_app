require 'test_helper'

class UserTest < ActiveSupport::TestCase
	def setup
		@user = User.new name: 'Foo Bar', email: 'foo@example.com', password: 'hellotest', password_confirmation: 'hellotest'
	end
	test "should be valid" do
		assert @user.valid?
	end
	test "name should be present" do
		@user.name = "	"
		assert_not @user.valid?
	end
	test "email should be unique" do
		# duplicate_user = @user.dup
  #   duplicate_user.email = @user.email.upcase
  #   @user.save
  #   assert_not duplicate_user.valid?
		@user.save
		@user = User.new name: 'Rob dave', email: 'Foo@example.com'
		assert_not @user.valid?
	end
	test "email shoul be present" do
		@user.email = " "
		assert_not @user.valid?
	end
	test "email validation should accept valid email addresses" do
		valid_emails = %W"look@example.com over@aol.com loom@ymail.com over@exxample.in"
		valid_emails.each do |email|
			@user.email = email
			assert @user.valid?
		end
	end
	test "email shoul reject invalid email addresses" do 
		invalid_emails = %w"looma.com pee@c2bc...c2.com23 new@ne1w.co2over"
		invalid_emails.each do |email|
			@user.email = email
			assert_not @user.valid?, "#{@user.inspect} should be invalid"
		end
	end
	test "email should be saved as downcase" do
		mix_case_email = 'TEst@GMAil.CoM'
		@user = User.new(name: 'Robert william', email: mix_case_email, password: 'hellotest', password_confirmation: 'hellotest')
		@user.save
		assert_equal mix_case_email.downcase, @user.reload.email
	end
end
