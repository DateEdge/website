class CreateDiets < ActiveRecord::Migration
  def self.up
    create_table :diets do |t|
      t.string :name

      t.timestamps
    end

    %w(raw vegan vegetarian pescatarian freegan kosher omnivore).each do |diet|
      Diet.create!(:name => diet)
    end
  end

  def self.down
    drop_table :diets
  end
end
