class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :posts, dependent: :destroy

  has_many :authentications, :dependent => :destroy
  #has_one :authentications, :dependent => :destroy
  accepts_nested_attributes_for :authentications
end
