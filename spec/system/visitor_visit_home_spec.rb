require 'rails_helper'

describe 'Visitor visit homepage' do
  it 'successfully' do
    #arrange
    #act
    visit root_path
    #assert
    expect(page).to have_text('P&P')
    expect(page).to have_text('Bem vindo ao sistema que aproxima pessoas de projetos')
  end
end