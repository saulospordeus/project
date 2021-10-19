require 'rails_helper'

describe "professional" do 
    it 'successfuly sees all projects' do
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
        expect(page).to have_button('Voltar')
    end

    it "doesn't have project available" do
        professional = Professional.create!(email: 'jane@doe.com.br', password: '123456')
        Profile.create!(name: 'John Doe', social_name: 'Jane Doe', background: 'Formada pela Campus Code no programa Treinadev',
        description: 'Sou uma profissional dedicada e criativa', area: 'Desenvolvimento', professional: professional)
        
        login_as professional, scope: :professional
        visit root_path
        click_on 'Ver projetos'

        expect(page).to have_text('Não há projeto disponível')
        expect(page).to have_button('Voltar')
    end
    
    it 'successfuly searches for project' do
        #Arrange
        professional = Professional.create!(email: 'jane@doe.com.br', password: '123456')
        user = User.create!(email: 'user@user.com.br', password: '123456')
        Profile.create!(name: 'John Doe', social_name: 'Jane Doe', background: 'Formada pela Campus Code no programa Treinadev',
        description: 'Sou uma profissional dedicada e criativa', area: 'Desenvolvimento', professional: professional)
        Plan.create!(title: 'Super Site', description: "Super Site consiste na criação de um site.", hability: 'O profissional que pretende colaborar com o Super Site deve ser pontual e criativo.', 
        value: '200', limit_date: '12/10/2221', user: user)
        Plan.create!(title: 'Mega App', description: "Mega App consiste na criação de um app.",
        hability: 'O profissional que pretende colaborar com o Mega App deve ser esforçado e dedicado.', 
        value: '100', limit_date: '12/10/2224', user: user)
        #Act
        login_as professional, scope: :professional
        visit root_path
        click_on 'Ver projetos'
        fill_in 'search', with: 'Mega App'
        click_on 'Buscar'

        #Assert
        expect(page).not_to have_text('Super Site')
        expect(page).not_to have_text('Super Site consiste na criação de um site.')
        expect(page).to have_text('Mega App')
        expect(page).to have_text('Mega App consiste na criação de um app.')
        expect(page).to have_button('Voltar')
    end

    it 'sees his projects' do
        professional = Professional.create!(email: 'jane@doe.com.br', password: '123456')
        user = User.create!(email: 'user@user.com.br', password: '123456')
        profile = Profile.create!(name: 'John Doe', social_name: 'Jane Doe', background: 'Formada pela Campus Code no programa Treinadev',
                                description: 'Sou uma profissional dedicada e criativa', area: 'Desenvolvimento', professional: professional)
        plan = Plan.create!(title: 'Projeto X', description: "Projeto X consiste na criação de um site.",
                            hability: 'O profissional que pretende colaborar com o Projeto X deve ser pontual e criativo.', 
                            value: '200', limit_date: '12/10/2221', user: user)
        plan2 = Plan.create!(title: 'Projeto Y', description: "Projeto Y consiste na criação de um app.",
                            hability: 'O profissional que pretende colaborar com o Projeto Y deve ser paciente e inteligente.', 
                            value: '300', limit_date: '14/10/2221', user: user)
        plan3 = Plan.create!(title: 'Projeto Z', description: "Projeto Z consiste na criação de um sistema de infraestrutura.",
                            hability: 'Qualquer profissional serve para o Projeto Z', 
                            value: '400', limit_date: '15/10/2221', user: user)
        offer = Offer.create!(description: "Estou preparado para participar do Projeto X", professional: professional, value: "100", 
                            hours: '10', finish_date:'13/11/3221' , plan: plan)
        offer2 = Offer.create!(description: "Estou interessado em participar do Projeto Y", professional: professional, value: "200", 
                            hours: '10', finish_date:'13/11/3221' , plan: plan2)
        
        
        login_as professional, scope: :professional
        visit root_path
        click_on "Ver meu perfil"

        expect(page).to have_text('Projeto X')
        expect(page).to have_text("Projeto X consiste na criação de um site.")
        expect(page).to have_text('Projeto Y')
        expect(page).to have_text("Projeto Y consiste na criação de um app.")
        expect(page).not_to have_text('Projeto Z')
        expect(page).not_to have_text("Projeto Z consiste na criação de um sistema de infraestrutura.")
    end

    it 'has no project' do
        professional = Professional.create!(email: 'jane@doe.com.br', password: '123456')
        user = User.create!(email: 'user@user.com.br', password: '123456')
        profile = Profile.create!(name: 'John Doe', social_name: 'Jane Doe', background: 'Formada pela Campus Code no programa Treinadev',
                                description: 'Sou uma profissional dedicada e criativa', area: 'Desenvolvimento', professional: professional)
        plan = Plan.create!(title: 'Projeto X', description: "Projeto X consiste na criação de um site.",
                            hability: 'O profissional que pretende colaborar com o Projeto X deve ser pontual e criativo.', 
                            value: '200', limit_date: '12/10/2221', user: user)     
        
        login_as professional, scope: :professional
        visit root_path
        click_on "Ver meu perfil"

        expect(page).not_to have_text('Projeto X')
        expect(page).not_to have_text("Projeto X consiste na criação de um site.")
        expect(page).to have_text('Nenhum projeto disponível.')
    end

end
  
    