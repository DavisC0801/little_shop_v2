class AddsDefaultstoallTables < ActiveRecord::Migration[5.1]
  def change
    change_column_default(:users, :role, 0)
    change_column_default(:users, :active, true)
    change_column_default(:items, :active, true)
    change_column_default(:items, :image, "https://img.etimg.com/thumb/msid-64749432,width-643,imgsize-242955,resizemode-4/art-stealing-thief-thinkstockphotos-459021285.jpg")
    change_column_default(:order_items, :fulfilled, false)
    change_column_default(:orders, :status, 0)
  end
end
