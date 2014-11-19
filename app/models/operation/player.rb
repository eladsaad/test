class Operation::Player < Player

	def self.additional_sort_columns
		['player_groups.name']
	end

end