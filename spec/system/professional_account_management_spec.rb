require 'rails_helper'

describe "Account Management" do 
    context 'registration' do
        it 'with email and password' do 
            visit root_path
            click_on "Procuro projetos para mim!"
            fill_in 'Email', with: 'jane@doe.com.br'
            fill_in 'Password', with: '123456'
            fill_in 'Password confirmation', with: '123456'
            click_on 'Sign up'
#TODO TRADUZIR
#TODO FLASH MENSAGEM
            expect(page).to have_text('jane@doe.com.br')
            expect(current_path).to eq(new_profile_path)
            expect(page).to have_link('Logout')
            expect(page).to_not have_link('Sign up')
        end

        it 'must fill all fields' do 
            visit root_path
            click_on "Procuro projetos para mim!"
            fill_in 'Email', with: 'jane@doe.com.br'
            fill_in 'Password', with: '123456'
            fill_in 'Password confirmation', with: ''
            click_on 'Sign up'
    #TODO TRADUZIR
    #TODO FLASH MENSAGEM
            expect(current_path).to eq(professional_registration_path)
            expect(page).to_not have_link('Sign up')
            expect(page).to_not have_text("Password can't be blank")
        end
    end
    context 'sign in' do
        it 'successfully' do
          professional = Professional.create!(email: 'jane@doe.com.br', password: '123456')
          Profile.create!(name: 'John Doe', social_name: 'Jane Doe', background: 'Formada pela Campus Code no programa Treinadev',
          description: 'Sou uma profissional dedicada e criativa', area: 'Desenvolvimento', professional: professional)
          visit root_path
          click_on 'Sign in: como profissional!'
          fill_in 'Email', with: 'jane@doe.com.br'
          fill_in 'Password', with: '123456'
          click_on 'Log in'
          #TODO FLASH MENSAGEM  
          expect(page).to have_text('jane@doe.com.br')
          expect(current_path).to eq(root_path)
          expect(page).to have_link('Logout')
        end
          
        it 'must fill all fields' do 
          Professional.create!(email: 'jane@doe.com.br', password: '123456')
          visit root_path
          click_on 'Sign in: como profissional!'
          fill_in 'Email', with: 'jane@doe.com.br'
          fill_in 'Password', with: ''
          click_on 'Log in'
          expect(page).to_not have_text('jane@doe.com.br')
          expect(current_path).to eq(new_professional_session_path)
          expect(page).to_not have_link('Logout')
        end
    end
end