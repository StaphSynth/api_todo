require 'spec_helper'
require 'rails_helper'

describe Api::V1::TasksController, type: :controller do
  let!(:tasks) { Array.new(10) { create(:task) } }

  describe '#index' do
    subject { get :index }

    it 'responds 200' do
      subject
      expect(response).to be_successful
    end

    it 'returns all tasks in JSON' do
      subject
      expect(JSON.parse(response.body).fetch('tasks').count).to eq(tasks.count)
    end
  end

  describe '#create' do
    describe 'when everything is okay' do
      task = { 'text' => 'cool task', 'priority' => 'low', 'complete' => false }
      subject { post :create, params: { _json: task } }

      it 'returns the created task as JSON' do
        subject
        expect(JSON.parse(response.body).fetch('task')).to eq(task)
      end

      it 'saves the created task to the DB' do
        total_tasks = Task.count
        subject
        expect(Task.count).to eq(total_tasks + 1)
      end
    end

    describe 'when the request is missing attributes' do
      task = { 'priority' => 'low', 'complete' => false }
      subject { post :create, params: { _json: task } }

      it 'handles the error' do
        subject
        expect(response).not_to be_successful
      end

      it 'provides the reasons it was unable to save' do
        subject
        errors = JSON.parse(response.body).fetch('message')
        expect(errors).to be_a(Hash)
      end
    end
  end
end
