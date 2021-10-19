require 'rails_helper'

describe "user" do 
    it 'views professionals profile' do
        professional = Professional.create!(email: 'jane@doe.com.br', password: '123456')
        user = User.create!(email: 'user@user.com.br', password: '123456')
        profile = Profile.create!(name: 'John Doe', social_name: 'Jane Doe', background: 'Formada pela Campus Code no programa Treinadev',
                        description: 'Sou uma profissional dedicada e criativa', area: 'Desenvolvimento', professional: professional)
        plan = Plan.create!(title: 'Projeto X', description: "Projeto X consiste na criação de um site.",
                        hability: 'O profissional que pretende colaborar com o Projeto X deve ser pontual e criativo.', 
                        value: '200', limit_date: '12/10/2221', user: user)
        offer = Offer.create!(description: "Estou preparado para tocar esse projeto", professional: professional, value: "100", 
                        hours: '10', finish_date:'13/11/3221' , plan: plan)

        login_as user, scope: :user
        visit plan_offers_path(plan)
        click_on 'Ver perfil'

        expect(page).to have_text('Nome: Jane Doe')
        expect(page).to have_text('Formação: Formada pela Campus Code no programa Treinadev')
        expect(page).to have_text('Descrição: Sou uma profissional dedicada e criativa')
        expect(page).to have_text('Área: Desenvolvimento')
        expect(page).to have_text('Projetos que participou ou fez oferta:')
        expect(page).to have_text('Projeto X')
        expect(page).to have_button('Voltar')
    end

       
end