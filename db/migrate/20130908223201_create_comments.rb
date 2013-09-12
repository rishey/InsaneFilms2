class CreateComments < ActiveRecord::Migration
  def change
  	create_table :comments do |t|
  		t.text 	 			:comment_text
  		t.string 			:password_digest
  		t.date				:date
  		t.integer			:post_id
  		t.integer			:user_id
  		t.timestamps
  	end
  end
end
