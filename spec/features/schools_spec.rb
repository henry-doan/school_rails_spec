require 'rails_helper'

#TODO Make dry, factory girl

feature 'Schools Index', js: true do

		context 'With no Schools' do
			before (:each) do
				visit root_path
			end

			scenario 'Header validation' do
				expect(find('.school-header').text.strip).to eq('Schools')
			end
			context 'create a school' do
				before (:each) do
					find('.new-school-btn').click
					@name = 'Test'
					@mascot ='Test'
					@year = 123
					fill_in('school[name]', with: @name)
					fill_in('school[mascot]', with: @mascot)
					fill_in('school[year]', with: @year)
					find('.submit-school-btn').click
				end

				scenario 'school show pg validation' do
					expect(find('.show-header').text.strip).to eq("Showing #{@name} home of the #{@mascot}")
					expect(find('.year-header').text.strip).to eq("Year Built: #{@year}")
				end

				scenario 'back button' do
					find('.school-back').click
					expect(find('.school-header').text.strip).to eq('Schools')
				end

				context 'With Schools' do
					scenario 'Edit school' do
						find('.school-back').click
						find('.school-edit').click
						@new_name = 'Rook'
						@new_mascot ='Koor'
						@new_year = 321
						fill_in('school[name]', with: @new_name)
						fill_in('school[mascot]', with: @new_mascot)
						fill_in('school[year]', with: @new_year)
						find('.submit-school-btn').click
						expect(find('.show-header').text.strip).to eq("Showing #{@new_name} home of the #{@new_mascot}")
						expect(find('.year-header').text.strip).to eq("Year Built: #{@new_year}")
					end

					scenario 'Delete a school' do
						find('.school-back').click
						find('.delete-school-btn').click
						expect(find('.no-school-msg').text.strip).to eq("There Is No School, Go make one!")
					end
				end
			end
		end
end