class User < ActiveRecord::Base
  has_many :textbooks
  has_secure_password

  def self.find_by_slug(slug)
    self.all.detect do |user|
      user.slug == slug
    end
  end

  def slug
    self.username.downcase.gsub(" ", "-")
  end
end
