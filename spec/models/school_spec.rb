require 'rails_helper'

RSpec.describe School, type: :model do
	describe 'validations' do
		it { should validate_presence_of :name }
		it { should validate_presence_of :mascot }
		it { should validate_presence_of :year }
	end

	describe '#name_mascot' do
		it 'returns the name and mascot message' do
			school = School.create(name: "Devpoint Labs",
														mascot: "programmers",
														year: "2013")
			expect(school.name_mascot).to eq("#{school.name} home of the #{school.mascot}")
		end
	end

	describe '#school_age' do
		it 'returns new if the school year is > 2000' do
			school = School.create(name: "Devpoint Labs",
														mascot: "programmers",
														year: "2013")
			expect(school.school_age).to eq('New')
		end

		it 'returns new if the school year is == 2000' do
			school = School.create(name: "Devpoint Labs",
														mascot: "programmers",
														year: "2000")
			expect(school.school_age).to eq('New')
		end

		it 'return Pretty old if the school year is > 1800' do
			school = School.create(name: "Devpoint Labs",
														mascot: "programmers",
														year: "1900")
			expect(school.school_age).to eq('Pretty old')
		end

		it 'return Pretty old if the school year is == 1800' do
			school = School.create(name: "Devpoint Labs",
														mascot: "programmers",
														year: "1800")
			expect(school.school_age).to eq('Pretty old')
		end

		it 'return way old if the school year is < 1800' do
			school = School.create(name: "Devpoint Labs",
														mascot: "programmers",
														year: "1500")
			expect(school.school_age).to eq('Way old')
		end

	end

end
