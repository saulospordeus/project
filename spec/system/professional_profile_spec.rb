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
        expect(page).to have_text('Nome: Jane Doe')
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
        expect(page).to have_text('Nome: Jane Doe')
        expect(page).to have_text('Formação: Formada pela Campus Code no curso Treinadev.')
        expect(page).to have_text('Descrição: Sou uma profissional dedicada e criativa.')
        expect(page).to have_text('Área: Desenvolvimento')
        expect(page).to have_text('Perfil preenchido')
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
        expect(page).to have_text('Perfil não pode ser preenchido')
        expect(current_path).to eq(profiles_path)
    end

    it 'must fill profile before navegate' do
        #Arrange
            professional = Professional.create!(email: 'jane@doe.com.br', password: '123456')
        #Act
            login_as professional, scope: :professional
            visit root_path
        #Assert
        expect(page).to have_text("Preencha seu perfil")
    end

    it 'must be logged to create profile' do
        #Arrange
            professional = Professional.create!(email: 'jane@doe.com.br', password: '123456')
        #Act
            visit new_profile_path
        #Assert
        expect(page).to have_text("You need to sign in or sign up before continuing.")
    end

    it 'edit profile' do
        #Arrange
            professional = Professional.create!(email: 'jane@doe.com.br', password: '123456')
            Profile.create!(name: 'John Doe', social_name: 'Jane Doe', background: 'Formada pela Campus Code no programa Treinadev',
            description: 'Sou uma profissional dedicada e criativa', area: 'Desenvolvimento', professional: professional)
        #Act
            login_as professional, scope: :professional
            visit root_path
            click_on "Editar meu perfil"

            fill_in 'Nome', with: 'John Doe'
            fill_in 'Nome Social', with: 'Jane Doe'
            fill_in 'Formação', with: 'Formada pela Universidade Federal da Paraíba.'
            fill_in 'Descrição', with: 'Sou uma profissional entusiasmada e esforçada.'
            fill_in 'Área', with: 'Infraestrutura de Redes'
            click_on 'Enviar'
        #Assert
            expect(page).to have_text('Nome: Jane Doe')
            expect(page).to have_text('Formação: Formada pela Universidade Federal da Paraíba.')
            expect(page).to have_text('Descrição: Sou uma profissional entusiasmada e esforçada.')
            expect(page).to have_text('Área: Infraestrutura de Redes')
            expect(page).to have_text('Perfil editado com sucesso')
            expect(page).not_to have_text('Formação: Formada pela Campus Code no curso Treinadev.')
            expect(page).not_to have_text('Descrição: Sou uma profissional dedicada e criativa.')
            expect(page).not_to have_text('Área: Desenvolvimento')
            expect(current_path).to eq(root_path)
        end

        it 'edit profile' do
        #Arrange
            professional = Professional.create!(email: 'jane@doe.com.br', password: '123456')
            Profile.create!(name: 'John Doe', social_name: 'Jane Doe', background: 'Formada pela Campus Code no programa Treinadev',
            description: 'Sou uma profissional dedicada e criativa', area: 'Desenvolvimento', professional: professional)
        #Act
            login_as professional, scope: :professional
            visit root_path
            click_on "Editar meu perfil"

            fill_in 'Nome', with: 'John Doe'
            fill_in 'Nome Social', with: 'Jane Doe'
            fill_in 'Formação', with: 'Formada pela Universidade Federal da Paraíba.'
            fill_in 'Descrição', with: 'Sou uma profissional entusiasmada e esforçada.'
            fill_in 'Área', with: 'Infraestrutura de Redes'
            click_on 'Enviar'
        #Assert
            expect(page).to have_text('Nome: Jane Doe')
            expect(page).to have_text('Formação: Formada pela Universidade Federal da Paraíba.')
            expect(page).to have_text('Descrição: Sou uma profissional entusiasmada e esforçada.')
            expect(page).to have_text('Área: Infraestrutura de Redes')
            expect(page).to have_text('Perfil editado com sucesso')
            expect(page).not_to have_text('Formação: Formada pela Campus Code no curso Treinadev.')
            expect(page).not_to have_text('Descrição: Sou uma profissional dedicada e criativa.')
            expect(page).not_to have_text('Área: Desenvolvimento')
            expect(current_path).to eq(root_path)
        end
    
    it 'cannot edit without filling all fields' do
    #Arrange
        professional = Professional.create!(email: 'jane@doe.com.br', password: '123456')
        profile = Profile.create!(name: 'John Doe', social_name: 'Jane Doe', background: 'Formada pela Campus Code no programa Treinadev',
        description: 'Sou uma profissional dedicada e criativa', area: 'Desenvolvimento', professional: professional)
    #Act
        login_as professional, scope: :professional
        visit root_path
        click_on "Editar meu perfil"
         fill_in 'Nome', with: 'John Doe'
        fill_in 'Nome Social', with: 'Jane Doe'
        fill_in 'Formação', with: ''
        fill_in 'Descrição', with: 'Sou uma profissional entusiasmada e esforçada.'
        fill_in 'Área', with: 'Infraestrutura de Redes'
        click_on 'Enviar'
    #Assert
        expect(page).not_to have_text('Perfil editado com sucesso')
        expect(page).to have_text('Perfil não foi editado')
        expect(profile.social_name).to eq('Jane Doe')
        expect(profile.description).to eq('Sou uma profissional dedicada e criativa')
        expect(profile.area).to eq('Desenvolvimento')
        expect(profile.background).to eq('Formada pela Campus Code no programa Treinadev')
        expect(profile.description).not_to eq('Sou uma profissional entusiasmada e esforçada.')
        expect(profile.area).not_to eq('Infraestrutura de Redes')
        expect(current_path).not_to eq(root_path)
    end

end