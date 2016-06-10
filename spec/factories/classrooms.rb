FactoryGirl.define do
  factory :classroom, class: Classroom do
    name "Full stack summer 2016"
    size 14
		school
    trait :lrg do
				size 200
			end

		trait :lrg_eq do
			size 100
		end

		trait :descent do
			size 60
		end

		trait :descent_eq do
			size 50
		end
		
  end
end
