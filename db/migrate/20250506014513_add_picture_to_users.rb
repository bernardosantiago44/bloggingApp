class AddPictureToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :img_url, :string, null: false, default: "https://img.freepik.com/free-vector/blue-circle-with-white-user_78370-4707.jpg?t=st=1746497186~exp=1746500786~hmac=6a97e8e6a6563961084c0c1155dcb3733eaf92ab5a768b9c9dc6264a8dbc14fe&w=1380"
  end
end
