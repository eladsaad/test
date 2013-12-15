namespace :db do
  desc "Fill DB with new registration codes"
  task fill_registration_codes: :environment do

    # get parameters
    amount = ENV['amount']

    # check parameter validity
    if amount.blank?
      puts "Usage is rake db:fill_registration_codes amount=AMOUNT_HERE"
    else
      # generate new codes
      first_new_id = RegistrationCode.count.zero? ? 1 : RegistrationCode.order(:id).last.id + 1
      last_new_id = first_new_id + amount.to_i - 1
      new_codes = [*first_new_id..last_new_id].shuffle!

      # insert new codes
      insert_count = 0
      new_codes.in_groups_of(1000, false) do |code_group|
        inserts = []
        code_group.each do |new_code|
          inserts << {code: new_code}
        end
        insert_count += inserts.length
        puts "Adding #{insert_count}/#{amount} new codes..."
        ActiveRecord::Base.transaction do
          RegistrationCode.create(inserts)
        end    
      end
    end
    
  end
end
