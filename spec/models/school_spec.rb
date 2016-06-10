require 'rails_helper'

RSpec.describe School, type: :model do
	let(:school) { FactoryGirl.create(:school)}
	let(:one_school) { FactoryGirl.create(:school, :one)}
	let(:two_school) { FactoryGirl.create(:school, :two)}
	let(:three_school) { FactoryGirl.create(:school, :three)}
	let(:four_school) { FactoryGirl.create(:school, :four)}

	describe 'validations' do
		it { should validate_presence_of :name }
		it { should validate_presence_of :mascot }
		it { should validate_presence_of :year }
	end

	describe '#name_mascot' do
		it 'returns the name and mascot message' do
			expect(school.name_mascot).to eq("#{school.name} home of the #{school.mascot}")
		end
	end

	describe '#school_age' do
		it 'returns new if the school year is > 2000' do
			expect(school.school_age).to eq('New')
		end

		it 'returns new if the school year is == 2000' do
			expect(one_school.school_age).to eq('New')
		end

		it 'return Pretty old if the school year is > 1800' do
			expect(two_school.school_age).to eq('Pretty old')
		end

		it 'return Pretty old if the school year is == 1800' do
			expect(three_school.school_age).to eq('Pretty old')
		end

		it 'return way old if the school year is < 1800' do
			expect(four_school.school_age).to eq('Way old')
		end

	end

end
