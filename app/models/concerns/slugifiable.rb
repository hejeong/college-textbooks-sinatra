module Slugifiable
  module ClassMethods
    def find_by_slug(slug)
      self.all.detect do |object|
        object.slug == slug
      end
    end
  end

  module InstanceMethods
    def slug
      self.username.downcase.gsub(" ", "-")
    end
  end

end
