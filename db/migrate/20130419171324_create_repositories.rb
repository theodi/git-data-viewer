class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|

      t.timestamps
    end
  end
end
