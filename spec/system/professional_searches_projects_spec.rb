require 'rails_helper'

describe "professional search for projects'" do 
    it 'successfuly' do
        #Arrange
        professional = Professional.create!(email: 'jane@doe.com.br', password: '123456')
        user = User.create!(email: 'user@user.com.br', password: '123456')
        Profile.create!(name: 'John Doe', social_name: 'Jane Doe', background: 'Formada pela Campus Code no programa Treinadev',
        description: 'Sou uma profissional dedicada e criativa', area: 'Desenvolvimento', professional: professional)
        Plan.create!(title: 'Projeto X', description: "Projeto X consiste na criação de um site.",
        hability: 'O profissional que pretende colaborar com o Projeto X deve ser pontual e criativo.', 
        value: '200', limit_date: '12/10/2221', user: user)
        Plan.create!(title: 'Projeto Z', description: "Projeto Z consiste na criação de um app.",
        hability: 'O profissional que pretende colaborar com o Projeto Z deve ser esforçado e dedicado.', 
        value: '100', limit_date: '12/10/2224', user: user)
        #Act
        login_as professional, scope: :professional
        visit root_path
        click_on 'Ver projetos'
        #Assert
        expect(page).to have_text('Projeto X')
        expect(page).to have_text('Projeto X consiste na criação de um site.')
        expect(page).to have_text('Projeto Z')
        expect(page).to have_text('Projeto Z consiste na criação de um app.')
    end

    it "doesn't have project available" do
        professional = Professional.create!(email: 'jane@doe.com.br', password: '123456')
        Profile.create!(name: 'John Doe', social_name: 'Jane Doe', background: 'Formada pela Campus Code no programa Treinadev',
        description: 'Sou uma profissional dedicada e criativa', area: 'Desenvolvimento', professional: professional)
        
        login_as professional, scope: :professional
        visit root_path
        click_on 'Ver projetos'

        expect(page).to have_text('Não há projeto disponível')
    end
end
  
    