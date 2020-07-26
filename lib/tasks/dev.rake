namespace :dev do
  task :fetch_city => :environment do
    puts "Fetch city data..."
    response = RestClient.get "http://v.juhe.cn/weather/citys", :params => { :key => "0352f8c4f06f5df0f5075fb9422a7a0b
" }
    data = JSON.parse(response.body)

    data["result"].each do |c|
      existing_city = City.find_by_juhe_id( c["id"] )
      if existing_city.nil?
        City.create!( :juhe_id => c["id"], :province => c["province"],
                      :city => c["city"], :district => c["district"] )
      end
    end

    puts "Total: #{City.count} cities"
  end
end
