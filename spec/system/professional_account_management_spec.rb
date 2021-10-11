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
            expect(current_path).to eq(root_path)
            expect(page).to have_link('Logout')
            expect(page).to_not have_link('Sign up')
            expect(page).to_not have_link('login')
        end
    end
end