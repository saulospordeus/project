require 'rails_helper'

describe "Account Management" do 
    context 'registration' do
        it 'with email and password' do 
            visit root_path
            click_on "Procuro pessoas para meu projeto!"
            fill_in 'Email', with: 'jane@doe.com.br'
            fill_in 'Password', with: '123456'
            fill_in 'Password confirmation', with: '123456'
            click_on 'Sign up'
        
        expect(page).to have_text('jane@doe.com.br')
        expect(current_path).to eq(root_path)
        expect(page).to have_link('Logout')
        expect(page).to_not have_link('Sign up')
    end
    
        it 'must fill all fields' do 
            visit root_path
            click_on "Procuro pessoas para meu projeto!"
            fill_in 'Email', with: 'jane@doe.com.br'
            fill_in 'Password', with: '123456'
            fill_in 'Password confirmation', with: ''
            click_on 'Sign up'
        
            expect(current_path).to eq(user_registration_path)
            expect(page).to_not have_link('Sign up')
            expect(page).to_not have_text("Password can't be blank")
        end
    end
    context 'sign in' do
        it 'successfully' do
          user = User.create!(email: 'jane@doe.com.br', password: '123456')
          visit root_path
          click_on 'Sign in: como dono de um projeto!'
          fill_in 'Email', with: 'jane@doe.com.br'
          fill_in 'Password', with: '123456'
          click_on 'Log in'
    
          expect(page).to have_text('jane@doe.com.br')
          expect(current_path).to eq(root_path)
          expect(page).to have_link('Logout')
        end
          
        it 'must fill all fields' do 
            user = User.create!(email: 'jane@doe.com.br', password: '123456')
            visit root_path
            click_on 'Sign in: como dono de um projeto!'
            fill_in 'Email', with: 'jane@doe.com.br'
            click_on 'Log in'

            expect(page).to_not have_text('jane@doe.com.br')
            expect(current_path).to eq(new_user_session_path)
            expect(page).to_not have_link('Logout')
        end
    end
end