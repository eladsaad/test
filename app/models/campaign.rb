class Campaign < ActiveRecord::Base

	# == VALIDATIONS ==
	validates :name, :presence => true
	validates :max_views, :numericality => { :greater_than => 0 }, allow_blank: true

	# == ASSOCIATIONS ==
	has_many :campaign_operator_programs, :inverse_of => :campaign, :dependent => :destroy
	accepts_nested_attributes_for :campaign_operator_programs, allow_destroy: true, reject_if: :all_blank

	# == SEARCH ==
	search_columns [:name]

end
