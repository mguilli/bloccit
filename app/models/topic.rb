class Topic < ActiveRecord::Base
  has_many :posts, dependent: :destroy

  default_scope { order('created_at DESC') }
  scope :visible_to, -> (user){ user ? all : public}

  scope :public, -> {where(public: true)}
  scope :private, -> {where(public: false)}
end
