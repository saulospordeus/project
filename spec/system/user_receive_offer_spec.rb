require 'rails_helper'

describe "user" do 
    it 'successfully view an offer' do
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
        click_on 'Ver oferta'
        
        expect(page).to have_text('Horas: 10')
        expect(page).to have_text('Data final: 3221-11-13')
        expect(page).to have_text('Valor por hora: 100.0')
        expect(Offer.last.status).to eq('offered')
    end

    it 'accepts an offer' do
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
        click_on 'Ver oferta'
        click_on 'Aceitar oferta'
        
        expect(page).to have_text('Horas: 10')
        expect(page).to have_text('Data final: 3221-11-13')
        expect(page).to have_text('Valor por hora: 100.0')
        expect(Offer.last.status).to eq('accepted')
    end

    it 'refuses an offer' do
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
        click_on 'Ver oferta'
        click_on 'Recusar oferta'
        
        expect(page).to have_text('Horas: 10')
        expect(page).to have_text('Data final: 3221-11-13')
        expect(page).to have_text('Valor por hora: 100.0')
        expect(Offer.last.status).to eq('refused')
    end
   
end