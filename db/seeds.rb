["straightedge","drug free","straightedge curious","some cigarettes/alcohol/drugs"].each do |label|
  Label.create!(:name => label)
end

%w(raw vegan vegetarian pescatarian kosher freegan omnivore).each do |label|
  Diet.create!(:name => diet)
end
