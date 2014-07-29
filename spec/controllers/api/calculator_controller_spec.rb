require 'rails_helper'

describe Api::CalculatorController do
  render_views

  context '#create' do
    it 'should send response as calculator created' do
      post :create
      expect(response.status).to eq(201)
    end

    it 'should create calculator' do
      post :create
      expect(Calculator.count).to eq(1)
    end

    it 'should send response as 200 in case calculator exist' do
      post :create
      post :create
      expect(response.status).to eq(200)
    end

    it 'should create only one calculator' do
      post :create
      post :create
      expect(Calculator.count).to eq(1)
    end
  end

  context '#update' do
    it 'should send 404 if calculator do not exist' do
      post :update, :command => "add 5"
      expect(response.status).to eq(404)
    end

    it "should send 400 if command is nil" do
      post :create
      post :update
      expect(response.status).to eq(400)
    end

    it "should send 422-unprocessible_entity if command is incorrect" do
      post :create
      post :update, :command => "addition 5"
      expect(response.status).to eq(422)
    end

    it 'should do addition' do
      post :create
      put :update, :command => "add 5"
      expect(response.status).to eq(200)
      expect(response.body).to eq({:result => 5.0}.to_json)
    end
  end

end