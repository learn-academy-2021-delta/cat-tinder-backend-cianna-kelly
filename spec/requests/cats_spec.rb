require 'rails_helper'

RSpec.describe "Cats", type: :request do
  describe "GET /index" do
    it "gets a list of cats" do
      Cat.create name:'Ketchup', age:3, enjoys:'Sitting on peoples chest'
      get'/cats'

      cat = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(cat.length).to eq 1
    end
  end
  describe "POST /create" do
    it "creates a cat" do
      cat_params = {
        cat: {
          name: 'Milo',
          age: 1,
          enjoys: 'Drink dirty dish water'
        }
      }

      post '/cats', params: cat_params

      expect(response).to have_http_status(200)
  
      cat = Cat.first
  
      expect(cat.name).to eq 'Milo'
    end
  end
    describe "PATCH /update" do
      it "updates a cat" do
        cat_params = {
          cat: {
            name:'Sassy',
            age:7,
            enjoys:'traveling with her dog friends'
          }
        }
        post '/cats', params: cat_params
        cat = Cat.first
        updated_cat_params = {
          cat: {
            name:'Sassy',
            age:8,
            enjoys:'traveling with her dog friends'
          }
        }
        patch "/cats/#{cat.id}", params: updated_cat_params
        cat = Cat.first
        expect(response).to have_http_status(200)
        expect(cat.age).to eq 8
    end
  end
  describe "DELETE /destroy" do
    it 'deletes a cat' do
      cat_params = {
        cat: {
          name: 'Cat',
          age: 2,
          enjoys: 'Eats breakfast at Tiffanys'
        }
      }
      post '/cats', params: cat_params
      cat = Cat.first
      delete "/cats/#{cat.id}"
      expect(response).to have_http_status(200)
      cats = Cat.all
      expect(cats).to be_empty
    end
  end

  describe 'cat validation error codes' do
    it 'does not create a cat with a name' do
      cat_params = {
        cat: {
          age: 2,
          enjoys: 'Napping all day'
        }
      }
      post '/cats', params: cat_params
      expect(response.status).to eq 422
      cat = JSON.parse(response.body)
      expect(cat['name']).to include "can't be blank"
    end
    it 'does not create a cat with an age' do
      cat_params = {
        cat: {
          name: 'Cat',
          enjoys: 'Napping all day'
        }
      }
      post '/cats', params: cat_params
      expect(response).to have_http_status(422)
      cat = JSON.parse(response.body)
      expect(cat['age']).to include "can't be blank"
    end
    it 'does not create a cat with an enjoys' do
      cat_params = {
        cat: {
          name: 'Toast',
          age: 3
        }
      }
      post '/cats', params: cat_params
      expect(response).to have_http_status(422)
      cat = JSON.parse(response.body)
      expect(cat['enjoys']).to include "can't be blank"
    end
  end
end
