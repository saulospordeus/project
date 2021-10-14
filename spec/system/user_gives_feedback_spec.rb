require 'rails_helper'
    
describe "user" do 
    it 'successfully view an offer' do
        user = User.create!(email: 'user@user.com.br', password: '123456')
        professional = Professional.create!(email: 'jane@doe.com.br', password: '123456')
        Profile.create!(name: 'John Doe', social_name: 'Jane Doe', background: 'Formada pela Campus Code no programa Treinadev',
                        description: 'Sou uma profissional dedicada e criativa', area: 'Desenvolvimento', professional: professional)
        plan = Plan.create!(title: 'Projeto X', description: "Projeto X consiste na criação de um site.",
                        hability: 'O profissional que pretende colaborar com o Projeto X deve ser pontual e criativo.', 
                        value: '200', limit_date: '12/10/2221', user: user)
        
        login_as user, scope: :user

        visit plans_path
        click_on 'Avaliar profissional'
        fill_in 'Texto', with: 'Jane Doe trabalhou bem.'
        fill_in 'Nota', with: '4'
        fill_in 'Password confirmation', with: '123456'
        click_on 'Enviar'

    #expect(current_path).to eq(user_registration_path)
    expect(page).to have_text('Jane Doe')
    expect(page).to have_text('Nota: 4')
    expect(page).to have_text('Jane Doe trabalhou bem.')
    end
end
