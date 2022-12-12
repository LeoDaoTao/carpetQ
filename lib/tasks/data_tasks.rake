namespace :data do

  desc "Add Label Sizes"
  task seed_labels: :environment do
    Label.delete_all

    Label.create(
      name: 'Avery5160 (2.625 '' x 1'')',
      top_margin: 0.5,
      bottom_margin: 0.5,
      left_margin: 0.22,
      right_margin: 0.22,
      columns: 3,
      rows: 10,
      column_gutter: 0.21,
      row_gutter: 0
    )
  end

  desc "Set Default Settings"
  task seed_settings: :environment do
    Setting.sandbox                 = 'true'
    Setting.sandbox_delivery_email  = ''
    Setting.sandbox_delivery_phone  = ''
    Setting.gmail_user              = ''
    Setting.gmail_password          = ''
    Setting.name_from               = 'Carpet Cleaning'
    Setting.reminder_title          = 'Please Schedule Your Carpet Cleaning Appointment'
    Setting.reminder_email          = 'This is a reminder to schedule your appointment.'
    Setting.reminder_sms            = 'This is a reminder to schedule your appointment.'
    Setting.sms_number              = ''
    Setting.sms_account_sid         = ''
    Setting.sms_auth_token          = ''
  end

  desc "Seed initial Services"
  task seed_services: :environment do
    services = [
      'Carpet Cleaning',
      'Tile/Grout Cleaning',
      'Upholstery Cleaning',
      'Carpet Protector',
      'Upholstery Protector',
      'Grout Sealer',
      'Granite Sealer'
    ]

    services.each do |service|
      Service.create(name: service)
      puts "Created #{service}"
    end
    puts "Finished Seeding Services!!!"
  end

  desc "Seed initial Discounts"
  task seed_discounts: :environment do
    discounts = {
      '5%': 0.05,
      '10%': 0.10,
      '20%': 0.20,
      '30%': 0.30,
      '40%': 0.40
    }

    discounts.each do |name, value|
      Discount.create(name: name, value: value)
      puts "Created #{name}"
    end
    puts "Finished Seeding Discounts!!!"
  end

  desc "Normalize Customer Data by transfering Phone numbers in to separate table"
  task normalize_phones: :environment do
    Customer.all.each do |customer|
      Phone.create(customer_id: customer.id, number: customer.phone_home, label: "home") if customer.phone_home.present?
      Phone.create(customer_id: customer.id, number: customer.phone_work, label: "work") if customer.phone_work.present?
      Phone.create(customer_id: customer.id, number: customer.phone_mobile1, label: "mobile", textable: true) if customer.phone_mobile1.present?
      Phone.create(customer_id: customer.id, number: customer.phone_mobile2, label: "mobile", textable: true) if customer.phone_mobile2.present?
    end
  end

  desc "Clean non alpha characters from phone number"
  task clean_phones: :environment do
    Phone.all.each do |phone|
      phone.number = phone.number.gsub(/\D/, '')
      phone.save
    end
  end

  desc "Validate phone length"
  task validate_phones: :environment do
    Phone.all.each do |phone|
      puts phone.number if phone.number.length != 10
    end
  end

  desc "Sanitize email customer email field"
  task sanitize_email: :environment do
    Customer.all.each do |customer|
      customer.email = nil unless customer.email.present?
      customer.save
    end
  end
end
