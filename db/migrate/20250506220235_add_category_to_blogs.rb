class AddCategoryToBlogs < ActiveRecord::Migration[8.0]
  def change
    add_column :blogs, :category_id, :integer
  end
end
