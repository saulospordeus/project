require 'rails_helper'

describe "professional" do 
    it 'sees his profile' do
        #Arrange
        professional = Professional.create!(email: 'jane@doe.com.br', password: '123456')
        Profile.create!(name: 'John Doe', social_name: 'Jane Doe', background: 'Formada pela Campus Code no programa Treinadev',
        description: 'Sou uma profissional dedicada e criativa', area: 'Desenvolvimento', professional: professional)
        login_as professional, scope: :professional
        visit root_path
        #Assert
        expect(page).to have_text('Nome social: Jane Doe')
        expect(page).to have_text('Formação: Formada pela Campus Code no programa Treinadev')
        expect(page).to have_text('Descrição: Sou uma profissional dedicada e criativa')
        expect(page).to have_text('Área: Desenvolvimento')
        expect(current_path).to eq(root_path)
    end

    it 'fill in successfuly' do
    #Arrange
        professional = Professional.create!(email: 'jane@doe.com.br', password: '123456')
    #Act
        login_as professional, scope: :professional
        visit new_profile_path
        fill_in 'Nome', with: 'John Doe'
        fill_in 'Nome Social', with: 'Jane Doe'
        fill_in 'Formação', with: 'Formada pela Campus Code no curso Treinadev.'
        fill_in 'Descrição', with: 'Sou uma profissional dedicada e criativa.'
        fill_in 'Área', with: 'Desenvolvimento'
        click_on 'Enviar'
    #Assert
        expect(page).to have_text('Nome social: Jane Doe')
        expect(page).to have_text('Formação: Formada pela Campus Code no curso Treinadev.')
        expect(page).to have_text('Descrição: Sou uma profissional dedicada e criativa.')
        expect(page).to have_text('Área: Desenvolvimento')
        expect(current_path).to eq(root_path)
    end
    
    it 'cannot be blank' do
    #Arrange
        professional = Professional.create!(email: 'jane@doe.com.br', password: '123456')
    #Act
        login_as professional, scope: :professional
        visit new_profile_path
        fill_in 'Nome', with: 'John Doe'
        fill_in 'Nome Social', with: ''
        fill_in 'Formação', with: 'Formada pela Campus Code no curso Treinadev.'
        fill_in 'Descrição', with: 'Sou uma profissional dedicada e criativa.'
        fill_in 'Área', with: 'Desenvolvimento'
        click_on 'Enviar'
    #Assert
        expect(page).to_not have_text('Nome social: Jane Doe')
        expect(page).to_not have_text('Formação: Formada pela Campus Code no curso Treinadev.')
        expect(current_path).to eq(profiles_path)
    end

    it 'must fill profile before navegate' do
        #Arrange
            professional = Professional.create!(email: 'jane@doe.com.br', password: '123456')
        #Act
            login_as professional, scope: :professional
        #Assert
            expect(current_path).to eq(new_profile_path)
        end

end