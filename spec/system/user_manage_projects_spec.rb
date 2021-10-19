require 'rails_helper'

describe "User" do 
    it 'successfully sees plan' do
        #Arrange
        user = User.create!(email: 'jane@doe.com.br', password: '123456')
        Plan.create!(title: 'Projeto X', description: "Projeto X consiste na criação de um site.",
        hability: 'O profissional que pretende colaborar com o Projeto X deve ser pontual e criativo.', 
        value: '200', limit_date: '12/10/2221', user: user)
        Plan.create!(title: 'Projeto Z', description: "Projeto Z consiste na criação de um app.",
        hability: 'O profissional que pretende colaborar com o Projeto Z deve ser esforçado e dedicado.', 
        value: '100', limit_date: '12/10/2224', user: user)
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
        expect(page).to have_button('Voltar')
    end

    it 'sees no project' do
        #Arrange
        user = User.create!(email: 'jane@doe.com.br', password: '123456')
        #Act
        login_as user, scope: :user
        visit plans_path
        #Assert
        expect(page).to have_text('jane@doe.com.br')
        expect(page).to have_text('Não há projeto disponível.')
        expect(current_path).to eq(plans_path)
        expect(page).to have_button('Voltar')
    end

    it 'closes a plan' do
        professional = Professional.create!(email: 'jane@doe.com.br', password: '123456')
        user = User.create!(email: 'user@user.com.br', password: '123456')
        Profile.create!(name: 'John Doe', social_name: 'Jane Doe', background: 'Formada pela Campus Code no programa Treinadev',
                        description: 'Sou uma profissional dedicada e criativa', area: 'Desenvolvimento', professional: professional)
        plan = Plan.create!(title: 'Projeto X', description: "Projeto X consiste na criação de um site.",
                        hability: 'O profissional que pretende colaborar com o Projeto X deve ser pontual e criativo.', 
                        value: '200', limit_date: '12/10/2221', user: user)
        offer = Offer.create!(description: "Estou preparado para tocar esse projeto", professional: professional, value: "100", 
                        hours: '10', finish_date:'13/11/3221' , plan: plan)
 
        login_as user, scope: :user
        visit plans_path
        click_on 'Fechar projeto'
        
        expect(Plan.last.status).to eq('closed')
        expect(page).to have_text('Projeto fechado')
        expect(page).to have_button('Voltar')
    end

    it 'opens a plan' do
        professional = Professional.create!(email: 'jane@doe.com.br', password: '123456')
        user = User.create!(email: 'user@user.com.br', password: '123456')
        Profile.create!(name: 'John Doe', social_name: 'Jane Doe', background: 'Formada pela Campus Code no programa Treinadev',
                        description: 'Sou uma profissional dedicada e criativa', area: 'Desenvolvimento', professional: professional)
        plan = Plan.create!(title: 'Projeto X', description: "Projeto X consiste na criação de um site.",
                        hability: 'O profissional que pretende colaborar com o Projeto X deve ser pontual e criativo.', 
                        value: '200', limit_date: '12/10/2221', user: user, status:'closed')
        offer = Offer.create!(description: "Estou preparado para tocar esse projeto", professional: professional, value: "100", 
                        hours: '10', finish_date:'13/11/3221' , plan: plan)
        
        login_as user, scope: :user
        visit plans_path
        click_on 'Abrir projeto'
        
        expect(Plan.last.status).to eq('open')
        expect(page).to have_text('Projeto aberto')
    end

    it 'delete a plan' do
        professional = Professional.create!(email: 'jane@doe.com.br', password: '123456')
        user = User.create!(email: 'user@user.com.br', password: '123456')
        Profile.create!(name: 'John Doe', social_name: 'Jane Doe', background: 'Formada pela Campus Code no programa Treinadev',
                        description: 'Sou uma profissional dedicada e criativa', area: 'Desenvolvimento', professional: professional)
        plan = Plan.create!(title: 'Projeto X', description: "Projeto X consiste na criação de um site.",
                        hability: 'O profissional que pretende colaborar com o Projeto X deve ser pontual e criativo.', 
                        value: '200', limit_date: '12/10/2221', user: user)
        Offer.create!(description: "Estou preparado para tocar esse projeto", professional: professional, value: "100", 
                        hours: '10', finish_date:'13/11/3221' , plan: plan)
 
        login_as user, scope: :user
        visit plans_path
        click_on 'Deletar projeto'
        
        expect(page).not_to have_text('Projeto X')
        expect(page).not_to have_text('Projeto X consiste na criação de um site.')
        expect(page).not_to have_text('O profissional que pretende colaborar com o Projeto X deve ser pontual e criativo.')
        expect(page).not_to have_text('200')
        expect(page).not_to have_text('12/10/2221')
        expect(page).to have_text('Projeto deletado')
        expect(Plan.count).to eq(0)
        expect(page).to have_button('Voltar')
    end


end