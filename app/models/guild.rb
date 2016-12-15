class Guild < ActiveRecord::Base

  validates :name, uniqueness: { scope: [:region] }
end
