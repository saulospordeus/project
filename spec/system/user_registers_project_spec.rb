require 'rails_helper'

describe "User register project" do 
    it 'successfuly' do
#Arrange
    user = User.create!(email: 'crazy@doe.com.br', password: '123456')
#Act
    login_as user, scope: :user
    visit root_path
    click_on 'Cadastrar projeto'
    fill_in 'Título', with: 'Projeto X'
    fill_in 'Descrição', with: 'Projeto X consiste na criação de um site.'
    fill_in 'Habilidades desejadas', with: 'O profissional que pretende colaborar com o Projeto X deve ser pontual e criativo.'
    fill_in 'Valor máximo', with: '200'
    fill_in 'Data limite', with: '12/10/2221'
    select 'Remota', from: 'Atuação'
    click_on 'Cadastrar'
#Assert
    expect(page).to have_text('Título: Projeto X')
    expect(page).to have_text('Descrição: Projeto X consiste na criação de um site.')
    expect(page).to have_text('Habilidades desejadas: O profissional que pretende colaborar com o Projeto X deve ser pontual e criativo.')
    expect(page).to have_text('Data limite: 2221-10-12') #TODO FORMATO DA DATA
    expect(page).to have_text('Atuação: Remota')
    expect(page).to have_text('Valor máximo: 200.0') #TODO FORMATO DINHEIRO
    expect(current_path).to eq(plans_path)
    end
end


