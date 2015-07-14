# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  username   :string           not null
#

class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true

  has_many(
    :contacts,
    :class_name => "Contact",
    :foreign_key => :user_id,
    :primary_key => :id
  )

  has_many(
    :contact_shares,
    :class_name => "ContactShare",
    :foreign_key => :user_id,
    :primary_key => :id
  )

  has_many(
    :shared_contacts,
    :through => :contact_shares,
    :source => :contact
  )

  has_many :comments, :as => :commentable
end
