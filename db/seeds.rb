# moustaches, category='moustaches' category_id=1
Category.create(name: 'moustaches')
11.times do |i|
  Addon.create!(url: "http://chas.ms/olio/moustaches/M#{i+1}.svg", initial_height: 300, initial_width: 300, category_id: 1)
end

# emojis, category='emojis', category_id=2
Category.create(name: 'emojis')
1837.times do |i|
  Addon.create!(url: "http://chas.ms/olio/emojis/E#{i+1}.svg", :initial_height => 100, :initial_width => 100, category_id: 2)
end

# Octosteve, category='miscellaneous', category_id=3
Category.create(name: 'miscellaneous')
Addon.create!(url: "http://chas.ms/olio/Octosteve.svg", :initial_height => 500, :initial_width => 750, category_id: 3)
