["straightedge","drug free","straightedge curious","some cigarettes/alcohol/drugs"].each do |label|
  Label.create!(:name => label)
end

%w(raw vegan vegetarian pescatarian kosher freegan omnivore).each do |diet|
  Diet.create!(:name => diet)
end
