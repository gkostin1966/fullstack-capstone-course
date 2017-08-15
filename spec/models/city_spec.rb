require 'rails_helper'

RSpec.describe City, type: :model do
  before(:all) { described_class.delete_all }
  after(:each) { described_class.delete_all }

  describe '#create' do
    subject { described_class.create }
    it 'creates a described_class' do
      expect(described_class.find(subject.id)).to eq(subject)
    end
  end

  describe '#name' do
    subject { described_class.create(name: 'name') }
    it 'has a name attribute' do
      expect(subject).to be_valid
      expect(subject.name).not_to be_nil
      expect(subject.name).to eq('name')
    end
  end
end
