class Classroom < ActiveRecord::Base
	validates_presence_of :name
	belongs_to :school

	def class_name
		"#{name} classroom"
	end

	def class_size
		if (size >= 100)
			"Large"
		elsif (size >= 50)
			"Descent"
		else
			"Small"
		end
	end

end
