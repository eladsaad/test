class ScoreUpdate

	@@updates = []

	def self.reset!
		@@updates = []
	end

	def self.add(points, action_key)
		@@updates << { points: points, action: action_key }
	end

	def self.updates
		@@updates
	end

end