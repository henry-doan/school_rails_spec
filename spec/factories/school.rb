FactoryGirl.define do
		factory :school, class: School do
			name "Devpoint Labs"
			mascot "programmers"
			year 2013

			trait :one do
				year 2000
			end

			trait :two do
				year 1900
			end

			trait :three do
				year 1800
			end

			trait :four do
				year 1500
			end
		end
end