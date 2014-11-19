class Operation::PlayerGroup < PlayerGroup
	has_many :players, class_name: 'Operation::Player'
end
