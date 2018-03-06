require 'spec_helper'
require 'rails_helper'

describe Api::V1::TasksController, type: :controller do
  let!(:tasks) { create_list(:task, 10) }

  describe '#index' do
    it 'returns all tasks in JSON' do
      get :index

      expect(response).to be_successful
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
        expect(response.status).to eq(406)
        expect(JSON.parse(response.body).fetch('status')).to eq('error')
      end

      it 'provides the reasons it was unable to save' do
        subject
        errors = JSON.parse(response.body).fetch('message')
        expect(errors).to be_a(Hash)
      end
    end
  end

  describe '#destroy' do
    let(:task) { Task.first }
    subject { delete :destroy, params: { id: task.id } }

    context 'the happy path' do
      it 'successfully destroys the task' do
        total_tasks = Task.count
        subject
        expect(Task.count).to eq(total_tasks - 1)
      end
    end

    context 'on failure to destroy' do
      it 'correctly handles the error' do
        allow(Task).to receive(:find).and_return(task)
        allow(task).to receive(:errors).and_return({})
        allow(task).to receive(:destroy).and_return(false)

        subject
        expect(response.status).to eq(500)
        expect(JSON.parse(response.body).fetch('status')).to eq('error')
      end
    end
  end

  describe '#show' do
    let(:task) { Task.first }
    subject { get :show, params: { id: task.id } }

    context 'when the task exists' do
      it 'returns the task as JSON' do
        subject

        expect(response).to be_successful
        expect(JSON.parse(response.body).fetch('task').fetch('text')).to eq(task.text)
      end
    end

    context 'when the task does not exist' do
      it 'returns "not found"' do
        allow(Task).to receive(:find).and_raise(ActiveRecord::RecordNotFound)
        subject

        expect(response.status).to eq(404)
        expect(JSON.parse(response.body).fetch('status')).to eq('error')
      end
    end
  end

  describe '#update' do
    let(:task) { Task.first }

    context 'when the update succeeds' do
      it 'successfully updates the task' do
        put :update, params: { text: 'cool update', id: task.id }

        expect(response).to be_successful
        expect(JSON.parse(response.body).fetch('status')).to eq('success')
        expect(task.reload.text).to eq('cool update')
      end
    end

    context 'when the update fails' do
      context 'when passing invalid param values' do
        it 'returns 406 not acceptable with reasons' do
          put :update, params: { text: 'cool update', priority: 'poor choice', id: task.id }

          expect(response.status).to eq(406)
          expect(JSON.parse(response.body).fetch('message')).to be_a(Hash)
        end
      end

      context 'when an unknown error occurs' do
        it 'returns 500' do
          allow(Task).to receive(:find).and_return(task)
          allow(task).to receive(:update_attributes).and_return(false)

          put :update, params: { id: task.id }
          expect(response.status).to eq(500)
        end
      end
    end
  end
end
