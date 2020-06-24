class CreateGardens < ActiveRecord::Migration[6.0]
  def change
    create_table :gardens do |t|
      t.text :flowers
      t.text :birds
      t.text :path

      t.timestamps
    end
  end
end
