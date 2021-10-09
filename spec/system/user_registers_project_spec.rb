require 'rails_helper'

describe "User register project" do 
    it 'successfuly' do
#Arrange
    user = User.create!(email: 'crazy@doe.com.br', password: '123456')
#Act
    login_as user, scope: :user
    click_on 'Cadastrar projeto'
    fill_in 'Título', with: 'Projeto X'
    fill_in 'Descrição', with: 'Projeto X consiste na criação de um site.'
    fill_in 'Habilidades Desejadas', with: 'O profissional que pretende colaborar com o Projeto X deve ser pontual e criativo.'
    fill_in 'Valor máximo', with: '200'
    fill_in 'Data limite', with: '12/10/2221'
    select 'Remoto', from: 'Atuação'
    click_on 'Cadastrar'
#Assert
    expect(page).to have_text('Título: Projeto X')
    expect(page).to have_text('Descrição: Projeto X consiste na criação de um site.')
    expect(page).to have_text('Habilidades Desejadas: O profissional que pretende colaborar com o Projeto X deve ser pontual e criativo.')
    expect(page).to have_text('Data limite: 12/10/2221')
    expect(page).to have_text('Atução: Remoto')
    expect(page).to have_text('Valor máximo: R$ 200,00')
    expect(current_path).to eq(project_path)
    end
end


