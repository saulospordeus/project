require 'rails_helper'

describe "professional makes offer" do 
    it 'successfuly makes an offer' do
        professional = Professional.create!(email: 'jane@doe.com.br', password: '123456')
        user = User.create!(email: 'user@user.com.br', password: '123456')
        Profile.create!(name: 'John Doe', social_name: 'Jane Doe', background: 'Formada pela Campus Code no programa Treinadev',
        description: 'Sou uma profissional dedicada e criativa', area: 'Desenvolvimento', professional: professional)
        plan = Plan.create!(title: 'Projeto X', description: "Projeto X consiste na criação de um site.",
        hability: 'O profissional que pretende colaborar com o Projeto X deve ser pontual e criativo.', 
        value: '200', limit_date: '12/10/2221', user: user)
        
        login_as professional, scope: :professional
        visit plans_path
        click_on 'Fazer uma oferta.'
        
        fill_in 'Descrição', with: 'Estou apto a trabalhar nesse projeto.'
        fill_in 'Valor por hora', with: '100'
        fill_in 'Horas', with: '10'
        fill_in 'Data final', with: '12/10/2221'
        click_on 'Ofertar'

        expect(page).to have_text('Projeto: Projeto X')
        expect(page).to have_text('Valor por hora: 100')
        expect(page).to have_text('Data final: 2221-10-12')
        expect(page).to have_text('Horas: 10')
        expect(Offer.last.status).to eq('offered')
    end

    it 'must fill all fields' do
        professional = Professional.create!(email: 'jane@doe.com.br', password: '123456')
        user = User.create!(email: 'user@user.com.br', password: '123456')
        Profile.create!(name: 'John Doe', social_name: 'Jane Doe', background: 'Formada pela Campus Code no programa Treinadev',
        description: 'Sou uma profissional dedicada e criativa', area: 'Desenvolvimento', professional: professional)
        plan = Plan.create!(title: 'Projeto X', description: "Projeto X consiste na criação de um site.",
        hability: 'O profissional que pretende colaborar com o Projeto X deve ser pontual e criativo.', 
        value: '200', limit_date: '12/10/2221', user: user)
        
        login_as professional, scope: :professional
        visit new_plan_offer_path(plan)
             
        click_on 'Ofertar'

        expect(page).not_to have_text('Projeto: Projeto X')
        expect(current_path).to eq(new_plan_offer_path(plan))

        #TODO EXPECT FLASH ALERT
    end
end