class School < ActiveRecord::Base
	validates_presence_of :name, :mascot, :year

	def name_mascot
		"#{name} home of the #{mascot}"
	end

	def school_age
		school_age = year.to_i
		if(school_age >= 2000)
			"New"
		elsif (school_age >= 1800)
			"Pretty old"
		else
			"Way old"
		end
	end
end
