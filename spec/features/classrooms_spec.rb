require 'rails_helper'

#TODO Make dry, factory girl

feature 'Schools Index', js: true do
	before (:each) do
		visit root_path
		find('.new-school-btn').click
		@name = 'Test'
		@mascot ='Test'
		@year = 123
		fill_in('school[name]', with: @name)
		fill_in('school[mascot]', with: @mascot)
		fill_in('school[year]', with: @year)
		find('.submit-school-btn').click
		find('.index-classroom-btn').click
	end

	context 'With no Schools' do
		scenario 'Class Header Vaildation' do
			expect(find('.classroom-header').text.strip).to eq('Classrooms')
		end

		scenario 'No classroom message' do
			expect(find('.no-class-msg').text.strip).to eq("There Is No classroom, Go make one!")
		end

		context 'made class' do
			before (:each) do
				find('.new-classroom').click
				@name = 'Test'
				@size = 42
				fill_in('classroom[name]', with: @name)
				fill_in('classroom[size]', with: @size)
				find('.submit-classroom-btn').click
			end
		
			scenario 'Header Vaildation' do
				expect(find('.classroom-header').text.strip).to eq("Showing #{@name} size of #{@size}")
			end

			scenario 'back button' do
				find('.class-back').click
				expect(find('.classroom-header').text.strip).to eq("Classrooms")
			end

			context 'Delete' do
				before (:each) do
					find('.class-delete').click
				end

				#TODO find out if we can use an if else statement
				# If there are classes the one deleted should be nil
				# If there are no classes should display no class message
				scenario 'Delete the class and still some left' do
					expect(find('.no-class-msg').text.strip).to eq("There Is No classroom, Go make one!")
				end

				# scenario 'No class left in the system' do
				# 	expect(find('.')).to eq(nil)
				# end
			end

			scenario 'Edit' do
				find('.edit-class').click
				@new_name = 'Tset'
				@new_size = 24
				fill_in('classroom[name]', with: @new_name)
				fill_in('classroom[size]', with: @new_size)
				find('.submit-classroom-btn').click
				expect(find('.classroom-header').text.strip).to eq("Showing #{@new_name} size of #{@new_size}")
			end

		end
	end

end