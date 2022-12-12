namespace :clean_db do
  desc "Clean Empty Quotes in DB"
  task clean_empty_string: :environment do
    records = Customer.all
    records.each do |record| 
      record.attributes.each do |column|
        p column
      end
      puts
    end
  end

end
