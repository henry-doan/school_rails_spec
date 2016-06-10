class School < ActiveRecord::Base
	validates_presence_of :name, :mascot, :year
	has_many :classrooms

	def name_mascot
		"#{name} home of the #{mascot}"
	end

	def school_age
		if (year >= 2000)
			"New"
		elsif (year >= 1800)
			"Pretty old"
		else
			"Way old"
		end
	end
end
