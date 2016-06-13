require 'rails_helper'

feature 'Navbar', js: true do
	scenario 'main logo lead to root path' do
		visit new_school_path
		first('.brand-logo').click
		expect(first('.school-header').text).to eq('Schools')
	end

	scenario 'school button shows all school' do
		visit root_path
		find('.school-back').click
		expect(first('.school-header').text).to eq('Schools')
	end

end