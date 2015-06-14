class Album < ActiveRecord::Base
	validates :name, presence: true
	validates :artist, presence: true

	has_and_belongs_to_many :users
end
