require 'rails_helper'

RSpec.describe Classroom, type: :model do
	let(:classroom) { FactoryGirl.create(:classroom)}
	let(:classroom_lrg) { FactoryGirl.create(:classroom, :lrg )}
	let(:classroom_lrg_eq) { FactoryGirl.create(:classroom, :lrg_eq )}
	let(:classroom_de) { FactoryGirl.create(:classroom, :descent )}
	let(:classroom_de_eq) { FactoryGirl.create(:classroom, :descent_eq )}

  describe 'validations' do
		it { should validate_presence_of :name }
		it { should respond_to :name }
		it { should respond_to :size }
		it { should respond_to :school_id }
		it { should belong_to :school}
	end

	describe '#class_name' do
		it 'returns the name and the message' do
			expect(classroom.class_name).to eq("#{classroom.name} classroom")
		end
	end

	describe '#class_size' do
		it 'return large if the age is > 100' do
			expect(classroom_lrg.class_size).to eq('Large')
		end

		it 'returns large if the age is = 100' do
			expect(classroom_lrg_eq.class_size).to eq('Large')
		end

		it 'returns pretty old if the age is > 50' do
			expect(classroom_de.class_size).to eq('Descent')
		end

		it 'returns pretty old if the age is = 50' do
			expect(classroom_de_eq.class_size).to eq('Descent')
		end

		it 'returns Way old if the age is < 50' do
			expect(classroom.class_size).to eq('Small')
		end


	end
end
