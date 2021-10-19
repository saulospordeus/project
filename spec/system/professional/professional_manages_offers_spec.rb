require 'rails_helper'

describe "professional" do 
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
        expect(page).to have_text('Valor por hora: $100.00')
        expect(page).to have_text('Data final: 12/10/2221')
        expect(page).to have_text('Horas: 10')
        expect(page).to have_text('Oferta realizada')
        expect(Offer.last.status).to eq('oferecida')
        expect(page).to have_button('Voltar')
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
        expect(page).to have_text('Oferta não pode ser realizada')
        expect(current_path).to eq(new_plan_offer_path(plan))

    end
    
    it 'cant makes an offer to closed plan' do
        professional = Professional.create!(email: 'jane@doe.com.br', password: '123456')
        user = User.create!(email: 'user@user.com.br', password: '123456')
        Profile.create!(name: 'John Doe', social_name: 'Jane Doe', background: 'Formada pela Campus Code no programa Treinadev',
        description: 'Sou uma profissional dedicada e criativa', area: 'Desenvolvimento', professional: professional)
        plan = Plan.create!(title: 'Projeto X', description: "Projeto X consiste na criação de um site.",
        hability: 'O profissional que pretende colaborar com o Projeto X deve ser pontual e criativo.', 
        value: '200', limit_date: '12/10/2221', user: user)
        
        login_as professional, scope: :professional
        visit plans_path
        expect(page).to have_text('Projeto X')
        expect(page).to have_text('Projeto X consiste na criação de um site.')
        expect(page).not_to have_text('Projeto Y')
        expect(page).not_to have_text('Projeto Y consiste na criação de um app')
    end

    it 'deletes offer' do
        professional = Professional.create!(email: 'jane@doe.com.br', password: '123456')
        user = User.create!(email: 'user@user.com.br', password: '123456')
        profile = Profile.create!(name: 'John Doe', social_name: 'Jane Doe', background: 'Formada pela Campus Code no programa Treinadev',
        description: 'Sou uma profissional dedicada e criativa', area: 'Desenvolvimento', professional: professional)
        plan = Plan.create!(title: 'Projeto X', description: "Projeto X consiste na criação de um site.",
        hability: 'O profissional que pretende colaborar com o Projeto X deve ser pontual e criativo.', 
        value: '200', limit_date: '12/10/2221', user: user)
        offer = Offer.create!(description: "Estou preparado para tocar esse projeto", professional: professional, value: "100", 
        hours: '99', finish_date:'13/11/3221' , plan: plan)
        
        login_as professional, scope: :professional
        visit plan_offers_path(profile)
        click_on 'Deletar oferta'

        expect(page).not_to have_text('Estou preparado para tocar esse projeto X')
        expect(page).not_to have_text('100')
        expect(page).not_to have_text('99')
        expect(page).not_to have_text('13/11/3221')
        expect(Offer.count).to eq(0)
    end

    it 'sees his offers in a project' do
            
            professional = Professional.create!(email: 'jane@doe.com.br', password: '123456')
            professional2 = Professional.create!(email: 'peter@parker.com.br', password: '123456')
            user = User.create!(email: 'user@user.com.br', password: '123456')
            profile = Profile.create!(name: 'John Doe', social_name: 'Jane Doe', background: 'Formada pela Campus Code no programa Treinadev',
                                    description: 'Sou uma profissional dedicada e criativa', area: 'Desenvolvimento', professional: professional)
            profile2 = Profile.create!(name: 'Peter Parker', social_name: 'Peter Parker', background: 'Formada na NYU',
                                    description: 'Profissional frequentemente atrasado', area: 'Segurança de sistemas', professional: professional2)                        
            plan = Plan.create!(title: 'Projeto X', description: "Projeto X consiste na criação de um site.",
                                hability: 'O profissional que pretende colaborar com o Projeto X deve ser pontual e criativo.', 
                                value: '200', limit_date: '12/10/2221', user: user)
            offer = Offer.create!(description: "Estou preparado para participar do Projeto X", professional: professional, value: "100", 
                                hours: '10', finish_date:'13/11/3221' , plan: plan)
            offer2 = Offer.create!(description: "Estou interessado em participar", professional: professional2, value: "200", 
                                hours: '20', finish_date:'15/11/2221' , plan: plan)
            
            
            login_as professional, scope: :professional
            visit root_path
            click_on "Ver meu perfil"
            click_on "Projeto X"
    
            expect(page).to have_text('Projeto X')
            expect(page).to have_text("Estou preparado para participar do Projeto X")
            expect(page).to have_text("Valor: $100.00")
            expect(page).to have_text("Horas: 10")
            expect(page).to have_text("Data final: 13/11/3221")
            expect(page).to have_text("Status: oferecida")
            expect(page).not_to have_text("Estou interessado em participar")
            expect(page).not_to have_text("Valor: $200.00")
            expect(page).not_to have_text("Horas: 20")
       end

end