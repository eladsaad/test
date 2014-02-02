namespace :db do
  desc "Adding language codes"
  task add_language_codes: :environment do

    language_codes = { 'HE' => 'Hebrew',
      'EN' => 'English',
      'SP' => 'Spanish' }

    language_codes.each do |key, value|
      language_code = LanguageCode.find_by_code(key)
      if language_code.nil?
        language_code = LanguageCode.new
        language_code.code = key
        language_code.name = value
        language_code.save!
      else
        puts "Language code #{key} already exist"
      end
    end

  end
end
