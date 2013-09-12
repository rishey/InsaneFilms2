class Post < ActiveRecord::Base
	belongs_to	:user
	has_many		:comments
	has_many		:commenters, class_name: "User", foreign_key: :user_id

	# validates 	:title, presense: true
	# validates 	:body, presense: true
end
