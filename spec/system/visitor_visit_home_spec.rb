require 'rails_helper'

describe 'Visitor visit homepage' do
  it 'successfully' do
    #arrange
    #act
    visit root_path
    #assert
    expect(page).to have_css('h1', text: 'P&P')
    expect(page).to have_css('h3', text: 'Boas vindas ao sistema que aproxima pessoas de projetos')
  end
end