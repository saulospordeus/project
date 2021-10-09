require 'rails_helper'

describe "User sees plans" do 
    it 'successfully' do
        #Arrange
        user = User.create!(email: 'jane@doe.com.br', password: '123456')
        plan = Plan.create!(title: 'Projeto X', description: "Projeto X consiste na criação de um site.",
    hability: 'O profissional que pretende colaborar com o Projeto X deve ser pontual e criativo.', 
    value: '200', limit_date: '12/10/2221')
        plan = Plan.create!(title: 'Projeto Z', description: "Projeto Z consiste na criação de um app.",
    hability: 'O profissional que pretende colaborar com o Projeto Z deve ser esforçado e dedicado.', 
    value: '100', limit_date: '12/10/2224')
        #Act
        login_as user, scope: :user
        visit root_path
        click_on 'Ver seus projetos'
        #Assert
        expect(page).to have_text('jane@doe.com.br')
        expect(page).to have_text('Projeto X')
        expect(page).to have_text('Projeto X consiste na criação de um site.')
        expect(page).to have_text('Projeto Z')
        expect(page).to have_text('Projeto Z consiste na criação de um app.')
        expect(current_path).to eq(plans_path)
    end
end