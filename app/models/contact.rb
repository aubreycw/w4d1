# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  email      :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Contact < ActiveRecord::Base
  validates :email, :name, :user_id, presence: true
  validates :email, :uniqueness => { :scope => :user_id } # :email_unique_for_user

  # def email_unique_for_user
  #   contacts = User.find(:user_id).contacts
  #   emails = contacts.map(:&email)
  #   if emails.include?(:email)
  #     errors[email] << "email already recorded for this user"
  #   end
  # end

  belongs_to(
    :user,
    :class_name => "User",
    :foreign_key => :user_id,
    :primary_key => :id
  )

  has_many(
    :contact_shares,
    :class_name => "ContactShare",
    :foreign_key => :contact_id,
    :primary_key => :id
  )

  has_many(
    :shared_users,
    :through => :contact_shares,
    :source => :user
  )
end
