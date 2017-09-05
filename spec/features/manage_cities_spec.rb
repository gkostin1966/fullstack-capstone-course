require 'rails_helper'

RSpec.feature "ManageCities", type: :feature, :js=>true do
  include_context 'db_cleanup_each'
  CITY_FORM_CSS='body > div > div > div > div > form'
  CITY_FORM_XPATH="//h3[text()='Cities']/../form"
  CITY_LIST_XPATH="//h3[text()='Cities']/../ul"

  # feature == context
  feature 'view existing Cities' do
    let(:cities) { (1..5).map{ FactoryGirl.create(:city) }.sort_by {|v| v['name']} }

    # scenario == it
    scenario 'when no instance exist' do
      visit root_path
      within(:xpath, CITY_LIST_XPATH) do #<== waits for ul tag
        expect(page).to have_no_css 'li' #<== waits for ul li tag
        expect(page).to have_css('li', count:0) #<== waits for ul li tag
        expect(all('ul li').size).to eq(0) #<== no wait
      end
    end
    scenario 'when instances exist' do
      visit root_path if cities #need to touch collection before hitting page
      within(:xpath, CITY_LIST_XPATH) do #<== waits for ul tag
        # expect(page).to have_no_css 'li' #<== waits for ul li tag
        expect(page).to have_css("li:nth-child(#{cities.count})") #<== waits for li(5)
        expect(page).to have_css('li', count:cities.count) #<== waits for only 5 li elements
        expect(all('li').size).to eq(cities.count) #<== no wait
        cities.each_with_index do |city, idx|
          expect(page).to have_css("li:nth-child(#{idx+1})", text: city.name)
        end
      end
    end
  end

  feature 'add new City' do
    scenario 'has input form'
    scenario 'complete form'
  end

  feature 'with existing City' do
    scenario 'can be updated'
    scenario 'can be deleted'
  end
end
