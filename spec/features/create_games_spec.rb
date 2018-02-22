require 'rails_helper.rb'


feature 'Creating Games' do
  scenario 'can create game' do
    #visit root route
    visit '/'
    #click create game link
    click_link 'Add Game'
    #fill in forms with info
    fill_in 'Title', with: 'title'
    fill_in 'Description', with: 'decription'

    click_button 'Create Game'

    expect(page).to have_content('title')
  end
end