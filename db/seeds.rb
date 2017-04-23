# moustaches, category='moustaches' category_id=1
Category.create(name: 'moustaches')
11.times do |i|
  Addon.create!(url: "http://chas.ms/olio/moustaches/M#{i+1}.svg", initial_height: 100, initial_width: 150, category_id: 1)
end

# emojis, category='emojis', category_id=2
Category.create(name: 'emojis')
1837.times do |i|
  Addon.create!(url: "http://chas.ms/olio/emojis/E#{i+1}.svg", :initial_height => 100, :initial_width => 100, category_id: 2)
end

# fonts, category='text', category_id=3

Category.create(name: 'text')
Addon.fonts.each do |i|
  Addon.create!(url: "https://fonts.googleapis.com/css?family=#{i}", :initial_height => 200, :initial_width => 200, category_id: 3)
end

# Octosteve, category='miscellaneous', category_id=4
Category.create(name: 'miscellaneous')
Addon.create!(url: "http://chas.ms/olio/Octosteve.svg", :initial_height => 200, :initial_width => 200, category_id: 4)
